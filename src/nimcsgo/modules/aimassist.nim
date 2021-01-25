import base, random, options, json, std/jsonutils, os, tables


type Config = object
  maxScale: float32
  minScale: float32
  scaleFactorMin: float32
  scaleFactorMax: float32
  startFov: float32


var gInMemConfiguration: Table[WeaponId, Config]
var gPtrCurrentWeapon: ptr Entity
var gCfgEnabled: bool = true
randomize()


let configFilePath = getConfigDir() & "nimcsgo_aimassist.json" 

proc saveConfig*() =
  var file = configFilePath.open(fmWrite)

  var json = newJObject()
  for key, val in gInMemConfiguration:
    json.add($key, val.toJson())
  file.write(pretty json)
  file.close()

proc loadConfig*() = 
  if fileExists(configFilePath):
    let json = parseFile(configFilePath)
    for key, val in json:
      gInMemConfiguration[key.fromStr()] = val.to(Config)
loadConfig()

proc getConfig(weaponId: WeaponId): var Config = gInMemConfiguration[weaponId]

proc currentConfig(): Config = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  gInMemConfiguration[if gPtrCurrentWeapon.weaponId() in ACTUAL_USED_WEAPONS: gPtrCurrentWeapon.weaponId() else: wiNone]

proc cfgStartFov: float32 = currentConfig().startFov
proc cfgMinScale: float32 = currentConfig().minScale
proc cfgMaxScale: float32 = currentConfig().maxScale
proc cfgScaleFactorMin: float32 = currentConfig().scaleFactorMin
proc cfgScaleFactorMax: float32 = currentConfig().scaleFactorMax



proc centerText(text: string) {.inline.} = 
  let fontSize = igGetFontSize() * text.len.float32 / 2
  igSameLine(igGetWindowWidth() / 2 - fontSize + (fontSize / 2))

proc settingsForWeapon(weaponId: WeaponId) =

  igText("Start FoV")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##startFov", getConfig(weaponId).startFov.addr, 1.0, 90.0)

  igSpacing()

  igText("Minimum Scale")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##minScale", getConfig(weaponId).minScale.addr, 0.0, getConfig(weaponId).maxScale)

  igSpacing()

  igText("Maximum Scale")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##maxScale", getConfig(weaponId).maxScale.addr, getConfig(weaponId).minScale, 1.0)

  igSpacing()

  igText("Minimum Scale Factor")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##minScaleFactor", getConfig(weaponId).scaleFactorMin.addr, 0.0, getConfig(weaponId).scaleFactorMax)

  igSpacing()

  igText("Maximum Scale Factor")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##maxScaleFactor", getConfig(weaponId).scaleFactorMax.addr, getConfig(weaponId).scaleFactorMin, 3.0)

  igSpacing()


proc getBestEntity(pLocalPlayer: ptr Entity, viewAngles: QAngle, fovOut: var float32, distOut: var float32): ptr Entity =
  var bestFov = high(float32)
  for pCurrentEntity in IEntityList.instance.iterate():
    if pCurrentEntity == pLocalPlayer or 
      pCurrentEntity.dormant or 
      pCurrentEntity.lifeState() != elsAlive or 
      not pCurrentEntity.isPlayer() or
      pCurrentEntity.team() == pLocalPlayer.team() : continue
    
    distOut = pLocalPlayer.origin.`-`(pCurrentEntity.origin()).len()
    
    fovOut = getFov(viewAngles) do:
      pLocalPlayer.eye.lookAt(pCurrentEntity.eye) - pLocalPlayer.aimpunchAngles() * 2.0
    do:
      distOut

    if fovOut < bestFov:
      result = pCurrentEntity
      bestFov = fovOut



section ImGui("Aim Assist", nil):
  igCheckbox("Enabled", gCfgEnabled.addr)
  igSpacing()

  var selected {.global.}: Option[WeaponId]

  igBeginChild("Left Pane", ImVec2(x: 150, y: 0), true)

  for weapon in ACTUAL_USED_WEAPONS:
    if igSelectable($weapon, isSome(selected) and selected.unsafeGet() == weapon):
      selected = some(weapon)

  igEndChild()

  igSameLine()

  igBeginGroup()
  igBeginChild("Right Pane")
  if selected.isSome():
    settingsForWeapon(selected.unsafeGet())
  igEndChild()

  if igButton("Save"): saveConfig()
  igSameLine()
  if igButton("Load"): loadConfig()

  igEndGroup()

section PreApplyMouse(nSlot, viewAngles, cmd, mouseX, mouseY):
  if not gCfgEnabled: return

  if mouseX == 0.0 and mouseY == 0.0:
    return

  let pLocalPlayer = IEntityList.instance.entityFromIdx(IEngineClient.instance.idxLocalPlayer())

  if pLocalPlayer.isNil: return
  if pLocalPlayer.lifeState() != elsAlive: return
  
  gPtrCurrentWeapon = pLocalPlayer.pActiveWeapon()
  
  if gPtrCurrentWeapon.isNil: return

  var fov, dist: float32
  let pTargetEnt = pLocalPlayer.getBestEntity(viewAngles, fov, dist)

  if pTargetEnt.isNil: return

  if fov <= 1:
    return

  let targetHitbox = pTargetEnt.hitboxbb(hsHead);
  if targetHitbox.isSome():
    var targetHitbox = (
      let bb = unsafeGet targetHitbox;
      bb.min + (bb.max - bb.min) * 0.5
    )

    if not pLocalPlayer.isVisible(pTargetEnt, targetHitbox):
      return

    targetHitbox = targetHitbox.velCompensated(pTargetEnt.velocity() - pLocalPlayer.velocity(), dist)


    var targetAngles = pLocalPlayer.eye().lookAt(targetHitbox)
    targetAngles -= pLocalPlayer.aimpunchAngles() * 2.0

    var deltaPixels = (
      let deltaAngles = normalized: viewAngles - targetAngles;
      initVector3f0(deltaAngles.yaw(), -deltaAngles.pitch(), 0.0) / 0.022
    )

    let deltaMouse = initVector3f0(mouseX, mouseY, 0.0)
    let scale = max(cfgMinScale(), min(cfgMaxScale(), rand(cfgScaleFactorMin()..cfgScaleFactorMax()) * (1.0 - (fov / cfgStartFov()))))
    let deltaPixelsLen = deltaMouse.len()
    let deltaMouseLen = deltaMouse.len()
    
    deltaPixels = (
      (deltaMouse + deltaPixels.unit() * scale * deltaPixelsLen) / 
      (1 + scale * 
        (deltaMouseLen / deltaPixelsLen)
      )
    )

    mouseX = deltaPixels.x
    mouseY = deltaPixels.y

    

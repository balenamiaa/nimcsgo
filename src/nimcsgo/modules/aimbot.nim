import base, bitops, os, options, gara, math, times, random, tables, json, std/[monotimes, jsonutils]
import winim/lean

type Config = tuple[
  cfgTimeToReach: float32,
  cfgRandLerpOffset: float32,
  cfgDelayMS: int,
  cfgMaxLerp: range[0.01.float32..1.float32],
  cfgHitboxes: array[low(Hitboxes)..high(Hitboxes), bool],
  cfgFovLimit: float32,
  cfgDistLimit: float32,
  cfgRcsEnabled: bool,
  cfgRcsScale: range[0.5.float32..2.5.float32]
]

var gEnabled*: bool = true
var gInMemConfiguration: array[low(WeaponId)..high(WeaponId), Config]
var skipBullets: bool = false
var bulletsToSkip: Natural = 0 


randomize()

var gPtrCurrentWeapon: ptr Entity


proc centerText(text: string) {.inline.} = 
  let fontSize = igGetFontSize() * text.len.float32 / 2
  igSameLine(igGetWindowWidth() / 2 - fontSize + (fontSize / 2))




proc currentConfig(): Config = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  gInMemConfiguration[gPtrCurrentWeapon.weaponId().int]
proc getConfig(weaponId: WeaponId): var Config = gInMemConfiguration[weaponId.int]
proc cfgTimeToReach*: float32 =
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgTimeToReach
proc cfgRandLerpOffset*: float32 = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgRandLerpOffset
proc cfgDelayMS*: int = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgDelayMS
proc cfgMaxLerp*: range[0.01.float32..1.float32] = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgMaxLerp
proc cfgHitboxes*: array[low(Hitboxes)..high(Hitboxes), bool] = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgHitboxes
proc cfgFovLimit*: float32 = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgFovLimit
proc cfgDistLimit*: float32 = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgDistLimit
proc cfgRcsEnabled*: bool = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgRcsEnabled
proc cfgRcsScale*: float32 = 
  ##UNSAFE, CALLER IS REPONSIBILE FOR VALIDITY OF gPtrCurrentWeapon
  currentConfig().cfgRcsScale


proc settingsForWeapon(weaponId: WeaponId) =
  igText("Delay")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderInt("##delay", cast[ptr int32](getConfig(weaponId).cfgDelayMS.addr), 0, 100)

  igSpacing()

  igText("Distance Limit")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##distanceLimit", cast[ptr float32](getConfig(weaponId).cfgDistLimit.addr), 0.float32, 1000.float32)

  igSpacing()

  igText("Time To Reach")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##timeToReach", getConfig(weaponId).cfgTimeToReach.addr, 0.0, 10.0)

  igSpacing()

  igText("Max Lerp")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##maxLerp", cast[ptr float32](getConfig(weaponId).cfgMaxLerp.addr), 0.01, 1.0)

  igSpacing()

  igText("Random Lerp Offset")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##randLerpOffsetMin", getConfig(weaponId).cfgRandLerpOffset.addr, 0.0, 1.0)

  igSpacing()

  igText("FoV Limit")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##fovLimit", cast[ptr float32](getConfig(weaponId).cfgFovLimit.addr), 2.float32, 90.float32)

  igSpacing()

  igText("Rcs Enabled")
  igAlignTextToFramePadding()
  igSameLine()
  igCheckbox("##rcsEnabled", getConfig(weaponId).cfgRcsEnabled.addr)
  igSameLine()
  igSpacing()
  igSliderFloat("##rcsScale", cast[ptr float32](getConfig(weaponId).cfgRcsScale.addr), 0.5.float32, 2.5.float32)

  igSpacing()

  centerText("Hitboxes to scan")
  igText("Hitboxes to scan")
  igAlignTextToFramePadding()
  igListBoxHeader("##scanHitbox", len(low(Hitboxes)..high(Hitboxes)).int32)
  for hitbox in low(Hitboxes)..high(Hitboxes):
    igSelectable($hitbox, getConfig(weaponId).cfgHitboxes[hitbox].addr)
  igListBoxFooter()
  igSpacing()


let configFilePath = getConfigDir() & "nimcsgo_aimbot.json" 

proc saveConfig*() =
  var file = configFilePath.open(fmWrite)
  file.write($ gInMemConfiguration.toJson())
  file.close()

proc loadConfig*() = 
  if fileExists(configFilePath): fromJson(gInMemConfiguration, parseFile(configFilePath))

loadConfig()

section ImGui("Aimbot", nil):
  igCheckbox("Enabled", gEnabled.addr)
  igSpacing()

  var selected {.global.}: Option[WeaponId]

  igBeginChild("Left Pane", ImVec2(x: 150, y: 0), true)

  for weapon in WeaponId:
    if weapon == wiNone: continue
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

  


type
  TargetState* = enum
    tsNotFound
    tsFound
    tsChanged
    tsSame

var gPtrTarget: ptr Entity
var gBestHitbox: Option[Hitboxes]
var gInitialTargetFov: float32
var gTargetBB: tuple[min: Vector3f0, max: Vector3f0]
var gTargetBBCenter: Vector3f0
var gCurrentLerpValue: float32
var gStartedTime,gPrevBBUpdateTime: MonoTime

proc getClosestHitedge(pTarget: ptr Entity, cmd: ptr CUserCmd, bb: var tuple[min: Vector3f0, max: Vector3f0], hitbox: Hitboxes): Vector3f0 = 
  let center = (bb.min + bb.max) / 2'f32
  let angToCenter = gLocalPlayer.eye().lookAt(center)
  let delta = angToCenter - cmd.viewAngles

  var offset: Vector3f0 = 0.3 * cmd.viewAngles.yaw.degToRad.sin !@ 0.3 * -cmd.viewAngles.yaw.degToRad.cos !@ 0.5

  if delta.yaw <= 0:
    offset.x = -offset.x
    offset.y = -offset.y
  if delta.pitch <= 0:
    offset.z = -offset.z

  bb.min + (bb.max - bb.min) * (offset + 0.5)

proc getBestEntity(cmd: ptr CUserCmd): TargetState =
  if gPtrTarget == nil:
    gBestHitbox = none[Hitboxes]()
    var bestFov = high(float32)
    for pCurrentEntity in IEntityList.instance.iterate():
      if pCurrentEntity == gLocalPlayer or 
        pCurrentEntity.dormant or 
        pCurrentEntity.lifeState() != elsAlive or 
        not pCurrentEntity.isPlayer() or
        pCurrentEntity.team() == gLocalPlayer.team() : continue
      
      let dist = gLocalPlayer.origin.`-`(pCurrentEntity.origin()).len()
      if dist <= cfgDistLimit(): continue
      
      let currentFov = cmd.viewAngles.getFov(gLocalPlayer.eye.lookAt(pCurrentEntity.eye) + gLocalPlayer.aimpunchAngles() * 2, dist)
      if currentFov < bestFov:
        gPtrTarget = pCurrentEntity
        bestFov = currentFov
        result = tsFound
  elif gPtrTarget.dormant or gPtrTarget.lifeState() != elsAlive:
    gPtrTarget = nil
    result = getBestEntity(cmd)
    if result != tsNotFound:
      result = tsChanged
  else:
    result = tsSame
      
proc getBestHitbox(cmd: ptr CUserCmd, bestFov: var float32, bestBb: var tuple[min: Vector3f0, max: Vector3f0], bbCenter: var Vector3f0): bool =
  if not isSome(gBestHitbox):
    bestFov = high(float32)
    for currentHitbox, enabled in cfgHitboxes():
      let currentHitbox = Hitboxes(currentHitbox)
      if not enabled: continue
      
      let bb = gPtrTarget.hitboxbb(currentHitbox)
      if bb.isSome():
        let bb = bb.unsafeGet()
        let localBbCenter = bb.min + (bb.max - bb.min) * 0.5
        let bbCenterAngles = gLocalPlayer.eye.lookAt(localBbCenter)
        let currentFov = cmd.viewAngles.getFov(bbCenterAngles + gLocalPlayer.aimpunchAngles() * 2, gLocalPlayer.origin.`-`(gPtrTarget.origin()).len())
        if currentFov < bestFov:
          bestBb = bb
          bbCenter = localBbCenter
          gBestHitbox = some(currentHitbox)
          bestFov = currentFov
          result = true
  elif inNanoSeconds(getMonoTime() - gPrevBBUpdateTime) div 10e6.int >= cfgDelayMS():
    bestBb = gPtrTarget.hitboxbb(gBestHitbox.unsafeGet()).unsafeGet()
    bbCenter = bestBb.min + (bestBb.max - bestBb.min) * 0.5
    result = true
    gPrevBBUpdateTime = getMonoTime()


proc aim(cmd: ptr CUserCmd) = 

  let dist = gLocalPlayer.origin.`-`(gPtrTarget.origin()).len()
  let aimtarget_tmp = gPtrTarget.getClosestHitedge(cmd, gTargetBB, gBestHitbox.unsafeGet())

  let aimtarget = aimtarget_tmp.velCompensated(gPtrTarget.velocity - gLocalPlayer.velocity, dist)
  var aimtargetAngles = gLocalPlayer.eye.lookAt(aimtarget)

  let aimpunch = gLocalPlayer.aimpunchAngles()
  if cfgRcsEnabled() and (aimpunch.yaw != 0 or aimpunch.pitch != 0): 
    aimtargetAngles -= aimpunch * cfgRcsScale()
    aimtargetAngles.normalize()
    
  aimtargetAngles = normalized aimtargetAngles.lerp(cmd.viewAngles, gCurrentLerpValue)
  cmd.viewAngles = aimtargetAngles



section CreateMove(cmd):
  if not gEnabled: return 

  if gLocalPlayer.life_state != elsAlive:
    gPtrTarget = nil
    return

  gPtrCurrentWeapon = gLocalPlayer.pActiveWeapon()
  if gPtrCurrentWeapon == nil:
    gPtrTarget = nil
    return

  case getBestEntity(cmd):
  of tsFound, tsChanged:
    gStartedTime = getMonoTime()
  of tsSame: discard
  of tsNotFound: return
  #echo "Got Entity"
  if not getBestHitbox(cmd, gInitialTargetFov, gTargetBB, gTargetBBCenter): return
  #echo "Got Hitbox"
  if GetAsyncKeyState(VK_LBUTTON).masked(1'i16 shl 15) != 0:
    if gLocalPlayer.isVisible(gPtrTarget, gTargetBBCenter):  
      if gInitialTargetFov <= cfgFovLimit():
        #echo "In Fov"
        if cfgTimeToReach() != 0.0:
          let startedTimeElapsed = inNanoSeconds(getMonoTime() - gStartedTime).float32 / 10e9
          if startedTimeElapsed< cfgTimeToReach():
            gCurrentLerpValue = cfgMaxLerp() * (startedTimeElapsed / cfgTimeToReach())
            gCurrentLerpValue += rand(-cfgRandLerpOffset()..cfgRandLerpOffset())
            gCurrentLerpValue = min(max(0.0, gCurrentLerpValue), cfgMaxLerp())
          else:
            gCurrentLerpValue = cfgMaxLerp()
        else:
          gCurrentLerpValue = 1.0

        #echo "Aiming with lerp: " $ gCurrentLerpValue
        aim(cmd)
  else:
    gPtrTarget = nil
import base, bitops, os, options, gara, math, times, std/monotimes
import winim/lean

var gEnabled*: bool = true
var smoothPercentage*: range[0.float32..0.99.float32] = 0.4
var cfgHitboxes*: array[low(Hitboxes)..high(Hitboxes), bool]
var cfgFovLimit: range[2.float32..360.float32] = 16
var cfgLazyMs: int64
var cfgDistLimit: float
var skipBullets: bool = false
var bulletsToSkip: Natural = 0 
cfgHitboxes[hsHead] = true
cfgHitboxes[hsChest] = true
cfgHitboxes[hsLowerChest] = true
cfgHitboxes[hsUpperChest] = true



var gPtrTarget: ptr Entity = nil
var gBestHitbox: Option[Hitboxes] = none[Hitboxes]()

proc centerText(text: string) = 
  let fontSize = igGetFontSize() * text.len.float32 / 2
  igSameLine(igGetWindowWidth() / 2 - fontSize + (fontSize / 2))

section ImGui("Aimbot", nil):
  igCheckbox("Enabled", gEnabled.addr)
  igSpacing()  

  igText("Lazy MS")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderInt("##lazyMs", cast[ptr int32](cfgLazyMs.addr), 0, 100)
  igSpacing()

  igText("Distance Limit")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##distanceLimit", cast[ptr float32](cfgDistLimit.addr), 0.float32, 1000.float32)
  igSpacing()

  igText("Lerp percentage")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##Lerp percentage", cast[ptr float32](smoothPercentage.addr), 0.float32, 0.99.float32)
  igSpacing()

  igText("FoV Limit")
  igAlignTextToFramePadding()
  igSameLine()
  igSliderFloat("##fovLimit", cast[ptr float32](cfgFovLimit.addr), 2.float32, 360.float32)
  igSpacing()

  igText("Skip Bullets")
  igAlignTextToFramePadding()
  igSameLine()
  igCheckbox("##skipBullets", skipBullets.addr)
  igSameLine()
  igSliderInt("##numOfBulletsToSkip", cast[ptr int32](bulletsToSkip.addr), 1, 10)
  igSpacing()

  centerText("Hitboxes to scan")
  igText("Hitboxes to scan")
  igAlignTextToFramePadding()
  igListBoxHeader("##scanHitbox", len(low(Hitboxes)..high(Hitboxes)).int32)
  for hitbox in low(Hitboxes)..high(Hitboxes):
    igSelectable($hitbox, cfgHitboxes[hitbox].addr)
  igListBoxFooter()
  igSpacing()

  igText("Presets")
  igColumns(2)
  igSeparator()
  igSpacing()
  igText("FoV Presets"); igNextColumn()
  igText("Lerp Presets"); igNextColumn()
  igSeparator()
  if igButton("Ultra Low"): cfgFovLimit = 3
  igNextColumn()
  if igButton("Ultra Low##2"): smoothPercentage = 0.1
  igNextColumn()
  if igButton("Low"): cfgFovLimit = 7
  igNextColumn()
  if igButton("Low##2"): smoothPercentage = 0.15
  igNextColumn()
  if igButton("Quasi Low-Mid"): cfgFovLimit = 12
  igNextColumn()
  if igButton("Quasi Low-Mid##2"): smoothPercentage = 0.25
  igNextColumn()
  if igButton("Mid"): cfgFovLimit = 16
  igNextColumn()
  if igButton("Mid##2"): smoothPercentage = 0.35
  igNextColumn()
  if igButton("Quasi Mid-High"): cfgFovLimit = 24
  igNextColumn()
  if igButton("Quasi Mid-High##2"): smoothPercentage = 0.45
  igNextColumn()
  if igButton("High"): cfgFovLimit = 30
  igNextColumn()
  if igButton("High##2"): smoothPercentage = 0.55
  igNextColumn()
  if igButton("Ultra High"): cfgFovLimit = 45
  igNextColumn()
  if igButton("Ultra High##2"): smoothPercentage = 0.75
  igColumns(1)




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



  
proc getBestEntity(cmd: ptr CUserCmd): bool =
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
      if dist > cfgDistLimit: continue
      
      let currentFov = cmd.viewAngles.getFov(gLocalPlayer.eye.lookAt(pCurrentEntity.eye) + gLocalPlayer.aimpunchAngles() * 2, dist)
      if currentFov < bestFov:
        gPtrTarget = pCurrentEntity
        bestFov = currentFov
        result = true
  elif gPtrTarget.dormant or gPtrTarget.lifeState() != elsAlive:
    gPtrTarget = nil
    result = getBestEntity(cmd)
  else:
    result = true


var elapsedTime: Duration
var lastTime: MonoTime = getMonoTime()

template lazyUpdate(body: untyped) = 
  if elapsedTime >= initDuration(cfgLazyMs * 10e6.int):
    body
    lastTime = getMonoTime()


      
proc getBestHitbox(cmd: ptr CUserCmd, bestFov: var float32, bestBb: var tuple[min: Vector3f0, max: Vector3f0], bbCenter: var Vector3f0): bool =
  if not isSome(gBestHitbox):
    bestFov = high(float32)
    for currentHitbox, enabled in cfgHitboxes:
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
  else:
    lazyUpdate:
      bestBb = gPtrTarget.hitboxbb(gBestHitbox.unsafeGet()).unsafeGet()
      bbCenter = bestBb.min + (bestBb.max - bestBb.min) * 0.5
      result = true
        

section CreateMove(cmd):
  if not gEnabled: return 

  elapsedTime = getMonoTime() - lastTime
  if gLocalPlayer.life_state != elsAlive: return

  var targetFov {.global.}: float32
  var targetBb {.global.}: tuple[min: Vector3f0, max: Vector3f0]
  var targetBbCenter {.global.}: Vector3f0

  if not getBestEntity(cmd): return
  if not getBestHitbox(cmd, targetFov, targetBb, targetBbCenter): return
  if GetAsyncKeyState(VK_LBUTTON).masked(1'i16 shl 15) != 0:
    if gLocalPlayer.isVisible(gPtrTarget, targetBbCenter):  
      if targetFov <= cfgFovLimit:
        var aimtarget_tmp = gPtrTarget.getClosestHitedge(cmd, targetBb, gBestHitbox.unsafeGet())

        let dist = gLocalPlayer.origin.`-`(gPtrTarget.origin()).len()
        let aimtarget = aimtarget_tmp.velCompensated(gPtrTarget.velocity - gLocalPlayer.velocity, dist)
        var aimtargetAngles = gLocalPlayer.eye.lookAt(aimtarget)
        let aimpunch = gLocalPlayer.aimpunchAngles()
        if aimpunch.yaw != 0 or aimpunch.pitch != 0: 
          aimtargetAngles -= aimpunch * 2
          aimtargetAngles.normalize()

        aimtargetAngles = normalized aimtargetAngles.angSmoothed(cmd.viewAngles, 1.0 - smoothPercentage)
        cmd.viewAngles = aimtargetAngles
  else:
    gPtrTarget = nil
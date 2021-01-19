import base, os, locks, options, math


type 
  Data = object
    coords: array[8, Vector3f0]
    color: D3DCOLOR
    name: string

var gFont: ptr ID3DXFont = nil

var enabled*: bool = false
var boxes = newSeqOfCap[Data](64)

proc getBB(pEntity: ptr Entity, coords: var array[8, Vector3f0]): bool {.inline.} = 
  if pEntity.renderable() == nil: return  
  var min, max: Vector3f0 
  pEntity.renderable.getRenderBounds(min, max)

  let trans = pEntity.renderable.renderableToWorldTransform()
  var points: array[8, Vector3f0]
  for i, point in [
    min.x !@ min.y !@ min.z,
    min.x !@ max.y !@ min.z,
    max.x !@ max.y !@ min.z,
    max.x !@ min.y !@ min.z,
    max.x !@ max.y !@ max.z,
    min.x !@ max.y !@ max.z,
    min.x !@ min.y !@ max.z,  
    max.x !@ min.y !@ max.z,
  ]:
    let 
      c = cos(degToRad pEntity.eyeAngles().yaw)
      s = sin(degToRad pEntity.eyeAngles().yaw)
      cpyX = point.x
      cpyY = point.y
    
    let point = (c * cpyX - s * cpyY) !@ (s * cpyX + c * cpyY) !@ point.z
    points[i].x = point.dot(trans[0]) + trans[0][3]
    points[i].y = point.dot(trans[1]) + trans[1][3]
    points[i].z = point.dot(trans[2]) + trans[2][3]
  

  for i in 0..<8:
    if not IDebugOverlay.instance.worldToScreen(points[i], coords[i]): return false

  return true
section InitRender(pDevice):
  discard pDevice.d3dxCreateFont(height = 20, fontname = "Arial".cstring, weight = fwBold, ppOut = gFont.addr)

section ImGui("Esp", nil):
  igCheckbox("Enabled", enabled.addr)

section PaintTraverse(_, _, _):
  if not enabled: return
  boxes.setLen(0)


  if gLocalPlayer.isNil: return
  if gLocalPlayer.life_state != elsAlive: return
  
  for pEnt in IEntityList.instance.iterate():
    if pEnt == gLocalPlayer or 
    pEnt.dormant or 
    pEnt.lifeState() != elsAlive or 
    not pEnt.isPlayer(): continue
    var color: D3DCOLOR
    if pEnt.team == gLocalPlayer.team:
      color = rgba(55,155,255, 255)
    elif gLocalPlayer.isVisible(pEnt, pEnt.eye) or gLocalPlayer.isVisible(pEnt, pEnt.origin):
      color = rgba(155,155,55, 255)
    else:
      color = rgba(255,55,155, 255)

    var data: Data
    data.color = color
    data.name = pEnt.getName()

    if pEnt.getBB(data.coords):
      boxes.add(data)


section FrameRender(pDevice):
  if not enabled: return

  for data in boxes:
    #bottom rectangle
    pDevice.drawLine(cint data.coords[0].x, cint data.coords[0].y, cint data.coords[1].x, cint data.coords[1].y): data.color
    pDevice.drawLine(cint data.coords[1].x, cint data.coords[1].y, cint data.coords[2].x, cint data.coords[2].y): data.color
    pDevice.drawLine(cint data.coords[2].x, cint data.coords[2].y, cint data.coords[3].x, cint data.coords[3].y): data.color
    pDevice.drawLine(cint data.coords[0].x, cint data.coords[0].y, cint data.coords[3].x, cint data.coords[3].y): data.color

    #top rectangle
    pDevice.drawLine(cint data.coords[4].x, cint data.coords[4].y, cint data.coords[5].x, cint data.coords[5].y): data.color
    pDevice.drawLine(cint data.coords[5].x, cint data.coords[5].y, cint data.coords[6].x, cint data.coords[6].y): data.color
    pDevice.drawLine(cint data.coords[6].x, cint data.coords[6].y, cint data.coords[7].x, cint data.coords[7].y): data.color
    pDevice.drawLine(cint data.coords[7].x, cint data.coords[7].y, cint data.coords[4].x, cint data.coords[4].y): data.color

    #vertical edges
    pDevice.drawLine(cint data.coords[0].x, cint data.coords[0].y, cint data.coords[6].x, cint data.coords[6].y): data.color
    pDevice.drawLine(cint data.coords[3].x, cint data.coords[3].y, cint data.coords[7].x, cint data.coords[7].y): data.color
    pDevice.drawLine(cint data.coords[2].x, cint data.coords[2].y, cint data.coords[4].x, cint data.coords[4].y): data.color
    pDevice.drawLine(cint data.coords[1].x, cint data.coords[1].y, cint data.coords[5].x, cint data.coords[5].y): data.color

    #gFont.drawText(box.tX.int32 - gFont.getTextLength(box.name) div 2'i32, box.tY.int32, rgba(200,100,155,255), false, box.name)


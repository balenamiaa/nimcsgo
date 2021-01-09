import base, os, locks, options


type 
  Data = object
    x,y,w,h: float32
    color: D3DCOLOR
    tX, tY: float32
    name: string

var gFont: ptr ID3DXFont = nil

var enabled*: bool = true
var boxes = newSeqOfCap[Data](64)

proc getBB(pEntity: ptr Entity, top, left, bottom, right: var float32): bool {.inline.} = 

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
    points[i].x = point.dot(trans[0]) + trans[0][3]
    points[i].y = point.dot(trans[1]) + trans[1][3]
    points[i].z = point.dot(trans[2]) + trans[2][3]

  
  var screenPoints: array[8, Vector3f0]

  for i in 0..<8:
    if not IDebugOverlay.instance.worldToScreen(points[i], screenPoints[i]): return false
    
  top = screenPoints[0].y
  left = screenPoints[0].x
  bottom = screenPoints[0].y
  right = screenPoints[0].x
  for screenPoint in screenPoints[1..^1]: 
    if top > screenPoint.y:
      top = screenPoint.y
    if left > screenPoint.x:
      left = screenPoint.x
    if right < screenPoint.x:
      right = screenPoint.x
    if bottom < screenPoint.y:
      bottom = screenPoint.y

  return true
section InitRender(pDevice):
  discard pDevice.d3dxCreateFont(height = 20, fontname = "Arial".cstring, weight = fwBold, ppOut = gFont.addr)

section ImGui("Esp", nil):
  igCheckbox("Enabled", enabled.addr)

section PaintTraverse(_, _, _):
  if not enabled: return
  boxes.setLen(0)


  if gLocalPlayer.isNil: return

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

    var left, right, top, bottom: float32 = 0
    if pEnt.getBB(top, left, bottom, right):
      boxes.add(
        Data(
          x: left, y: top, w: right - left, h: bottom - top, color: color,
          tX: (left + right) / 2, tY: max(0, top - 40),
          name: pEnt.getName()
        )
      )


section FrameRender(pDevice):
  if not enabled: return

  for box in boxes:
    pDevice.drawBorderedBox(box.x.int32, box.y.int32, box.w.int32, box.h.int32, 1, box.color)
    gFont.drawText(box.tX.int32 - gFont.getTextLength(box.name) div 2'i32, box.tY.int32, rgba(200,100,155,255), false, box.name)


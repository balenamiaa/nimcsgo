import ../vtableinterface
import ../structs/entity, ../structs/vector, os

vtableInterface IEngineClient:
  idx 26: 
    proc inGame*(self: ptr IEngineClient): bool {.thiscall.}
  idx 12:
    proc idxLocalPlayer*(self: ptr IEngineClient): EntityIndex {.thiscall.}
  idx 5:
    proc internal_screenSize(self: ptr IEngineClient, width: var int32, height: var int32) {.thiscall.}
  idx 8:
    proc internal_getPlayerInfo(self: ptr IEngineClient, idx: EntityIndex, playerInfo: ptr PlayerInfo) {.thiscall.}
  idx 37:
    proc worldToScreenMatrix*(self: ptr IEngineClient): var array[4, array[4, float32]] {.thiscall.}

  proc getPlayerInfo*(self: ptr IEngineClient, idx: EntityIndex): PlayerInfo = 
    var playerInfo: PlayerInfo
    self.internal_getPlayerInfo(idx, playerInfo.addr)
    playerInfo
  proc screenSize*(self: ptr IEngineClient): tuple[width: int32, height: int32] {.thiscall} = 
    var width, height: int32 = 0
    self.internal_screenSize(width, height)
    (width, height)

genInstantiation IEngineClient


proc getName*(entity: ptr Entity): string = 
  var playerInfo = IEngineClient.instance.getPlayerInfo(entity.networkable.index())
  $playerInfo.name.addr.cstring

proc isPlayer*(self: ptr Entity): bool =
  IEngineClient.instance.getPlayerInfo(self.networkable.index()).name[0] != '\0'

proc screenTransform(vIn, vOut: var Vector3f0): bool = 
  let w2sMatrix = IEngineClient.instance.worldToScreenMatrix()

  vOut.x = w2sMatrix[0][0] * vIn.x + w2sMatrix[0][1] * vIn.y + w2sMatrix[0][2] * vIn.z + w2sMatrix[0][3]
  vOut.y = w2sMatrix[1][0] * vIn.x + w2sMatrix[1][1] * vIn.y + w2sMatrix[1][2] * vIn.z + w2sMatrix[1][3]
  vOut.z = 0'f32

  let w = w2sMatrix[3][0] * vIn.x + w2sMatrix[3][1] * vIn.y + w2sMatrix[3][2] * vIn.z + w2sMatrix[3][3]

  if w < 0.001:
    vOut *= 100000
    false
  else:
    vOut /= w
    true

proc worldToScreen*(vIn, vOut: var Vector3f0): bool = 
  if screenTransform(vIn, vOut):
    let (w,h) = IEngineClient.instance.screenSize()
    vOut.x = (w.float32 / 2) + (vOut.x * w.float32) / 2
    vOut.y = (h.float32 / 2) + (vOut.y * h.float32) / 2

    result = true
import ../vtableinterface
import ../structs/entity


vtableInterface IEngineClient:
  idx 26: 
    proc inGame*(self: ptr IEngineClient): bool {.thiscall.}
  idx 12:
    proc idxLocalPlayer*(self: ptr IEngineClient): EntityIndex {.thiscall.}
  idx 5:
    proc internal_screenSize(self: ptr IEngineClient, width: var int32, height: var int32) {.thiscall.}
  idx 8:
    proc internal_getPlayerInfo(self: ptr IEngineClient, idx: EntityIndex, playerInfo: ptr PlayerInfo) {.thiscall.}

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
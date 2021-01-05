import ../vtableinterface
from ../structs import EntityIndex


vtableInterface IEngineClient:
  idx 26: 
    proc inGame*(self: ptr IEngineClient): bool {.thiscall.}
  idx 12:
    proc idxLocalPlayer*(self: ptr IEngineClient): EntityIndex {.thiscall.}
  idx 5:
    proc internal_screenSize(self: ptr IEngineClient, width: var int32, height: var int32) {.thiscall.}

  proc screenSize*(self: ptr IEngineClient): tuple[width: int32, height: int32] {.thiscall} = 
    var width, height: int32 = 0
    self.internal_screenSize(width, height)
    (width, height)

genInstantiation IEngineClient
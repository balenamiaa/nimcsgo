import helpers, macros
from structs import EntityIndex, Entity, ClientClass

macro genInstantiation(T: untyped) = 
  template implInstantiation(Tx, Ty, Tz: untyped, Txx: string) = 
    var Ty {.compileTime.}: bool = false
    var Tz: pointer = nil
    proc instance*(constraint: typedesc[Tx]): var Tx = 
      when not (Ty): raise newException(LibraryError, Txx)
      cast[var Tx](Tz)
    proc setInstance*(constraint: typedesc[Tx], pInstance: pointer) = 
      static: Ty = true
      Tz = pInstance
  let 
    Ty = nskVar.genSym()
    Tz = nskVar.genSym()
    Txx = $T & " hasn't been set in the code-base."
  getAst(implInstantiation(T, Ty, Tz, Txx))

vtableInterface IEngineClient:
  idx 26: 
    proc inGame*(self: var IEngineClient): bool {.thiscall.}
  idx 12:
    proc idxLocalPlayer*(self: var IEngineClient): EntityIndex {.thiscall.}
  idx 5:
    proc internal_screenSize(self: var IEngineClient, width: var int32, height: var int32) {.thiscall.}

  proc screenSize*(self: var IEngineClient): tuple[width: int32, height: int32] {.thiscall} = 
    var width, height: int32 = 0
    self.internal_screenSize(width, height)
    (width, height)

genInstantiation IEngineClient

vtableInterface IBaseClient:
  idx 8: 
    proc clientClassTail*(self: var IBaseClient): var ClientClass {.thiscall.}

genInstantiation IBaseClient

vtableInterface IEntityList:
  idx 6: 
    proc highestEntityIndex*(self: var IEntityList): EntityIndex {.thiscall.}
  #idx 4: 
  #  proc entityPtrFromHandle*(self: var IEntityList. handle: EntityHandle): pointer {.thiscall.}
  idx 3:
    proc entityFromindex(self: var IEntityList, index: EntityIndex): var Entity {.thiscall.}

genInstantiation IEntityList




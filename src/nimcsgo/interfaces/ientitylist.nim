import ../vtableinterface
from ../structs import EntityIndex, Entity


vtableInterface IEntityList:
  idx 6: 
    proc highestEntityIdx*(self: ptr IEntityList): EntityIndex {.thiscall.}
  #idx 4: 
  #  proc entityPtrFromHandle*(self: ptr IEntityList. handle: EntityHandle): pointer {.thiscall.}
  idx 3:
    proc entityFromIdx*(self: ptr IEntityList, index: EntityIndex): ptr Entity {.thiscall.}

genInstantiation IEntityList
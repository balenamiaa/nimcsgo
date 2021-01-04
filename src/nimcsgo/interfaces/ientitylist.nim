import ../vtableinterface
from ../structs import EntityIndex, Entity


vtableInterface IEntityList:
  idx 6: 
    proc highestEntityIdx*(self: var IEntityList): EntityIndex {.thiscall.}
  #idx 4: 
  #  proc entityPtrFromHandle*(self: var IEntityList. handle: EntityHandle): pointer {.thiscall.}
  idx 3:
    proc entityFromIdx*(self: var IEntityList, index: EntityIndex): ptr Entity {.thiscall.}

genInstantiation IEntityList
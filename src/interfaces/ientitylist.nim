import ../helpers
from ../structs import EntityIndex, Entity


vtableInterface IEntityList:
  idx 6: 
    proc highestEntityIndex*(self: var IEntityList): EntityIndex {.thiscall.}
  #idx 4: 
  #  proc entityPtrFromHandle*(self: var IEntityList. handle: EntityHandle): pointer {.thiscall.}
  idx 3:
    proc entityFromindex(self: var IEntityList, index: EntityIndex): var Entity {.thiscall.}

genInstantiation IEntityList
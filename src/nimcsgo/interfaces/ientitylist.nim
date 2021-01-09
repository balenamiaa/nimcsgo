import ../vtableinterface, ../structs/entity


vtableInterface IEntityList:
  idx 6: 
    proc highestEntityIdx*(self: ptr IEntityList): EntityIndex {.thiscall.}
  #idx 4: 
  #  proc entityPtrFromHandle*(self: ptr IEntityList. handle: EntityHandle): pointer {.thiscall.}
  idx 3:
    proc entityFromIdx*(self: ptr IEntityList, index: EntityIndex): ptr Entity {.thiscall.}

    
  {.checks: off, optimization: speed.}
  iterator iterate*(self: ptr IEntityList): ptr Entity = 
    var currentIdx = 1.EntityIndex
    while currentIdx <= self.highestEntityIdx():
      let pCurrentEntity = self.entityFromIdx(currentIdx)
      if pCurrentEntity != nil and pCurrentEntity.vtable != nil: yield pCurrentEntity
      currentIdx += 1.EntityIndex
  

genInstantiation IEntityList
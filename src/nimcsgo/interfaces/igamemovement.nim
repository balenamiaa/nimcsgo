import ../vtableinterface
import ../structs/clientclass


vtableInterface IGameMovement:
  idx 8: 
    proc clientClassTail*(self: ptr IBaseClient): ptr ClientClass

genInstantiation IGameMovement
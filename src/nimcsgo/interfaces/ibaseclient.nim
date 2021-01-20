import ../vtableinterface
import ../structs/clientclass


vtableInterface IBaseClient:
  idx 8: 
    proc clientClassTail*(self: ptr IBaseClient): ptr ClientClass

genInstantiation IBaseClient
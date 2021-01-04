import ../vtableinterface
import ../structs/clientclass


vtableInterface IBaseClient:
  idx 8: 
    proc clientClassTail*(self: var IBaseClient): var ClientClass {.thiscall.}

genInstantiation IBaseClient
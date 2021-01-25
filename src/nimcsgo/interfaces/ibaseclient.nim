import ../vtableinterface
import ../structs/clientclass


vtable:
  type IBaseClient* = object

  methods:
    @8
    proc clientClassTail*(): ptr ClientClass

genInstantiation IBaseClient
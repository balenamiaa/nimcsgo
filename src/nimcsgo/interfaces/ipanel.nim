import ../vtableinterface


vtableInterface IPanel:
  idx 36: 
    proc panelName*(self: ptr IPanel, panelId: uint): cstring {.thiscall.}

genInstantiation IPanel






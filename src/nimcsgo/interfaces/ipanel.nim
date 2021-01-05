import ../vtableinterface


vtableInterface IPanel:
  idx 36: 
    proc panelName*(self: var IPanel, panelId: uint): cstring {.thiscall.}

genInstantiation IPanel






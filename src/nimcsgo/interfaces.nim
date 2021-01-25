import interfaces/[ibaseclient, iengineclient, ientitylist, ipanel, imodelinfo, itraceengine, idebugoverlay, cglobalvars, cmovehelper]
import helpers
proc initialize*() =
  IBaseClient.setInstance(createInterface("client.dll", "VClient018"))
  IEngineClient.setInstance(createInterface("engine.dll", "VEngineClient014"))
  IEntityList.setInstance(createInterface("client.dll", "VClientEntityList003"))
  IPanel.setInstance(createInterface("vgui2.dll", "VGUI_Panel009"))
  IModelInfo.setInstance(createInterface("engine.dll", "VModelInfoClient004"))
  ITraceEngine.setInstance(createInterface("engine.dll", "EngineTraceClient004"))
  IDebugOverlay.setInstance(createInterface("engine.dll", "VDebugOverlay004"))

  IGameMovement.setInstance(createInterface("client.dll", "GameMovement001"))
  IPlayerPrediction.setInstance(createInterface("client.dll", "VClientPrediction001"))
  IMoveHelper.setInstance(cast[ptr ptr pointer](cast[uint](patternScan("8B 0D ?? ?? ?? ?? 8B 46 08 68", "client.dll")) + 2)[][])
  
  block:
    let pppGlobalVars = (
      let tmp = cast[uint](IBaseClient.instance.mVTable) + 11 * sizeof(pointer);
      let tmp2 = cast[ptr ptr uint](cast[ptr uint](tmp)[] + 10);
      tmp2
    )
    gCsGlobalVars = cast[ptr ptr ptr GlobalVars](pppGlobalVars)[][]
export ibaseclient, iengineclient, ientitylist, ipanel, imodelinfo, itraceengine, idebugoverlay, cglobalvars, cmovehelper
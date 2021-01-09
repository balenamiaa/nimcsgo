import interfaces/[ibaseclient, iengineclient, ientitylist, ipanel, imodelinfo, itraceengine, idebugoverlay]
from helpers import createInterface
proc initialize*() =
  IBaseClient.setInstance(createInterface("client.dll", "VClient018"))
  IEngineClient.setInstance(createInterface("engine.dll", "VEngineClient014"))
  IEntityList.setInstance(createInterface("client.dll", "VClientEntityList003"))
  IPanel.setInstance(createInterface("vgui2.dll", "VGUI_Panel009"))
  IModelInfo.setInstance(createInterface("engine.dll", "VModelInfoClient004"))
  ITraceEngine.setInstance(createInterface("engine.dll", "EngineTraceClient004"))
  IDebugOverlay.setInstance(createInterface("engine.dll", "VDebugOverlay004"))
export ibaseclient, iengineclient, ientitylist, ipanel, imodelinfo, itraceengine, idebugoverlay
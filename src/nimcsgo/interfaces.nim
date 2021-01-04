import interfaces/[ibaseclient, iengineclient, ientitylist]
from helpers import createInterface
proc initialize*() =
  IBaseClient.setInstance(createInterface("client.dll", "VClient018"))
  IEngineClient.setInstance(createInterface("engine.dll", "VEngineClient014"))
  IEntityList.setInstance(createInterface("client.dll", "VClientEntityList003"))

export ibaseclient, iengineclient, ientitylist
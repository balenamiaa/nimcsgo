import winim/lean, minhook, macros, strutils
import ./interfaces, ./structs/cusercmd, ./modules
{.compile: "shim.c".}


proc realEntry = 
  initialize()
  let clientMode = (
    let tmp = cast[uint](IBaseClient.instance.vtable) + 10 * sizeof(pointer);
    let tmp2 = cast[ptr ptr uint](cast[ptr uint](tmp)[] + 5);
    tmp2[][]
  )
  let clientModeVTable = cast[ptr uint](clientMode)[]
  let pCreateMove = cast[ptr pointer](clientModeVTable + 24 * sizeof(pointer))[]
  minhook.init()

  mHook(stdcall(inputSFrameRate: float32, cmd: ptr CUserCmd) -> bool, pCreateMove):
    let retValue = ogProcCall(inputSFrameRate, cmd) 
    gLocalPlayer = IEntityList.instance.entityFromIdx(IEngineClient.instance.idxLocalPlayer())
    if gLocalPlayer != nil:
      for fn in gCreateMoveProcs: fn(cast[var CUserCmd](cmd))
    retValue
  

proc Entry(hInstance: HINSTANCE) {.cdecl, exportc.} =
  try:
    realEntry()
  except:
    echo "Crashed with exception: " & getCurrentExceptionMsg()
     
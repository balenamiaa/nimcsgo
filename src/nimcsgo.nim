import winim/lean
import minhook
import ./interfaces
import ./structs/cusercmd
{.compile: "shim.c".}


proc realEntry = 
  initialize()
  let clientMode = (
    let tmp = cast[uint](IBaseClient.instance.vtable) + 10 * sizeof(pointer);
    let tmp2 = cast[ptr ptr uint](cast[ptr uint](tmp)[] + 5);
    tmp2[][]
  )
  echo cast[uint](clientMode)
  let clientModeVTable = cast[ptr uint](clientMode)[]
  echo cast[uint](clientModeVTable)
  let pCreateMove = cast[ptr pointer](clientModeVTable + 24 * sizeof(pointer))[]
  echo cast[uint](pCreateMove)
  minhook.init()
  mHook(stdcall(inputSFrameRate: float32, cmd: ptr CUserCmd) -> bool, pCreateMove):
    let retValue = ogProcCall(inputSFrameRate, cmd)
    echo repr(cmd[]) & "\n\n\n"
    retValue

proc Entry(hInstance: HINSTANCE) {.cdecl, exportc.} =
  try:
    realEntry()
  except:
    echo "Crashed with exception: " & getCurrentExceptionMsg()
     
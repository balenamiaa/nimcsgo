import winim/inc/windef

proc onAttach()

var hInstDll: HINSTANCE = 0
onAttach()

proc onAttach() = 
  discard

proc onDetach() = 
  discard

#Overriding DllMain so I can handle detach case
proc NimMain() {.cdecl, importc.}
proc DllMain(hInstDll: HINSTANCE, fdwReason: DWORD, lpReserved: LPVOID): WINBOOL {.stdcall, exportc.} = 
  case fdwReason:
  of DLL_PROCESS_ATTACH:
    nimcsgo.hInstDll = hInstDll
    NimMain()
  of DLL_PROCESS_DETACH:
    nimcsgo.hInstDll = hInstDll
    onDetach()
  else: 
    nimcsgo.hInstDll = hInstDll

  return 1



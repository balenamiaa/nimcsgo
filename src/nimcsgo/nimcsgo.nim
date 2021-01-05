import winim/lean, minhook, macros, strutils, options, os
import ./interfaces, ./structs/cusercmd, ./modules, ./helpers, ../imgui/imgui

{.compile: "shim.c".}




var ogWndProc {.global.}: proc(hWnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} = nil
var ogPresent {.global.}: proc(pDevice: ptr IDirect3DDevice9, src: ptr RECT, dst: ptr RECT, wndOverride: HWND, dirtyRegion: ptr RGNDATA): HRESULT {.stdcall.} = nil
var ogReset {.global.}: proc(pDevice: ptr IDirect3DDevice9, params: ptr D3DPRESENT_PARAMETERS): HRESULT {.stdcall.} = nil

proc hkWndProc(hWnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} = 
  discard win32WndProc(hWnd, message, wParam, lParam)
  CallWindowProc(ogWndProc, hWnd, message, wParam, lParam)

proc hkPresent(pDevice: ptr IDirect3DDevice9, src: ptr RECT, dst: ptr RECT, wndOverride: HWND, dirtyRegion: ptr RGNDATA): HRESULT {.stdcall.} = 
  var isInitialized {.global.} : bool = false

  if not isInitialized:
    var gameHWnd {.global.}: HWND = 0
    proc findGameHWnd(hWnd: HWND, lParam: LPARAM): BOOl {.stdcall.} = 
      var buffer: array[15, CHAR]
      GetWindowText(hWnd, buffer.addr.cstring, 15)
      if buffer.addr.cstring == "Counter-Strike":
        gameHWnd = hWnd
        return 0.BOOL
    
      1.BOOL
      
    EnumWindows(findGameHWnd, 0)
    if gameHWnd != 0:
      ogWndProc = cast[typeof(ogWndProc)](SetWindowLongPtr(gameHWnd, GWLP_WNDPROC, cast[LONG_PTR](hkWndProc)))
      assert(igCreateContext() != nil, "igCreateContext failed")
      assert(win32Init(gameHWnd), "win32init failed")
      assert(dx9Init(pDevice), "dx9init failed")
      isInitialized = true
  else:

    dx9NewFrame()
    win32NewFrame()
    igNewFrame()

    igEndFrame()

    igRender()
    dx9RenderDrawData()

  ogPresent(pDevice, src, dst, wndOverride, dirtyRegion)

proc hkReset(pDevice: ptr IDirect3DDevice9, params: ptr D3DPRESENT_PARAMETERS): HRESULT {.stdcall.} =
  dx9InvalidateDeviceObjects()
  result = ogReset(pDevice, params)
  assert(dx9CreateDeviceObjects(), "dx9CreateDeviceObjects failed") 
  
  


proc realEntry = 
  initialize()
  let clientMode = (
    let tmp = cast[uint](IBaseClient.instance.vtable) + 10 * sizeof(pointer);
    let tmp2 = cast[ptr ptr uint](cast[ptr uint](tmp)[] + 5);
    tmp2[][]
  )
  let clientModeVTable = cast[ptr uint](clientMode)[]
  let pCreateMove = cast[ptr pointer](clientModeVTable + 24 * sizeof(pointer))[]
  let pPaintTraverse = cast[ptr pointer](cast[uint](IPanel.instance.vtable) + 41 * sizeof(pointer))[]
  block:
    let handle = GetModuleHandle("gameoverlayrenderer.dll")
    let tmp1 = cast[uint](patternScan("FF15 ?? ?? ?? ?? 8BF885DB"    , handle).get())
    let tmp2 = cast[uint](patternScan("FF15 ?? ?? ?? ?? 8BF885FF7818", handle).get())
    ogPresent = cast[typeof(ogPresent)](cast[ptr ptr uint](tmp1 + 2)[][])
    ogReset   = cast[typeof(ogReset)](cast[ptr ptr uint](tmp2 + 2)[][])

    cast[ptr ptr pointer](tmp1 + 2)[][] = cast[pointer](hkPresent)
    cast[ptr ptr pointer](tmp2 + 2)[][] = cast[pointer](hkReset)
  
  minhook.init()

  mHook(stdcall(inputSFrameRate: float32, cmd: ptr CUserCmd) -> bool, pCreateMove):
    let retValue = ogProcCall(inputSFrameRate, cmd) 
    gLocalPlayer = IEntityList.instance.entityFromIdx(IEngineClient.instance.idxLocalPlayer())
    if gLocalPlayer != nil:
      for fn in gCreateMoveProcs: fn(cast[var CUserCmd](cmd))
    retValue
  mHook(thiscall(self: ptr IPanel, panelId: uint, forceRePaint: bool, allowForce: bool) -> void, pPaintTraverse):
    ogProcCall(self, panelId, forceRePaint, allowForce) 
    let panelName = IPanel.instance.panelName(panelId)
    
    if panelName == "MatSystemTopPanel":
      for fn in gPaintTraverseProcs: fn(panelId, forceRePaint, allowForce)


proc Entry(hInstance: HINSTANCE) {.cdecl, exportc.} =
  try:
    realEntry()
  except:
    echo "Crashed with exception: " & getCurrentExceptionMsg()
    sleep(10000)
     
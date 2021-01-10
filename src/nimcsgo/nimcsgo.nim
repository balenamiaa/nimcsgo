import winim/lean as win
import minhook, macros, strutils, options, os
import ./interfaces, ./structs/cusercmd, ./modules, ./helpers, imgui, ./structs/vector, ./modules/base
{.compile: "shim.c".}



proc handleException(source: string) = discard
 # let exception = getCurrentException()
  
 # echo "From " & source & ":  " & exception.getStackTrace() 


var ogWndProc {.global.}: proc(hWnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} = nil
var ogPresent {.global.}: proc(pDevice: ptr IDirect3DDevice9, src: ptr win.RECT, dst: ptr win.RECT, wndOverride: HWND, dirtyRegion: ptr RGNDATA): HRESULT {.stdcall.} = nil
var ogReset {.global.}: proc(pDevice: ptr IDirect3DDevice9, params: ptr D3DPRESENT_PARAMETERS): HRESULT {.stdcall.} = nil

proc hkWndProc(hWnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} = 
  var guiKeyDown {.global.}: bool

  if message == WM_KEYDOWN and wParam == VK_INSERT:
    guiKeyDown = true
  elif message == WM_KEYUP and wParam == VK_INSERT and guiKeyDown:
    base.gGuiEnabled = not base.gGuiEnabled
    guiKeyDown = false
  
  if base.gGuiEnabled: 
    discard win32WndProc(hWnd, message, wParam, lParam)
  CallWindowProc(ogWndProc, hWnd, message, wParam, lParam)
  


proc hkPresent(pDevice: ptr IDirect3DDevice9, src: ptr win.RECT, dst: ptr win.RECT, wndOverride: HWND, dirtyRegion: ptr RGNDATA): HRESULT {.stdcall.} = 
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
      #gRenderer = initRenderer(pDevice)
      igStyleColorsCherry()

      try:
        for fn in gInitRenderProcs: fn(pDevice)
      except: handleException("InitRender")
      isInitialized = true
  else:
    try:
      for fn in gRenderFrameProcs: fn(pDevice)
    except: handleException("RenderFrame")
    dx9NewFrame()
    win32NewFrame()
    igNewFrame()
    if base.gGuiEnabled:
      try:
        for fn in gImGuiProcs: fn() 
      except: handleException("ImGui")
    igEndFrame()
    {.emit:"""
      `pDevice`->SetRenderState(D3DRS_ZENABLE, FALSE);
      `pDevice`->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
      `pDevice`->SetRenderState(D3DRS_SCISSORTESTENABLE, FALSE);
    """.} #TODO: Create a proper d3dx9 wrapper instead of using emit all over the place
    igRender()
    dx9RenderDrawData()

  ogPresent(pDevice, src, dst, wndOverride, dirtyRegion)

proc hkReset(pDevice: ptr IDirect3DDevice9, params: ptr D3DPRESENT_PARAMETERS): HRESULT {.stdcall.} =
  dx9InvalidateDeviceObjects()
  #gRenderer.release()
  result = ogReset(pDevice, params)
  assert(dx9CreateDeviceObjects(), "dx9CreateDeviceObjects failed") 
  #gRenderer.acquire()
  
  


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
      try:
        for fn in gCreateMoveProcs: fn(cmd)
      except: handleException("CreateMove")

    cmd.viewAngles.normalize()
    cmd.viewAngles.clamp()
    retValue
  mHook(thiscall(self: ptr IPanel, panelId: uint, forceRePaint: bool, allowForce: bool) -> void, pPaintTraverse):
    ogProcCall(self, panelId, forceRePaint, allowForce) 
    let panelName = IPanel.instance.panelName(panelId)
    
    if panelName == "MatSystemTopPanel":
      try:
        for fn in gPaintTraverseProcs: fn(panelId, forceRePaint, allowForce)
      except: handleException("PaintTraverse")


proc Entry(hInstance: HINSTANCE) {.cdecl, exportc.} =
  try:
    realEntry()
  except: handleException("Entry")
     
import ../interfaces, ../structs, ../imgui, ../helpers, ../renderer
import winim/lean as win
import macros

var gCreateMoveProcs* {.global.}: seq[proc(cmd: ptr CUserCmd): void]
var gPaintTraverseProcs* {.global.}: seq[proc(panelId: uint, forceRePaint: bool, allowForce: bool): void]
var gRenderFrameProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gPreResetFrameProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gPostResetFrameProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gDrawIndexedPrimitive* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9, `type`: D3DPRIMITIVETYPE, baseVertexIndex: cint, minVertexIndex: cuint, numVertices: cuint, startIndex: cuint, primCount: cuint)]
var gImGuiProcs* {.global.}: seq[proc(): void]
var gInitRenderProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gLocalPlayer*: ptr Entity = nil
var gGuiEnabled* {.global.}: bool


var ogWndProc* {.global.}: proc(hWnd: HWND, message: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.stdcall.} = nil
var ogPresent* {.global.}: proc(pDevice: ptr IDirect3DDevice9, src: ptr win.RECT, dst: ptr win.RECT, wndOverride: HWND, dirtyRegion: ptr RGNDATA): HRESULT {.stdcall.} = nil
var ogReset* {.global.}: proc(pDevice: ptr IDirect3DDevice9, params: ptr D3DPRESENT_PARAMETERS): HRESULT {.stdcall.} = nil
var ogDrawIndexedPrimitive* {.global.}: proc(pDevice: ptr IDirect3DDevice9, `type`: D3DPRIMITIVETYPE, baseVertexIndex: cint, minVertexIndex: cuint, numVertices: cuint, startIndex: cuint, primCount: cuint): HRESULT {.stdcall.} = nil

macro section*(sectionDecl, body: untyped) = 
  let sectionType = sectionDecl[0]
  let varNames = sectionDecl[1..^1]

  template implAndAddProc(procDef, procSym, containerSym, body: untyped): untyped = 

    procDef
    
    base.containerSym.add(procSym)
  var containerSym: NimNode = nil
  var retTy: NimNode = nil
  var procDef: NimNode = nnkProcDef.newTree(
    nskProc.genSym(),
    newEmptyNode(),
    newEmptyNode(),
    nnkFormalParams.newNimNode(),
    newEmptyNode(),
    newEmptyNode(),
    body
  )

  case $sectionType:
  of "PostCreateMove":
    if not(varNames.len == 1): error "Invalid number of parameters for section: CreateMove", sectionDecl

    containerSym = "gCreateMoveProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("CUserCmd".ident),
      newEmptyNode()
    ))
  of "InitRender":
    if not(varNames.len == 1): error "Invalid number of parameters for section: Init", sectionDecl

    containerSym = "gInitRenderProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("IDirect3DDevice9".ident),
      newEmptyNode()
    ))
  of "PaintTraverse":
    if not(varNames.len == 3): error "Invalid number of parameters for section: PaintTraverse", sectionDecl
    let varName0 = if varNames[0] == "_".ident: nskParam.genSym("0") else: varNames[0]
    let varName1 = if varNames[1] == "_".ident: nskParam.genSym("1") else: varNames[1]
    let varName2 = if varNames[2] == "_".ident: nskParam.genSym("2") else: varNames[2]
    containerSym = "gPaintTraverseProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varName0,
      "uint".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varName1,
      "bool".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varName2,
      "bool".ident,
      newEmptyNode()
    ))
  of "ImGui":
    containerSym = "gImGuiProcs".ident
    procDef[3].add("void".ident)
    case varNames.len:
    of 1: body.insert(0, parseExpr("igBegin(\"" & $varNames[0] & "\")"))
    of 2: body.insert(0, parseExpr("igBegin(\"" & $varNames[0] & "\"," & $toStrLit(varNames[1]) & ")"))
    of 3: body.insert(0, parseExpr("igBegin(\"" & $varNames[0] & "\"," & $toStrLit(varNames[1]) & "," & $toStrLit(varNames[2]) & ")"))
    else: error "Invalid number of parameters for section: ImGui", sectionDecl
    
    body.add(parseExpr("igEnd()"))
  of "FrameRender":
    if not(varNames.len == 1): error "Invalid number of parameters for section: FrameRender", sectionDecl
    containerSym = "gRenderFrameProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("IDirect3DDevice9".ident),
      newEmptyNode()
    ))
  of "PreResetFrame":
    if not(varNames.len == 1): error "Invalid number of parameters for section: PreResetFrame", sectionDecl
    containerSym = "gPreResetFrameProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("IDirect3DDevice9".ident),
      newEmptyNode()
    ))
  of "PostResetFrame":
    if not(varNames.len == 1): error "Invalid number of parameters for section: PostResetFrame", sectionDecl
    containerSym = "gPostResetFrameProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("IDirect3DDevice9".ident),
      newEmptyNode()
    ))
  of "DrawIndexedPrimitive":
    if not(varNames.len == 7): error "Invalid number of parameters for section: DrawIndexedPrimitive", sectionDecl
    containerSym = "gDrawIndexedPrimitive".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkPtrTy.newTree("IDirect3DDevice9".ident),
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[1],
      "D3DPRIMITIVETYPE".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[2],
      "cint".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[3],
      "cuint".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[4],
      "cuint".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[5],
      "cuint".ident,
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[6],
      "cuint".ident,
      newEmptyNode()
    ))
  else: error("Section for " & $sectionType & " not implemented yet!", sectionDecl)

  getAst(implAndAddProc(procDef, procDef[0], containerSym, body))


export structs, interfaces, imgui, helpers, renderer
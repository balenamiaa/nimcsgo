import ../interfaces, ../structs, ../imgui, ../helpers, ../renderer
import macros

var gCreateMoveProcs* {.global.}: seq[proc(cmd: ptr CUserCmd): void]
var gPaintTraverseProcs* {.global.}: seq[proc(panelId: uint, forceRePaint: bool, allowForce: bool): void]
var gRenderFrameProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gImGuiProcs* {.global.}: seq[proc(): void]
var gInitRenderProcs* {.global.}: seq[proc(pDevice: ptr IDirect3DDevice9): void]
var gLocalPlayer*: ptr Entity = nil
#var gRenderer* {.global.}: Renderer
var gGuiEnabled* {.global.}: bool

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
  of "CreateMove":
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
  else: error("Section for " & $sectionType & " not implemented yet!", sectionDecl)

  getAst(implAndAddProc(procDef, procDef[0], containerSym, body))


export structs, interfaces, imgui, helpers, renderer
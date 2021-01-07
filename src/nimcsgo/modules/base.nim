import ../interfaces, ../structs, ../imgui, ../helpers
import macros

var gCreateMoveProcs* {.global.}: seq[proc(cmd: ptr CUserCmd)]
var gPaintTraverseProcs* {.global.}: seq[proc(panelId: uint, forceRePaint: bool, allowForce: bool)]
var gImGuiProcs* {.global.}: seq[proc()]
var gInitProcs* {.global.}: seq[proc()]
var gLocalPlayer*: ptr Entity = nil

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
  of "Init":
    if not(varNames.len == 0): error "Invalid number of parameters for section: Init", sectionDecl

    containerSym = "gInitProcs".ident
    procDef[3].add("void".ident)
  of "PaintTraverse":
    if not(varNames.len == 3): error "Invalid number of parameters for section: PaintTraverse", sectionDecl
    containerSym = "gPaintTraverseProcs".ident
    procDef[3].add("void".ident)
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[0],
      nnkVarTy.newTree("uint".ident),
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[1],
      nnkVarTy.newTree("bool".ident),
      newEmptyNode()
    ))
    procDef[3].add(nnkIdentDefs.newTree(
      varNames[2],
      nnkVarTy.newTree("bool".ident),
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

  else: error("Section for " & $sectionType & " not implemented yet!", sectionDecl)

  getAst(implAndAddProc(procDef, procDef[0], containerSym, body))


export structs, interfaces, imgui, helpers
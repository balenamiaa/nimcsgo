import ../interfaces, ../structs
import macros

var gCreateMoveProcs* {.global.}: seq[proc(cmd: var CUserCmd)]
var gPaintTraverseProcs* {.global.}: seq[proc(panelId: uint, forceRePaint: bool, allowForce: bool)]
var gInitProcs* {.global.}: seq[proc()]
var gLocalPlayer*: ptr Entity = nil

macro section*(sectionDecl, body: untyped) = 
  let sectionType = sectionDecl[0]
  let varNames = sectionDecl[1..^1]

  template implAndAddProc(procDef, procSym, containerSym, body: untyped): untyped = 
    when not(compiles(base.gCreateMoveProcs)) or not(compiles(base.gInitProcs)):
      {.error: "Import modules.base in order to use module system facilities.".}

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
      nnkVarTy.newTree("CUserCmd".ident),
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
  else: error("Section for " & $sectionType & " not implemented yet!", sectionDecl)

  getAst(implAndAddProc(procDef, procDef[0], containerSym, body))


export structs, interfaces
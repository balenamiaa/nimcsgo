import macros, sequtils
macro vtableInterface*(interfaceName, interfaceDecl: untyped) = 
  result = nnkStmtList.newNimNode()

  template interfaceDeclImpl(interfaceName: untyped): untyped = 
    type interfaceName* = object {.pure.}
      vtable*: ptr ptr pointer

  result.add(getAst(interfaceDeclImpl(interfaceName)))

  for stmt in interfaceDecl.children:
    if stmt[0] != "idx".ident: (discard result.add(stmt); continue)
    let idx = stmt[1]
    let name = stmt[2][0][0]
    let params = stmt[2][0][3]
    let pragmas = stmt[2][0][4] or (error "Please specify a calling convention pragma"; newEmptyNode())
    let body = block:
      var result = nnkStmtList.newNimNode()
      let procType = nnkProcTy.newNimNode().add(params).add(pragmas)
      let arguments = params[1..^1].map(proc (x: auto): auto = x[0])

      template vtableMethodImpl(self, vtable, procType, idx: untyped) = cast[procType](cast[ptr pointer](cast[uint](self.vtable) + sizeof(pointer) * idx)[])

      let castProc = getAst(vtableMethodImpl("self".ident, "vtable".ident, "ProcType".ident, idx))
      result.add(nnkTypeSection.newTree(nnkTypeDef.newTree("ProcType".ident, newEmptyNode(), procType)))
      result.add(newCall(newPar(castProc), arguments))
      result
    result.add(nnkProcDef.newTree(
      name,
      newEmptyNode(),
      newEmptyNode(),
      params,
      pragmas,
      newEmptyNode(),
      body
    ))

macro genInstantiation*(T: untyped) = 
  template implInstantiation(Tx, Tz: untyped, Txx: string) = 
    var Tz: pointer = nil
    template setInstance*(constraint: typedesc[Tx], pInstance: pointer) = 
      Tz = pInstance
    template instance*(constraint: typedesc[Tx]): ptr Tx = 
      cast[ptr Tx](Tz)
  let 
    Tz = nskVar.genSym()
    Txx = $T & " hasn't been set before use in the code-base."
  getAst(implInstantiation(T, Tz, Txx))
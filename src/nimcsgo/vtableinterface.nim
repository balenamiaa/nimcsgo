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
    let pragmas = stmt[2][0][4]
    let body = block:
      var result = nnkStmtList.newNimNode()
      let procType = nnkProcTy.newNimNode().add(params).add(nnkPragma.newTree(
          newIdentNode("thiscall")))
      let arguments = params[1..^1].map(proc (x: auto): auto = x[0])

      template vtableMethodImpl(self, vtable, procType, idx: untyped) = cast[
          procType](cast[ptr pointer](cast[uint](self.vtable) + sizeof(
          pointer) * idx)[])

      let castProc = getAst(vtableMethodImpl("self".ident, "vtable".ident,
          "ProcType".ident, idx))
      result.add(nnkTypeSection.newTree(nnkTypeDef.newTree("ProcType".ident,
          newEmptyNode(), procType)))
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
  echo toStrLit result


macro vtable2*(ast: untyped): untyped =
  assert(ast.len() == 2)
  assert(ast[0].kind == nnkTypeSection and ast[1].kind == nnkCall)
  assert($ast[1][0] == "methods")

  let def = ast[0][0]
  let methods = ast[1][1]

  assert(def[2].kind == nnkObjectTy)

  let vtableName = def[0]
  var vtableSizeLit = newLit(methods.len())
  var vtableProcList = nnkStmtList.newNimNode()
  let vtableNameIdent = (proc(): NimNode =
    if vtableName.kind == nnkIdent:
      return vtableName
    elif vtableName.kind == nnkPostfix:
      assert vtableName[0] == "*".ident
      return vtableName[1]
    else:
      error("Invalid AST")
  )()


  var vtableDefaultImplBrackets = nnkStmtList.newNimNode()
  var vtableDefaultImpl = parseExpr("proc default*(T: typedesc[" &
      $vtableNameIdent & "]): T = discard")
  vtableDefaultImpl[6] = nnkStmtList.newTree(
    parseStmt("var inner = new array[" & $vtableSizeLit.intVal & ", pointer]"),
    vtableDefaultImplBrackets,
    nnkObjConstr.newTree(
      vtableNameIdent,
      nnkExprColonExpr.newTree(
        "mVTable".ident,
        "inner".ident,
    )
  )
  )


  template implMethodBody(idx: uint, procType: untyped,
      procArgs: untyped): untyped =
    cast[procType](self.mVTable[idx])(procArgs)


  var vtableIdxCache: seq[int]

  var overrideIdx: int = -1
  var vfunctionIdx: int = 0
  var defaultVFunctionIdx: int = 0

  for idx, `method` in methods:
    if `method`.kind == nnkPrefix:
      overrideIdx = `method`[1].intVal.int
      continue

    var methodDef = `method`.copy()
    methodDef[3].insert(1, nnkIdentDefs.newTree(
      "self".ident,
      nnkPtrTy.newTree(vtableNameIdent),
      newEmptyNode()
    ))

    let procType = nnkProcTy.newTree(
      (
        let copy = `method`[3].copy();
        copy.insert(1, nnkIdentDefs.newTree(
          "pThis".ident,
          "pointer".ident,
          newEmptyNode()));
        copy
      ),
      nnkPragma.newTree("thiscall".ident)
    )

    let procArgs = nnkArglist.newNimNode()

    for argIdx, arg in methodDef[3][1..^1]:
      assert(arg.kind == nnkIdentDefs)
      for idx in countup(0, arg.len() - 3):
        let argType = if argIdx == 0: "pointer".ident else: arg[^2]
        let argIdent = if argIdx == 0:
          parseExpr($arg[idx])
        else:
          arg[idx]
        procArgs.add(quote do: cast[`argType`](`argIdent`))

    let curVFunctionIdx = block:
      var curVFunctionIdx = vfunctionIdx
      if overrideIdx != -1:
        curVFunctionIdx = overrideIdx
        vfunctionIdx = curVFunctionIdx + 1
        if curVFunctionIdx in vtableIdxCache: error(
            "Invalid AST: Virtual Function with idx: " & $curVFunctionIdx &
            " already defined", `method`)
      else:
        inc vfunctionIdx

      vtableIdxCache.add(curVFunctionIdx)
      curVFunctionIdx
    if curVFunctionIdx >= vtableSizeLit.intVal:
      vtableSizeLit.intVal = curVFunctionIdx + 1


    let noDefaultImplementation = quote do:
      raise newException(NilAccessError, "Invalid call to virtual function that has no default implementation")

    while defaultVFunctionIdx < curVFunctionIdx:
      let p = nnkCast.newTree(
          ident "pointer",
          nnkLambda.newTree(
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode(),
            procType[0],
            procType[1],
            newEmptyNode(),
            noDefaultImplementation
        )
      )
      vtableDefaultImplBrackets.add(
        nnkAsgn.newTree(
          nnkBracketExpr.newTree(
            "inner".ident,
            newLit defaultVFunctionIdx
        ),
        p
      )
      )
      inc defaultVFunctionIdx

    let defaultVFunctionBody = if methodDef.body.kind !=
        nnkEmpty: methodDef.body else: noDefaultImplementation
    let p = nnkCast.newTree(
          ident "pointer",
          nnkLambda.newTree(
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode(),
            procType[0],
            procType[1],
            newEmptyNode(),
            nnkStmtList.newTree(
            parseStmt("let self = cast[ptr " & $vtableNameIdent & "](pThis)"),
            defaultVFunctionBody
      )
      )
    )
    vtableDefaultImplBrackets.add(
        nnkAsgn.newTree(
          nnkBracketExpr.newTree(
            "inner".ident,
            newLit defaultVFunctionIdx
      ),
      p
    )
      )
    inc defaultVFunctionIdx

    methodDef.body = getAst(implMethodBody(curVFunctionIdx, procType, procArgs))

    vtableProcList.add(methodDef)
    overrideIdx = -1

  var vtableObject = quote do:
    type `vtableName` = object
      mVtable*: ref array[`vtableSizeLit`, pointer]

  for field in def[2][2]:
    if field[^1].kind != nnkEmpty:
      vtableDefaultImpl[6][0].add(nnkExprColonExpr.newTree(
        field[0],
        field[^1]
      ))
      field[^1] = newEmptyNode()
    vtableObject[0][2][2].add(field)

  result = quote do:
    `vtableObject`
    `vtableProcList`

    `vtableDefaultImpl`
  echo toStrLit result


#Slowly transition into this from old vtableInterface macro
macro vtable*(ast: untyped): untyped =
  assert(ast.len() == 2)
  assert(ast[0].kind == nnkTypeSection and ast[1].kind == nnkCall)
  assert($ast[1][0] == "methods")

  let def = ast[0][0]
  let methods = ast[1][1]

  assert(def[2].kind == nnkObjectTy)

  let vtableName = def[0]
  var vtableSizeLit = newLit(methods.len())
  var vtableProcList = nnkStmtList.newNimNode()
  let vtableNameIdent = (proc(): NimNode =
    if vtableName.kind == nnkIdent:
      return vtableName
    elif vtableName.kind == nnkPostfix:
      assert vtableName[0] == "*".ident
      return vtableName[1]
    else:
      error("Invalid AST")
  )()


  var vtableDefaultImplBrackets = nnkStmtList.newNimNode()
  var vtableDefaultImpl = parseExpr("proc default*(T: typedesc[" &
      $vtableNameIdent & "]): T = discard")
  vtableDefaultImpl[6] = nnkStmtList.newTree(
    parseStmt("var inner = new array[" & $vtableSizeLit.intVal & ", pointer]"),
    vtableDefaultImplBrackets,
    nnkObjConstr.newTree(
      vtableNameIdent,
      nnkExprColonExpr.newTree(
        "mVTable".ident,
        "inner".ident,
    )
  )
  )


  template implMethodBody(idx: uint, procType: untyped,
      procArgs: untyped): untyped =
    cast[procType](self.mVTable[idx])(procArgs)


  var vtableIdxCache: seq[int]

  var overrideIdx: int = -1
  var vfunctionIdx: int = 0
  var defaultVFunctionIdx: int = 0

  for idx, `method` in methods:
    if `method`.kind == nnkPrefix:
      overrideIdx = `method`[1].intVal.int
      continue

    var methodDef1 = `method`.copy()
    methodDef1[3].insert(1, nnkIdentDefs.newTree(
      "self".ident,
      nnkVarTy.newTree(vtableNameIdent),
      newEmptyNode()
    ))

    var methodDef2 = `method`.copy()
    methodDef2[3].insert(1, nnkIdentDefs.newTree(
      "self".ident,
      nnkPtrTy.newTree(vtableNameIdent),
      newEmptyNode()
    ))

    let procType = nnkProcTy.newTree(
      (
        let copy = `method`[3].copy();
        copy.insert(1, nnkIdentDefs.newTree(
          "pThis".ident,
          "pointer".ident,
          newEmptyNode()));
        copy
      ),
      nnkPragma.newTree("thiscall".ident)
    )

    var procArgs1 = nnkArglist.newNimNode()
    var procArgs2 = nnkArglist.newNimNode()
    for argIdx, arg in methodDef1[3][1..^1]:
      assert(arg.kind == nnkIdentDefs)
      for idx in countup(0, arg.len() - 3):
        let argType = if argIdx == 0: "pointer".ident else: arg[^2]
        let argIdent = if argIdx == 0:
          parseExpr($arg[idx] & ".addr")
        else:
          arg[idx]
        procArgs1.add(quote do: cast[`argType`](`argIdent`))

    for argIdx, arg in methodDef2[3][1..^1]:
      assert(arg.kind == nnkIdentDefs)
      for idx in countup(0, arg.len() - 3):
        let argType = if argIdx == 0: "pointer".ident else: arg[^2]
        let argIdent = arg[idx]
        procArgs2.add(quote do: cast[`argType`](`argIdent`))

    let curVFunctionIdx = block:
      var curVFunctionIdx = vfunctionIdx
      if overrideIdx != -1:
        curVFunctionIdx = overrideIdx
        vfunctionIdx = curVFunctionIdx + 1
        if curVFunctionIdx in vtableIdxCache: error(
            "Invalid AST: Virtual Function with idx: " & $curVFunctionIdx &
            " already defined", `method`)
      else:
        inc vfunctionIdx

      vtableIdxCache.add(curVFunctionIdx)
      curVFunctionIdx
    if curVFunctionIdx >= vtableSizeLit.intVal:
      vtableSizeLit.intVal = curVFunctionIdx + 1


    let noDefaultImplementation = quote do:
      raise newException(NilAccessError, "Invalid call to virtual function that has no default implementation")

    while defaultVFunctionIdx < curVFunctionIdx:
      let p = nnkCast.newTree(
          ident "pointer",
          nnkLambda.newTree(
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode(),
            procType[0],
            procType[1],
            newEmptyNode(),
            noDefaultImplementation
        )
      )
      vtableDefaultImplBrackets.add(
        nnkAsgn.newTree(
          nnkBracketExpr.newTree(
            "inner".ident,
            newLit defaultVFunctionIdx
        ),
        p
      )
      )
      inc defaultVFunctionIdx

    let defaultVFunctionBody = if `method`.body.kind !=
        nnkEmpty: `method`.body else: noDefaultImplementation
    let p = nnkCast.newTree(
          ident "pointer",
          nnkLambda.newTree(
            newEmptyNode(),
            newEmptyNode(),
            newEmptyNode(),
            procType[0],
            procType[1],
            newEmptyNode(),
            nnkStmtList.newTree(
            parseStmt("let self = cast[ptr " & $vtableNameIdent & "](pThis)"),
            defaultVFunctionBody
      )
      )
    )
    vtableDefaultImplBrackets.add(
        nnkAsgn.newTree(
          nnkBracketExpr.newTree(
            "inner".ident,
            newLit defaultVFunctionIdx
      ),
      p
    )
      )
    inc defaultVFunctionIdx

    methodDef1.body = getAst(implMethodBody(curVFunctionIdx, procType, procArgs1))
    methodDef2.body = getAst(implMethodBody(curVFunctionIdx, procType, procArgs2))
    vtableProcList.add(methodDef1)
    vtableProcList.add(methodDef2)
    overrideIdx = -1

  var vtableObject = quote do:
    type `vtableName` = object
      mVtable*: ref array[`vtableSizeLit`, pointer]

  for field in def[2][2]:
    if field[^1].kind != nnkEmpty:
      vtableDefaultImpl[6][0].add(nnkExprColonExpr.newTree(
        field[0],
        field[^1]
      ))
      field[^1] = newEmptyNode()
    vtableObject[0][2][2].add(field)

  result = quote do:
    `vtableObject`
    `vtableProcList`

    `vtableDefaultImpl`
  echo toStrLit result


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



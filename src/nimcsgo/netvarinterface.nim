import ./netvars, macros, strutils, tables

macro netvar*(table, netvar: string, BaseClass, decl: untyped) =
  let offsetLit = newLit(netvars.gNetvars["$#=>$#" % [$table, $netvar]])
  let public = decl[0][0] == "*".ident
  let procIdentifier = if not public: decl[0][1] else: nnkPostfix.newTree(decl[0][0], decl[0][1])
  let returnType = if public: decl[0][2][1] else: decl[0][2]
  let params = nnkFormalParams.newTree(
    returnType,
    nnkIdentDefs.newTree(
      "self".ident,
      nnkPtrTy.newTree(BaseClass),
      newEmptyNode()
    )
  )

  result = nnkProcDef.newTree(
    procIdentifier,
    newEmptyNode(),
    newEmptyNode(),
    params,
    newEmptyNode(),
    newEmptyNode(),
    nnkStmtList.newTree(
      nnkBracketExpr.newTree(
        nnkCast.newTree(
          nnkPtrTy.newTree(returnType),
          nnkInfix.newTree(
            "+".ident,
            nnkCast.newTree(
              "uint".ident,
              "self".ident
            ),
            offsetLit
          )
        )
      ),
    )
  )


proc getOffset*(table, netvar: string): uint {.compileTime.} = netvars.gNetvars["$#=>$#" % [$table, $netvar]]

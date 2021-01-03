import macros, sequtils, strutils, sugar, options
import winim/inc/[winbase, windef]

macro vtableInterface*(interfaceName, interfaceDecl: untyped) = 
  result = nnkStmtList.newNimNode()

  template interfaceDeclImpl(interfaceName: untyped): untyped = 
    type interfaceName* = object
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

macro netvar*(table, netvar: string, BaseClass, decl: untyped) =
  let procIdentifier = decl[0][1]
  let public = decl[0][0] == "*".ident
  let returnType = if public: decl[0][2][1] else: decl[0][2]
  let params = nnkFormalParams.newTree(
    returnType,
    nnkIdentDefs.newTree(
      "self".ident,
      nnkVarTy.newTree(BaseClass),
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
              nnkDotExpr.newTree(
                "self".ident,
                "addr".ident
              )
            ),
            nnkCall.newTree(
              "getOffset".ident,
              table,
              netvar
            )
          )
        )
      ),
    )
  )

macro genInstantiation*(T: untyped) = 
  template implInstantiation(Tx, Tz: untyped, Txx: string) = 
    var Tz: pointer = nil
    template setInstance*(constraint: typedesc[Tx], pInstance: pointer) = 
      Tz = pInstance
    template instance*(constraint: typedesc[Tx]): var Tx = 
      cast[var Tx](Tz)
  let 
    Tz = nskVar.genSym()
    Txx = $T & " hasn't been set before use in the code-base."
  getAst(implInstantiation(T, Tz, Txx))

template implPtrArithmetic* =
  template `+`[T](p: ptr T, off: int): ptr T =
    cast[ptr T](cast[ByteAddress](p) +% off * sizeof(T))
  
  template `+=`[T](p: ptr T, off: int) =
    p = p + off
  
  template `-`[T](p: ptr T, off: int): ptr T =
    cast[ptr T](cast[ByteAddress](p) -% off * sizeof(T))
  
  template `-=`[T](p: ptr T, off: int) =
    p = p - off
  
  template `[]`[T](p: ptr T, off: int): T =
    (p + off)[]
  
  template `[]=`[T](p: ptr T, off: int, val: T) =
    (p + off)[] = val

proc toString(bytes: openarray[byte | char | string]): string = 
  result = newStringOfCap(bytes.len)
  for byte in bytes:
    result.add(byte)

proc patternToBytes(pattern: string): seq[int16] {.compileTime.} = 
  let chunkedPatterns = @pattern.distribute(pattern.len div 2)
  result = collect(newSeqOfCap(chunkedPatterns.len)):
    for chunk in chunkedPatterns: 
      if chunk[0] != '?': 
        chunk.toString.fromHex[:int16]
      else: -1.int16

{.checks: off, boundChecks: off, optimization: speed.} 
proc patternScan*(pattern: static[string], hModule: HMODULE): Option[pointer] = 
  implPtrArithmetic

  const pattern = pattern.patternToBytes()
  const patternLen = pattern.len

  let dosHeaders = cast[PIMAGE_DOS_HEADER](hModule)
  let e_lfanew = dos_headers[].e_lfanew
  let nt_headers = cast[PIMAGE_NT_HEADERS](hModule + e_lfanew)
  let moduleSize = ntHeaders[].OptionalHeader.SizeOfImage
  var pModuleTail: ptr byte = cast[ptr byte](hModule)
  let pModuleHead: ptr byte = pModuleTail + (moduleSize - 1)
  while pModuleTail <= (pModuleHead - patternLen):
    block scan:
      for offset in 0..<patternLen:
        if cast[int16](pModuleTail[offset]) != pattern[offset] and pattern[offset] != -1: break scan
      return some(cast[pointer](pModuleTail))
    pModuleTail += patternLen

proc patternScan*(pattern: static[string], moduleName: string): Option[pointer] = patternScan(pattern, GetModuleHandleA(moduleName))

proc createInterface*(moduleName: string, interfaceName: string): pointer =
  let hModule = GetModuleHandleA(moduleName)

  var createInterface: proc(name: cstring, returnCode: var cint): pointer {.cdecl.} = nil; createInterface = cast[typeof(createInterface)](GetProcAddress(hModule, "CreateInterface"))
  var trash: cint = 0
  result = createInterface(interfaceName, trash)

  if result == nil:
    raise newException(LibraryError, "Failed to get interface for $# in module $#" % [interfaceName, moduleName])

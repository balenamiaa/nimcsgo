import macros, sequtils, strutils, sugar, options, random
import winim/inc/[winbase, windef]

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

proc patternToBytes(pattern: string): seq[int16] = 
  let pattern = pattern.replace(" ", "")
  let chunkedPatterns = @pattern.distribute(pattern.len div 2)
  result = collect(newSeqOfCap(chunkedPatterns.len)):
    for chunk in chunkedPatterns: 
      if chunk[0] != '?': 
        chunk.toString.fromHex[:int16]
      else: -1.int16

{.checks: off, boundChecks: off, optimization: speed.} 
proc patternScan*(pattern: string, hModule: HMODULE): Option[pointer] = 
  implPtrArithmetic

  let pattern = pattern.patternToBytes()
  let patternLen = pattern.len

  let dosHeaders = cast[PIMAGE_DOS_HEADER](hModule)
  let e_lfanew = dos_headers[].e_lfanew
  let nt_headers = cast[PIMAGE_NT_HEADERS](hModule + e_lfanew)
  let moduleSize = ntHeaders[].OptionalHeader.SizeOfImage
  var pModuleTail: ptr byte = cast[ptr byte](hModule)
  let pModuleHead: ptr byte = pModuleTail + (moduleSize - 1)
  while pModuleTail <= (pModuleHead - patternLen):
    var skip: int = 1
    block scan:
      for offset in 0..<patternLen:
        if pattern[offset] == -1: continue
        if cast[int16](pModuleTail[offset]) != pattern[offset]: 
          skip = offset + 1
          break scan
      return some(cast[pointer](pModuleTail))
    pModuleTail += skip

proc patternScan*(pattern: string, moduleName: string): Option[pointer] = patternScan(pattern, GetModuleHandleA(moduleName))

proc createInterface*(moduleName: string, interfaceName: string): pointer =
  let hModule = GetModuleHandleA(moduleName)

  var createInterface: proc(name: cstring, returnCode: var cint): pointer {.cdecl.} = nil; createInterface = cast[typeof(createInterface)](GetProcAddress(hModule, "CreateInterface"))
  var trash: cint = 0
  result = createInterface(interfaceName, trash)

  if result == nil:
    raise newException(LibraryError, "Failed to get interface for $# in module $#" % [interfaceName, moduleName])

template `!`*[T](a: Option[T]): T =
    if a.isSome():
      a.unsafeGet()
    else:
      return


var rng {.compileTime.} = initRand(0x1337DEADBEEF)


macro xorEncrypt*(str: string): untyped = 
  const xorKey = rng.rand(uint8.high()).uint8
  template xorStr(str: string): untyped = 
    var newStr = newString(str.len())
    for idx, c in str:
      newStr[idx] = (c.uint8 xor xorKey).char
    newStr
  var strLit = xorStr($str)
  return getAst(xorStr(strLit))
  
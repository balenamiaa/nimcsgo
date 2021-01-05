import winim/lean, strutils, strformat, os, tables, macros
import ../nimcsgo/interfaces/ibaseclient, ../nimcsgo/helpers, ../nimcsgo/structs/clientclass, ../nimcsgo/structs/recvprop
{.compile: "shim.c".}


const outFile =  currentSourcePath.parentDir.parentDir & "/nimcsgo/netvars.nim" 


proc Entry(hInstance: HINSTANCE) {.cdecl, exportc.} =
  IBaseClient.setInstance(createInterface("client.dll", "VClient018"))
  var netvars: Table[string, uint]

  proc storeProps(groupName: string, recvTable: ptr RecvTable, childOffset: uint) = 
    implPtrArithmetic

    for idx in 0..<recvTable.nProps:
      let pProp = recvTable.pProps + idx.int
      if pProp == nil or pProp.propName[0].isDigit or pProp.propName == "baseclass": 
        continue

      let child = pProp.dataTable
      if pProp.propKind == ptDataTable and child != nil and child.tableName[0] == 'D':
        if child.nProps > 0: storeProps(groupName, child, pProp.offset)
      
      let formatted = fmt"{groupName}=>{pProp.propName}"
      if not(formatted in netvars) and(
        pProp.propKind == ptInt or 
        pProp.propKind == ptFloat or 
        pProp.propKind == ptString or 
        pProp.propKind == ptVec or 
        pProp.propKind == ptVecXY): netvars[formatted] = pProp.offset + childOffset

  for clientClass in IBaseClient.instance.clientClassTail.children():
    let recvTable = clientClass.recvTable
    if recvTable == nil: continue
    storeProps($recvTable.tableName, recvTable, 0)

  let file = open(outFile, fmWrite)
  file.write("""
  import tables
  var gNetvars* {.compileTime.} = initTable[string, uint]()
  static:
  """.unindent)

  for key,offset in netvars: file.write("  gNetvars[\"$1\"] = $2\n" % [key, $offset])
  file.write("  gNetvars[\"CustomTable=>Dormancy\"] = 0xED\n")
  file.close()
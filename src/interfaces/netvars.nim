from ../helpers import patternScan, implPtrArithmetic
import tables, ../structs/clientclass, ../structs/recvprop, ./ibaseclient, strformat, macros


var gNetvars {.global.}: Table[string, uint]
#var gTables: seq[ptr CRecvTable]

proc storeProps(groupName: string, recvTable: ptr CRecvTable, childOffset: uint) = 
  implPtrArithmetic

  for idx in 0..<recvTable.nProps:
    let pProp = recvTable.pProps + idx.int
    if pProp == nil: continue
    
    let child = pProp.dataTable
    if child != nil:
      if child.nProps > 0: storeProps(groupName, child, pProp.offset)
    
    let formatted = fmt"{groupName}=>{pProp.propName}"
    if not(formatted in gNetvars) and(
      pProp.propType == ptInt or 
      pProp.propType == ptFloat or 
      pProp.propType == ptString or 
      pProp.propType == ptVec or 
      pProp.propType == ptVecXY): gNetvars.add(formatted, pProp.offset + childOffset)

proc initialize*() = 
  for clientClass in IBaseClient.instance.clientClassTail.children():
    let recvTable = clientClass.recvTable
    if recvTable == nil: continue

    #gTables.add(recvTable)
    storeProps($recvTable.tableName, recvTable, 0)
  gNetvars["CustomTable=>Dormancy"] = 0xED.uint

proc getOffset*(table, netvar: string): uint = gNetvars.getOrDefault(table & "=>" & netvar, 0.uint)

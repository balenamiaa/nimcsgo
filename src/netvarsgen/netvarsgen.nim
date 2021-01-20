import winim/lean, strutils, strformat, os, tables, macros, options
import ../nimcsgo/interfaces/ibaseclient, ../nimcsgo/helpers, ../nimcsgo/structs/clientclass, ../nimcsgo/structs/recvprop

const outFile =  currentSourcePath.parentDir.parentDir & "/nimcsgo/netvars.nim" 
const csgoPath = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Counter-Strike Global Offensive\\" # hard coded for now



discard LoadLibraryA(csgoPath & "bin\\steam_api.dll")
discard LoadLibraryA(csgoPath & "bin\\tier0.dll")
discard LoadLibraryA(csgoPath & "bin\\vstdlib.dll")
discard LoadLibraryA(csgoPath & "bin\\phonon.dll")
discard LoadLibraryA(csgoPath & "bin\\parsifal.dll")
discard LoadLibraryA(csgoPath & "bin\\v8_libbase.dll")
discard LoadLibraryA(csgoPath & "bin\\icuuc.dll")
discard LoadLibraryA(csgoPath & "bin\\icui18n.dll")
discard LoadLibraryA(csgoPath & "bin\\v8.dll")
discard LoadLibraryA(csgoPath & "bin\\libavutil-54.dll")
discard LoadLibraryA(csgoPath & "bin\\libavcodec-56.dll")
discard LoadLibraryA(csgoPath & "bin\\libavformat-56.dll")
discard LoadLibraryA(csgoPath & "bin\\libavresample-2.dll")
discard LoadLibraryA(csgoPath & "bin\\libswscale-3.dll")
discard LoadLibraryA(csgoPath & "bin\\video.dll")
let clientdll = LoadLibraryA(csgoPath & "csgo\\bin\\client.dll")
IBaseClient.setInstance(createInterface(clientdll, "VClient018"))
var netvars: Table[string, uint]

proc storeProps(groupName: string, recvTable: ptr RecvTable, childOffset: uint) = 
  implPtrArithmetic

  for idx in 0..<recvTable.nProps:
    let pProp = recvTable.pProps + idx.int
    if pProp == nil or pProp.propName[0].isDigit or pProp.propName[0] == '"' or pProp.propName == "baseclass": 
      continue

    let children = pProp.dataTable
    if pProp.propKind == ptDataTable and children != nil and children.tableName[0] == 'D':
      if children.nProps > 0: storeProps(groupName, children, pProp.offset)
    
    let formatted = fmt"{groupName}=>{pProp.propName}"
    if not(formatted in netvars): netvars[formatted] = pProp.offset + childOffset

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
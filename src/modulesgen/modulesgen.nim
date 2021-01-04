import os, strutils, sequtils

const dir = "src/nimcsgo/modules"

let modules = open(dir & ".nim", fmWrite)
var moduleNames: seq[string]
for file in walkFiles(dir & "/*.nim"): moduleNames.add(file[0..^5].splitPath.tail)
for moduleName in moduleNames: modules.writeLine("import modules/", moduleName)

modules.write("\n\nexport ")
for i, moduleName in moduleNames: modules.write(moduleName & (if i < moduleNames.len - 1: ", " else: ""))

modules.close
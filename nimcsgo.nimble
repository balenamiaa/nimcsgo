#Package Info
version       = "0.1.0"
author        = "balenamiaa"
description   = " "
license       = "MIT"
srcDir        = "src"
backend = "c"
binDir = "output"
bin = @["nimcsgo"]

import os

requires "nim >= 1.4.2", "winim", "minhook", "bgfx"

proc inject(dllPath, exeFileName: string) = 
  selfExec "r --backend:cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --passL:\"-static-libgcc -static-libstdc++\" " &
           "--cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " & dllPath & " " & exeFileName

proc genModules() = selfExec "r src/modulesgen/modulesgen.nim"

task build_debug, "Build the dll in debug mode":
  genModules()
  selfExec "cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib " & 
           "--nomain --passL:\"-static-libgcc -static-libstdc++\" --out:debug.dll -d:noRes -d:useWinAnsi " &
           "-d:debug --debuginfo --linedir --nimcache:output/cache src/nimcsgo/nimcsgo.nim"
task run_debug, "Build the dll in debug mode and inject it":
  exec "nimble build_debug"
  inject("debug.dll".absolutePath(), "csgo.exe")
task inject_debug, "Inject the dll in debug mode without building":
  inject("debug.dll".absolutePath(), "csgo.exe")
task build_nimcsgo, "Build the dll in release mode":
  genModules()
  selfExec "cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib " &
           "--nomain --passL:\"-static-libgcc -static-libstdc++\" --outdir:output/ -d:noRes " &
           "-d:useWinAnsi -d:release src/nimcsgo/nimcsgo.nim"
task run_nimcsgo, "Build the dll in release mode and inject it":
  exec "nimble build_nimcsgo"
  inject("output/nimcsgo.dll".absolutePath(), "csgo.exe")
task build_netvarsgen, "Builds a dll for which it's to be injected into cs-go to fetch netvars to embed in the hack.":
  selfExec "cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app: " &
           " --nomain --passL:\"-static-libgcc -static-libstdc++\" --outdir:output/ -d:noRes " &
           "-d:useWinAnsi -d:release src/netvarsgen/netvarsgen.nim"
task fetch_netvars, "Inject a dll into cs-go to retrieve netvars":
  exec "nimble build_netvarsgen"
  inject("output/netvarsgen.dll".absolutePath(), "csgo.exe")
  


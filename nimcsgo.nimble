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

requires "nim >= 1.4.2", "winim", "minhook", "imgui"

task build_debug, "Build the dll in debug mode":
  selfExec "r --backend:cpp src/modulesgen/modulesgen.nim"
  selfExec "cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib " & 
           "--nomain --passL:-static-libgcc --out:debug.dll -d:noRes -d:useWinAnsi " &
           "-d:release -d:debug --debuginfo --linedir --nimcache:output/cache src/nimcsgo/nimcsgo.nim"
task run_debug, "Build the dll in debug mode and inject it":
  exec "nimble build_debug"
  selfExec "r --backend:cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " &
           "debug.dll".absolutePath() & " csgo.exe"
task build_nimcsgo, "Build the dll in release mode":
  selfExec("cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/nimcsgo/nimcsgo.nim")
task run_nimcsgo, "Build the dll in release mode and inject it":
  selfExec("cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/nimcsgo/nimcsgo.nim")
  selfExec("r --backend:cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " & "output/nimcsgo.dll".absolutePath() & " csgo.exe")
task build_netvarsgen, "Builds a dll for which it's to be injected into cs-go to fetch netvars to embed in the hack.":
  selfExec("cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/netvarsgen/netvarsgen.nim")
task fetch_netvars, "Inject a dll into cs-go to retrieve netvars":
  selfExec("cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/netvarsgen/netvarsgen.nim")
  selfExec("r --backend:cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " & "output/netvarsgen.dll".absolutePath() & " csgo.exe")


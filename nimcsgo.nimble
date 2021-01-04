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

requires "nim >= 1.4.2", "winim", "https://github.com/balenamiaa/minhook-nim.git"

task build_debug, "Build the dll in debug mode":
  selfExec "r --backend:c src/modulesgen/modulesgen.nim"
  selfExec "c --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib " & 
           "--nomain --passL:-static-libgcc --out:debug.dll -d:noRes -d:useWinAnsi " &
           "-d:release -d:debug --debuginfo --linedir src/nimcsgo/nimcsgo.nim"
task build_nimcsgo, "Build the dll in release mode":
  selfExec("c --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/nimcsgo/nimcsgo.nim")
task run_nimcsgo, "Build the dll in release mode and inject it":
  selfExec("c --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/nimcsgo/nimcsgo.nim")
  selfExec("r --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " & "output/nimcsgo.dll".absolutePath() & " csgo.exe")
task build_netvarsgen, "Builds a dll for which it's to be injected into cs-go to fetch netvars to embed in the hack.":
  selfExec("c --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/netvarsgen/netvarsgen.nim")
task fetch_netvars, "Inject a dll into cs-go to retrieve netvars":
  selfExec("c --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc --app:lib --nomain --passL:-static-libgcc --outdir:output/ -d:noRes -d:useWinAnsi -d:release src/netvarsgen/netvarsgen.nim")
  selfExec("r --gcc.path:C:/nim-1.4.2/dist/mingw32/bin --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi -d:release src/injector/injector.nim " & "output/netvarsgen.dll".absolutePath() & " csgo.exe")


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


let defaultFlags = (
  " --backend:cpp --gcc.cpp.path:C:/nim-1.4.2/dist/mingw32/bin --passL:\"-static-libgcc -static-libstdc++\"" &
  " --cpu:i386 --gc:arc -d:noRes -d:useWinAnsi"
)


proc inject(dllPath, exeFileName: string) = 
  selfExec "r" & defaultFlags & "-d:release src/injector/injector.nim " & dllPath & " " & exeFileName

proc genModules() = selfExec "r src/modulesgen/modulesgen.nim"

task build_debug, "Build the dll in debug mode":
  genModules()
  selfExec "cpp" & defaultFlags & "--nomain -d:debug --debuginfo --linedir -d:BGFX_STATIC_LIBSTDCPP --nimcache:output/cache --out:debug.dll src/nimcsgo/nimcsgo.nim"
task debug_nimcsgo, "Build the dll in debug mode and inject it":
  exec "nimble build_debug"
  inject("debug.dll".absolutePath(), "csgo.exe")
task inject_debug, "Inject the dll in debug mode without building":
  inject("debug.dll".absolutePath(), "csgo.exe")

task build_nimcsgo, "Build the dll in debug mode":
  genModules()
  selfExec "cpp" & defaultFlags & "--nomain -d:release -d:BGFX_STATIC_LIBSTDCPP --outdir:output/ src/nimcsgo/nimcsgo.nim"
task run_nimcsgo, "Build the dll in debug mode and inject it":
  exec "nimble build_nimcsgo"
  inject("output/nimcsgo.dll".absolutePath(), "csgo.exe")
task inject_nimcsgo, "Inject the dll in debug mode without building":
  inject("output/nimcsgo.dll".absolutePath(), "csgo.exe")
  
task build_netvarsgen, "Builds a dll for which it's to be injected into cs-go to fetch netvars to embed in the hack.":
  selfExec "cpp" & defaultFlags & "--nomain -d:release --outdir:output/ src/netvarsgen/netvarsgen.nim "
task fetch_netvars, "Inject a dll into cs-go to retrieve netvars":
  exec "nimble build_netvarsgen"
  inject("output/netvarsgen.dll".absolutePath(), "csgo.exe")
  


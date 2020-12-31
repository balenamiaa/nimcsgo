#Package Info
version       = "0.1.0"
author        = "balenamiaa"
description   = " "
license       = "MIT"
srcDir        = "src"
backend = "c"
binDir = "output"
bin = @["nimcsgo"]

#Dependencies
requires "nim >= 1.4.2", "winim"



type BuildMode {.pure.} = enum 
  bmDebug
  bmRelease

template build(buildMode: BuildMode) =
  when buildMode == bmDebug: 
    exec "nim c --app:lib --define:debug --nomain --nimcache:output/cache/ --o:output/nimcsgo.dll src/nimcsgo.nim"
  else:
    exec "nim c --app:lib --define:release --nomain --nimcache:output/cache/ --o:output/nimcsgo.dll src/nimcsgo.nim"

task build_release, "Build a dll in release mode": build(bmRelease)
task build_debug, "Build a dll in debug mode": build(bmDebug)


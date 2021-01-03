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
requires "nim >= 1.4.2", "winim", "minhook"

task dllDebug, "Build a dll":
  switch("gcc.path", "C:/nim-1.4.2/dist/mingw32/bin")
  switch("cpu", "i386")
  switch("gc", "arc")
  switch("define", "noRes")
  switch("app", "lib")
  switch("nomain")
  switch("passL","-static-libgcc")
  switch("nimcache", "output/cache/")
  switch("outdir", "output/")
  switch("d", "debug")
  switch("debuginfo")
  switch("linedir")
  setCommand("c", "src/nimcsgo.nim")
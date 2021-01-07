import imgui
import modules


var guiEnabled* {.global.}: bool = false

proc renderUi*() = 
  for fn in gImGuiProcs:
    fn()
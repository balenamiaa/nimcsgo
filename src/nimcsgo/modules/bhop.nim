import base, bitops


var enabled*: bool = true

section ImGui("BunnyHop", nil):
  igCheckbox("Enabled", enabled.addr)

section CreateMove(cmd):
  if not(enabled) or gLocalPlayer.lifeState != elsAlive:
    return
  
  if cmd.buttons.testBit(cbInJump.ord) and not gLocalPlayer.flags.int.testBit(efOnGround.ord):
    cmd.buttons.clearBit(cbInJump.ord)




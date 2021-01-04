import base, bitops



section CreateMove(cmd):
  if gLocalPlayer.lifeState != elsAlive:
    return
  
  if cmd.buttons.testBit(cbInJump.ord) and not gLocalPlayer.flags.testBit(efOnGround.ord):
    cmd.buttons.clearBit(cbInJump.ord)




import ../vtableinterface
import ../structs/vector


vtableInterface IDebugOverlay:
  idx 13: 
    proc inner_worldToScreen(self: ptr IDebugOverlay, vIn: var Vector3f0, vOut: var Vector3f0): int {.thiscall.}
  proc worldToScreen*(self: ptr IDebugOverlay, vIn: var Vector3f0, vOut: var Vector3f0): bool = self.inner_worldToScreen(vIn, vOut) != 1

genInstantiation IDebugOverlay
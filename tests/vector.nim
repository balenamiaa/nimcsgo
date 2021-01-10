import ../src/nimcsgo/structs/vector
import math







block Normalize:
  assert (normalized initQAngle(300, 30, 0   )) == initQAngle(-60, 30, 0)
  assert (normalized initQAngle(-300, 30, 0  )) == initQAngle(60, 30, 0)
  assert (normalized initQAngle(30, 120, 0   )) == initQAngle(30, -60, 0)
  assert (normalized initQAngle(30, -120, 0  )) == initQAngle(30, 60, 0)
  assert (normalized initQAngle(300, 120, 0  )) == initQAngle(-60, -60, 0)
  assert (normalized initQAngle(-300, 120, 0 )) == initQAngle(60, -60, 0)
  assert (normalized initQAngle(300, -120, 0 )) == initQAngle(-60, 60, 0)
  assert (normalized initQAngle(-300, -120, 0)) == initQAngle(60, 60, 0)

block Lerp:
  let current0 = initQAngle(-179, 0)
  let target0 = initQAngle(179, 0)
  let current1 = initQAngle(60, 0)
  let target1 = initQAngle(90, 0)
  let current2 = initQAngle(90, 0)
  let target2 = initQAngle(60, 0)
  assert lerp(target0, current0, 0.5).map(proc(x: float32): float32 = trunc(x)) == initQAngle(179, 0)
  assert lerp(target1, current1, 0.5) == initQAngle(75, 0)
  assert lerp(target2, current2, 0.5) == initQAngle(75, 0)
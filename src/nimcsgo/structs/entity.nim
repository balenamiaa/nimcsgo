import ../helpers

type
  EntityIndex* = distinct range[0.uint..high(uint)]
  EntityLifeState {.size: sizeof(cuint).} = enum
    Alive = 0
    Dying
    Dead

vtableInterface Entity:
  idx 218:
    proc update*(self: var Entity) {.thiscall.}
  idx 165:
    proc isWeapon*(self: var Entity): bool {.thiscall.}
  idx 155:
    proc isPlayer*(self: var Entity): bool {.thiscall.}

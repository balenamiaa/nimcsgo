import ../helpers, ../interfaces/netvars, ./vector

type
  EntityIndex* = distinct range[0.uint..high(uint)]
  EntityLifeState {.size: sizeof(cuint).} = enum
    elsAlive = 0
    elsDying
    elsDead
  EntityTeam {.size: sizeof(cuint).} = enum
    etNone
    etSpectator
    etT
    etCt

vtableInterface Entity:
  idx 218:
    proc update*(self: var Entity) {.thiscall.}
  idx 165:
    proc isWeapon*(self: var Entity): bool {.thiscall.}
  idx 155:
    proc isPlayer*(self: var Entity): bool {.thiscall.}

  netvar("DT_BasePlayer", "m_iHealth", Entity): health -> cint
  netvar("DT_BaseCombatWeapon", "m_flNextPrimaryAttack", Entity): nextPrimaryAttack -> float32
  netvar("DT_BaseCombatCharacter", "m_flNextAttack", Entity): nextAttacl -> float32
  netvar("DT_BasePlayer", "m_vecVelocity[0]", Entity): vel -> Vector3f0
  netvar("DT_BasePlayer", "m_vecOrigin", Entity): origin -> Vector3f0
  netvar("DT_BasePlayer", "m_vecViewOffset[0]", Entity): viewOffset -> Vector3f0
  netvar("DT_BaseCombatWeapon", "m_iClip1", Entity): remClip1 -> cint
  netvar("CustomTable", "Dormancy", Entity): dormant -> bool
  netvar("DT_CSPlayer", "m_iTeamNum", Entity): team -> EntityTeam
  netvar("DT_CSPlayer", "m_lifeState", Entity): lifeState -> EntityLifeState

  proc eye(self: var Entity): Vector3f0 = self.origin + self.viewOffset

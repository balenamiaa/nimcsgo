import ../netvarinterface, ../vtableinterface, ./vector

type
  EntityIndex* = distinct range[0.uint..high(uint)]
  EntityLifeState* {.size: sizeof(cuint).} = enum
    elsAlive
    elsDying
    elsDead
  EntityTeam* {.size: sizeof(cuint).} = enum
    etNone
    etSpectator
    etT
    etCt
  EntityFlags* = enum
    efON_GROUND              
    efDUCKING                
    efWATER_JUMP             
    efON_TRAIN               
    efIN_RAIN                
    efFROZEN                 
    efAT_CONTROLS            
    efCLIENT                 
    efFAKE_CLIENT            
    efIN_WATER               
    efFLY                    
    efSWIM                   
    efCONVEYOR               
    efNPC                    
    efGOD_MODE               
    efNO_TARGET              
    efAIM_TARGET             
    efPARTIAL_GROUND         
    efSTATIC_PROP            
    efGRAPHED                
    efGRENADE                
    efSTEP_MOVEMENT          
    efDONT_TOUCH             
    efBASE_VELOCITY          
    efWORLD_BRUSH            
    efOBJECT                 
    efKILL_ME                
    efON_FIRE                
    efDISSOLVING             
    efTRANS_RAG_DOLL         
    efUN_BLOCKABLE_BY_PLAYER
  EntityFlag = cuint

vtableInterface Entity:
  idx 218:
    proc update*(self: ptr Entity) {.thiscall.}
  idx 165:
    proc isWeapon*(self: ptr Entity): bool {.thiscall.}
  idx 155:
    proc isPlayer*(self: ptr Entity): bool {.thiscall.}

  netvar("DT_BasePlayer", "m_iHealth", Entity): health* -> cint
  netvar("DT_BaseCombatWeapon", "m_flNextPrimaryAttack", Entity): nextPrimaryAttack* -> float32
  netvar("DT_BaseCombatCharacter", "m_flNextAttack", Entity): nextAttacl* -> float32
  netvar("DT_BasePlayer", "m_vecVelocity[0]", Entity): vel* -> Vector3f0
  netvar("DT_BaseEntity", "m_vecOrigin", Entity): origin* -> Vector3f0
  netvar("DT_BasePlayer", "m_vecViewOffset[0]", Entity): viewOffset* -> Vector3f0
  netvar("DT_BasePlayer", "m_aimPunchAngle", Entity): aimPunchAng* -> QAngle
  netvar("DT_BaseCombatWeapon", "m_iClip1", Entity): remClip1* -> cint
  netvar("CustomTable", "Dormancy", Entity): dormant* -> bool
  netvar("DT_BaseEntity", "m_iTeamNum", Entity): team* -> EntityTeam
  netvar("DT_BasePlayer", "m_lifeState", Entity): lifeState* -> EntityLifeState
  netvar("DT_BasePlayer", "m_fFlags", Entity): flags* -> EntityFlag

  proc eye*(self: ptr Entity): Vector3f0 = self.origin + self.viewOffset

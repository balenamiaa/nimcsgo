import ../netvarinterface, ../vtableinterface, ./vector, ./studio, ./entitymodel, ../interfaces/imodelinfo, ./clientclass, ../helpers
import options

type
  EntityIndex* = Natural
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
  EntityFlag* = distinct cuint
  XuidUnion* = object
    xuidLow*: cint
    xuidHigh*: cint
  SteamIdUnion* = object {.union.}
    id*: clonglong
    xuid*: XuidUnion
  PlayerInfo*  = object
    unknown: clonglong        
    steamId: SteamIdUnion
    name*: array[128, char]  
    userId*: cint     
    szSteamID*: array[20, char]
    pad_0x00A8: array[0x00000010, char]
    iSteamID*: culong 
    szFriendsName*: array[128, char]
    fakeplayer*: bool
    ishltv*: bool
    customfiles*: array[4, cuint]
    filesdownloaded*: cuchar


vtableInterface EntityCollideable:
  idx 1:
    proc mins*(self: ptr EntityCollideable): ptr Vector3f0 {.thiscall.}
  idx 2:
    proc maxs*(self: ptr EntityCollideable): ptr Vector3f0 {.thiscall.}
vtableInterface EntityNetworkable:
  idx 2:
    proc getClientClass*(self: ptr EntityNetworkable): ptr ClientClass {.thiscall.}
  idx 10:
    proc index*(self: ptr EntityNetworkable): EntityIndex {.thiscall.}
vtableInterface EntityRenderable:
  idx 8:
    proc model*(self: ptr EntityRenderable): ptr EntityModel {.thiscall.}
  idx 9:
    proc drawModel*(self: ptr EntityRenderable, flags: int, alpha: byte): void {.thiscall.}
  idx 13:
    proc setupBones*(self: ptr EntityRenderable, outMatrix: ptr array[3, array[4, float32]], maxBones: uint, mask: uint, time: float32): bool {.thiscall.}
  idx 17:
    proc getRenderBounds*(self: ptr EntityRenderable, mins: var Vector3f0, maxs: var Vector3f0): void {.thiscall.}
  idx 32:
    proc renderableToWorldTransform*(self: ptr EntityRenderable): ptr array[3, array[4, float32]] {.thiscall.}

vtableInterface Entity:
  idx 3:
    proc collideable*(self: ptr Entity): ptr EntityCollideable {.thiscall.}
  idx 218:
    proc update*(self: ptr Entity) {.thiscall.}
  idx 165:
    proc isWeapon*(self: ptr Entity): bool {.thiscall.}

  proc renderable*(self: ptr Entity): ptr EntityRenderable = cast[ptr EntityRenderable](cast[uint](self) + sizeof(pointer) * 1)
  proc networkable*(self: ptr Entity): ptr EntityNetworkable = cast[ptr EntityNetworkable](cast[uint](self) + sizeof(pointer) * 2)

  netvar("DT_BasePlayer", "m_iHealth", Entity): health * -> cint
  netvar("DT_BaseCombatWeapon", "m_flNextPrimaryAttack", Entity): nextPrimaryAttack * -> float32
  netvar("DT_BaseCombatCharacter", "m_flNextAttack", Entity): nextAttack * -> float32
  netvar("DT_BasePlayer", "m_vecVelocity[0]", Entity): velocity * -> Vector3f0
  netvar("DT_BaseEntity", "m_vecOrigin", Entity): origin * -> Vector3f0
  netvar("DT_BasePlayer", "m_vecViewOffset[0]", Entity): viewOffset * -> Vector3f0
  netvar("DT_BasePlayer", "m_aimPunchAngle", Entity): aimpunchAngles * -> QAngle
  netvar("DT_BaseCombatWeapon", "m_iClip1", Entity): remClip1 * -> cint
  netvar("CustomTable", "Dormancy", Entity): dormant * -> bool
  netvar("DT_CSPlayer", "m_iShotsFired", Entity): shotsFired * -> cint
  netvar("DT_BaseEntity", "m_iTeamNum", Entity): team * -> EntityTeam
  netvar("DT_BasePlayer", "m_lifeState", Entity): lifeState * -> EntityLifeState
  netvar("DT_BasePlayer", "m_fFlags", Entity): flags * -> EntityFlag

  proc hitbox*(self: ptr Entity, idx: Hitboxes,
  offsetX: range[0.float32..1.float32] = 0.5,
  offsetY: range[0.float32..1.float32] = 0.5,
  offsetZ: range[0.float32..1.float32] = 0.5): Option[Vector3f0] = 
    type BoneMatrix = array[3, array[4, float32]]
    var boneMatrices: array[128, BoneMatrix]

    if self.renderable.setupBones(boneMatrices[0].addr, 128, BONE_USED_BY_HITBOX, 0'f32):
      let studioModel = !IModelInfo.instance.studioModel(self.renderable.model())
      let hitboxSet = !studioModel.hitboxSet(0)
      let hitbox = !hitboxSet.hitbox(idx)
      let mins = hitbox.mins
      let maxs = hitbox.maxs
      var boneMatrix = boneMatrices[hitbox.bone]

      proc transform(boneMatrix: var BoneMatrix, extents: Vector3f0): Vector3f0 = 
        let vecX = boneMatrix[0][0] !@ boneMatrix[0][1] !@ boneMatrix[0][2]
        let vecY = boneMatrix[1][0] !@ boneMatrix[1][1] !@ boneMatrix[1][2]
        let vecZ = boneMatrix[2][0] !@ boneMatrix[2][1] !@ boneMatrix[2][2]

        extents.dot(vecX) + boneMatrix[0][3] !@
        extents.dot(vecY) + boneMatrix[1][3] !@
        extents.dot(vecZ) + boneMatrix[2][3]
      block:
        let mins = transform(boneMatrix, mins)
        let maxs = transform(boneMatrix, maxs) 
        return some(
          mins + (maxs - mins) * (offsetX !@ offsetY !@ offsetZ)
        )
  proc hitboxbb*(self: ptr Entity, idx: Hitboxes): Option[tuple[min: Vector3f0, max: Vector3f0]] = 
    type BoneMatrix = array[3, array[4, float32]]
    var boneMatrices: array[128, BoneMatrix]

    if self.renderable.setupBones(boneMatrices[0].addr, 128, BONE_USED_BY_HITBOX, 0'f32):
      let studioModel = !IModelInfo.instance.studioModel(self.renderable.model())
      let hitboxSet = !studioModel.hitboxSet(0)
      let hitbox = !hitboxSet.hitbox(idx)
      let mins = hitbox.mins
      let maxs = hitbox.maxs
      var boneMatrix = boneMatrices[hitbox.bone]

      proc transform(boneMatrix: var BoneMatrix, extents: Vector3f0): Vector3f0 = 
        let vecX = boneMatrix[0][0] !@ boneMatrix[0][1] !@ boneMatrix[0][2]
        let vecY = boneMatrix[1][0] !@ boneMatrix[1][1] !@ boneMatrix[1][2]
        let vecZ = boneMatrix[2][0] !@ boneMatrix[2][1] !@ boneMatrix[2][2]

        extents.dot(vecX) + boneMatrix[0][3] !@
        extents.dot(vecY) + boneMatrix[1][3] !@
        extents.dot(vecZ) + boneMatrix[2][3]
      block:
        let mins = transform(boneMatrix, mins)
        let maxs = transform(boneMatrix, maxs)
        return some(
          (mins - (hitbox.radius !@ hitbox.radius !@ 0), maxs + (hitbox.radius !@ hitbox.radius !@ 0))
        )
  
  proc eye*(self: ptr Entity): Vector3f0 = self.origin + self.viewOffset


  type CfRetTy = array[3, array[4, float32]]
  proc coordFrame*(self: ptr Entity): CfRetTy = cast[ptr CfRetTy](cast[uint](self) + getOffset("DT_BaseEntity", "m_CollisionGroup") - 0x30)[]

  

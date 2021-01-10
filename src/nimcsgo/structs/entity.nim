import ../netvarinterface, ../vtableinterface, ./vector, ./studio, ./entitymodel, ../interfaces/imodelinfo, ./clientclass, ../helpers
import options, bitops

type
  EntityIndex* = Natural
  EntityHandle* = distinct uint
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
  WeaponId* = distinct cuint


const wiNone*: WeaponId = 0.WeaponId
const wiDEAGLE*: WeaponId = 1.WeaponId
const wiELITE*: WeaponId = 2.WeaponId
const wiFIVESEVEN*: WeaponId = 3.WeaponId
const wiGLOCK*: WeaponId = 4.WeaponId
const wiAK47*: WeaponId = 7.WeaponId
const wiAUG*: WeaponId = 8.WeaponId
const wiAWP*: WeaponId = 9.WeaponId
const wiFAMAS*: WeaponId = 10.WeaponId
const wiG3SG1*: WeaponId = 11.WeaponId
const wiGALILAR*: WeaponId = 13.WeaponId
const wiM249*: WeaponId = 14.WeaponId
const wiM4A1*: WeaponId = 16.WeaponId
const wiMAC10*: WeaponId = 17.WeaponId
const wiP90*: WeaponId = 19.WeaponId
const wiMP5SD*: WeaponId = 23.WeaponId
const wiUMP45*: WeaponId = 24.WeaponId
const wiXM1014*: WeaponId = 25.WeaponId
const wiBIZON*: WeaponId = 26.WeaponId
const wiMAG7*: WeaponId = 27.WeaponId
const wiNEGEV*: WeaponId = 28.WeaponId
const wiSAWEDOFF*: WeaponId = 29.WeaponId
const wiTEC9*: WeaponId = 30.WeaponId
const wiTASER*: WeaponId = 31.WeaponId
const wiHKP2000*: WeaponId = 32.WeaponId
const wiMP7*: WeaponId = 33.WeaponId
const wiMP9*: WeaponId = 34.WeaponId
const wiNOVA*: WeaponId = 35.WeaponId
const wiP250*: WeaponId = 36.WeaponId
const wiSHIELD*: WeaponId = 37.WeaponId
const wiSCAR20*: WeaponId = 38.WeaponId
const wiSG556*: WeaponId = 39.WeaponId
const wiSSG08*: WeaponId = 40.WeaponId
const wiKNIFEGG*: WeaponId = 41.WeaponId
const wiKNIFE*: WeaponId = 42.WeaponId
const wiFLASHBANG*: WeaponId = 43.WeaponId
const wiHEGRENADE*: WeaponId = 44.WeaponId
const wiSMOKEGRENADE*: WeaponId = 45.WeaponId
const wiMOLOTOV*: WeaponId = 46.WeaponId
const wiDECOY*: WeaponId = 47.WeaponId
const wiINCGRENADE*: WeaponId = 48.WeaponId
const wiC4*: WeaponId = 56.WeaponId
const wiHEALTHSHOT*: WeaponId = 57.WeaponId
const wiKNIFE_T*: WeaponId = 59.WeaponId
const wiM4A1_SILENCER*: WeaponId = 60.WeaponId
const wiUSP_SILENCER*: WeaponId = 61.WeaponId
const wiCZ75A*: WeaponId = 63.WeaponId
const wiREVOLVER*: WeaponId = 64.WeaponId
const wiTAGRENADE*: WeaponId = 68.WeaponId
const wiMelee*: WeaponId = 74.WeaponId

proc `$`*(weaponid: WeaponId): string =
  case weaponId:
  of wiNone: "None"
  of wiAK47: "Ak 47"
  of wiAUG: "Aug"
  of wiAWP: "Awp"
  of wiBIZON: "Bizon"
  of wiC4: "C4"
  of wiCZ75A: "CZ75A"
  of wiDEAGLE: "Deagle"
  of wiDECOY: "Decoy Grenade"
  of wiELITE: "Elite"
  of wiFAMAS: "Famas"
  of wiFIVESEVEN: "Five Seven"
  of wiFLASHBANG: "Flasbang Grenade"
  of wiG3SG1: "G3SG1"
  of wiGALILAR: "GALIL AR"
  of wiGLOCK: "Glock"
  of wiHEALTHSHOT: "Healthshot"
  of wiHEGRENADE: "HE Grenade"
  of wiHKP2000: "HKP 2000"
  of wiINCGRENADE: "Incendiary Grenade"
  of wiKNIFE: "Knife"
  of wiKNIFEGG: "Knife GG"
  of wiKNIFE_T: "Knife T"
  of wiM249: "M249"
  of wiM4A1: "M4A1"
  of wiM4A1_SILENCER: "M4A1 Silencer"
  of wiMAC10: "Mac 10"
  of wiMAG7: "Mag 7"
  of wiMOLOTOV: "Russki Grenade"
  of wiMP5SD: "MP5SD"
  of wiMP7: "Mp7"
  of wiMP9: "Mp9"
  of wiMelee: "Melee"
  of wiNEGEV: "Negev"
  of wiNOVA: "Nova"
  of wiP250: "P-250"
  of wiP90: "P90"
  of wiREVOLVER: "Revolver"
  of wiSAWEDOFF: "Sawed off"
  of wiSCAR20: "Scar 20"
  of wiSG556: "SG 556"
  of wiSHIELD: "Shield"
  of wiSMOKEGRENADE: "Smoke Grenade"
  of wiSSG08: "Scout"
  of wiTAGRENADE: "TA Grenade"
  of wiTASER: "Zeus"
  of wiTEC9: "Tec9"
  of wiUMP45: "Ump 45"
  of wiUSP_SILENCER: "Usp Silencer"
  of wiXM1014: "wiXM1014"
  else: "Unknown Weapon"


const POSSIBLE_ITEMS = [
  wiNone, wiAK47, wiAUG, wiAWP, wiBIZON, wiC4, wiCZ75A, wiDEAGLE, wiDECOY, wiELITE, wiFAMAS, wiFIVESEVEN, wiFLASHBANG, wiG3SG1, wiGALILAR, wiGLOCK,
  wiHEALTHSHOT, wiHEGRENADE, wiINCGRENADE, wiKNIFE, wiKNIFEGG, wiKNIFE_T, wiM249, wiM249, wiHKP2000, wiMP7, wiMP9, wiNEGEV, wiNOVA, wiP90, wiREVOLVER, 
  wiSAWEDOFF, wiSCAR20, wiSG556, wiSHIELD, wiSMOKEGRENADE, wiSSG08, wiTAGRENADE, wiMAG7, wiMAC10, wiMOLOTOV, wiMP5SD, wiUMP45, wiXM1014, wiUSP_SILENCER,
  wiM4A1, wiM4A1_SILENCER, wiP250, wiMelee
]

iterator items*(_: typedesc[WeaponId]): WeaponId =

  for item in POSSIBLE_ITEMS:
    yield item

proc low*(_: typedesc[WeaponId]): int = wiNone.int
proc high*(_: typedesc[WeaponId]): int = wiMelee.int

proc `==`*(a, b: WeaponId): bool {.borrow.}

converter entityIndexFromEntityHandle*(handle: EntityHandle): EntityIndex = (bitand(handle.uint, 0xFFF)).EntityIndex


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
  netvar("DT_BaseCombatCharacter", "m_hActiveWeapon", Entity): hActiveWeapon * -> EntityHandle

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
  proc weaponId*(self: ptr Entity): WeaponId = cast[ptr WeaponId](
    cast[uint](self) + 
    getOffset("DT_BaseAttributableItem", "m_AttributeManager") + 
    getOffset("DT_BaseAttributableItem", "m_iItemDefinitionIndex"
  ))[]

  

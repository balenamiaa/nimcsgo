import options
import ./vector 


type
  HitGroup* = enum
    hgGeneric,
    hgHead,
    hgChest,
    hgStomach,
    hgLeftArm,
    hgRightArm,
    hgLeftLeg,
    hgRightLeg,
    hgGear = 10,
  ModType* = enum
    mtBad0
    mtBrush
    mtSprite
    mtStudio
  Hitboxes* = enum
    hsHead = "Head"
    hsNeck = "Neck"
    hsPelvis = "Pelvis"
    hsStomach = "Stomach"
    hsLowerChest = "Lower Chest"
    hsChest = "Chest"
    hsUpperChest = "Upper Chest"
    hsRightThigh = "Right Thigh"
    hsLeftThigh = "Left Thigh"
    hsRightCalf = "Right Calf"
    hsLeftCalf = "Left Calf"
    hsRightFoot = "Right Foot"
    hsLeftFoot = "Left Foot"
    hsRightHand = "Right Hand"
    hsLeftHand = "Left Hand"
    hsRightUpperArm = "Right Upper Arm"
    hsRightForearm = "Right Forearm"
    hsLeftUpperArm = "Left Upper Arm"
    hsLeftForearm = "Left Forearm"
    hsMax = "ALL"
  StudioBone* = object
    name_index*: cuint
    parent*: cint
    bone_controller*: array[6, cint]
    pos*: Vector3f0
    quat*: array[4, cfloat]
    rotation*: Vector3f0
    pos_scale*: Vector3f0
    rot_scale*: Vector3f0
    pose_to_bone*: array[3, array[4, cfloat]]
    quat_alignment*: array[4, cfloat]
    flags*: cuint
    proc_type*: cuint
    proc_index*: cuint
    physics_bone*: cuint
    surface_prop_idx*: cuint
    contents*: cint
    surf_prop_lookup*: cint
    junk: array[28, byte]
  StudioBox* = object
    bone*: cuint
    group*: cuint
    mins*: Vector3f0
    maxs*: Vector3f0
    nameIdx*: cuint
    padding: array[12, byte]
    radius*: cfloat
    junk: array[16, byte]
  StudioBoxSet* = object
    nameIdx*: cuint
    hitboxCount*: cuint
    hitboxIdx*: cuint
  StudioHdr* = object
    id: cuint
    version: cint
    checksum: cuint
    name: array[64, byte]
    length: cuint
    eye_pos: Vector3f0
    illium_pos: Vector3f0
    hull_mins: Vector3f0
    hull_maxs: Vector3f0
    mins: Vector3f0
    maxs: Vector3f0
    flags: cuint
    bones_count: cuint
    bone_idx: cuint
    bone_controllers_count: cuint
    bone_controllers_idx: cuint
    hitbox_sets_count: cuint
    hitbox_sets_idx: cuint
    local_anim_count: cuint
    local_anim_idx: cuint
    local_seq_count: cuint
    local_seq_idx: cuint
    activity_list_version: cuint
    events_indexed: cuint
    texture_count: cuint
    texture_index: cuint

const BONE_CALCULATE_MASK*        = 0x1f'u32
const BONE_PHYSICALLY_SIMULATED*  = 0x01'u32
const BONE_PHYSICS_PROCEDURAL*    = 0x02'u32
const BONE_ALWAYS_PROCEDURAL*     = 0x04'u32
const BONE_SCREEN_ALIGN_SPHERE*   = 0x08'u32
const BONE_SCREEN_ALIGN_CYLINDER* = 0x10'u32
const BONE_USED_MASK*             = 0x0007ff00'u32
const BONE_USED_BY_ANYTHING*      = 0x0007ff00'u32
const BONE_USED_BY_HITBOX*        = 0x00000100'u32
const BONE_USED_BY_ATTACHMENT*    = 0x00000200'u32
const BONE_USED_BY_VERTEX_mask*   = 0x0003fc00'u32
const BONE_USED_BY_VERTEX_LOD0*   = 0x00000400'u32
const BONE_USED_BY_VERTEX_LOD1*   = 0x00000800'u32
const BONE_USED_BY_VERTEX_LOD2*   = 0x00001000'u32
const BONE_USED_BY_VERTEX_LOD3*   = 0x00002000'u32
const BONE_USED_BY_VERTEX_LOD4*   = 0x00004000'u32
const BONE_USED_BY_VERTEX_LOD5*   = 0x00008000'u32
const BONE_USED_BY_VERTEX_LOD6*   = 0x00010000'u32
const BONE_USED_BY_VERTEX_LOD7*   = 0x00020000'u32
const BONE_USED_BY_BONE_MERGE*    = 0x00040000'u32
const BONE_TYPE_MASK*             = 0x00f00000'u32
const BONE_FIXED_ALIGNMENT*       = 0x00100000'u32
const BONE_HAS_SAVEFRAME_POS*     = 0x00200000'u32
const BONE_HAS_SAVEFRAME_ROT*     = 0x00400000'u32

proc name*(self: ptr StudioBoxSet): Option[string] = option($cast[cstring](cast[uint](self) + self.nameIdx))
proc hitbox*(self: ptr StudioBoxSet, idx: Hitboxes): Option[ptr StudioBox] =
  if idx.ord.uint > self.hitboxCount: return none[ptr StudioBox]()
  cast[ptr StudioBox](cast[uint](self) + self.hitboxIdx + idx.ord.uint * sizeof(StudioBox).uint).option

proc bone*(self: ptr StudioHdr, idx: uint): Option[ptr StudioBone] = cast[ptr StudioBone](cast[uint](self) + self.boneIdx + idx * sizeof(StudioHdr).uint).option
proc hitboxSet*(self: ptr StudioHdr, idx: uint): Option[ptr StudioBoxSet] = 
  if idx > self.hitbox_sets_count: return none[ptr StudioBoxSet]()

  cast[ptr StudioBoxSet](cast[uint](self) + self.hitbox_sets_idx + idx * sizeof(StudioBoxSet).uint).option
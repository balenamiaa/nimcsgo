import ./entity, ./vector, ../vtableinterface
import bitops, macros
type
  TraceMask* = distinct uint
  VectorAligned = object
    xyz{.align: 16.}: Vector3f0
    w: cfloat
  Ray* = object
    start*: VectorAligned
    delta*: VectorAligned
    startOffset*: VectorAligned
    extents*: VectorAligned
    pWorldAxisTransformMatrix: pointer
    isRay*: bool
    isSwept*: bool
  CSurface* = object
    name*: cstring
    surfaceProps*: cshort
    flags*: cushort
  CPlane* = object
    normal*: Vector3f0
    dist*: cfloat
    `type`*: byte
    signBit*: byte
    padding: array[2, byte]
  Trace* = object
    start*: Vector3f0
    `end`*: Vector3f0
    plane*: CPlane
    fraction*: cfloat
    contents*: cint
    displayFlags*: cshort
    allSolid*: bool
    startSolid*: bool
    fractionSolifLeft*: cfloat
    surface*: CSurface
    hitGroups*: cint
    physicsBone*: cshort
    pEntity*: ptr Entity
    hitbox*: cint
  TraceType* = enum
    ttEverything
    ttWorldOnly
    ttEntitiesOnly
    ttEverythingFilterProps
  TraceFilterConcept* {.explain.} = concept p
    p.shouldHitEntity(ptr Entity, uint) is bool
    p.getTraceType() is TraceType


vtable:
  type TraceFilterGeneric* = object
    pSkipEntity*: ptr Entity

  methods:
    proc shouldHitEntity*(pEntity: ptr Entity, contentsMask: uint): bool = pEntity != self.pSkipEntity
    proc getTraceType*(): TraceType = ttEverything



converter fromVectorAligned(xyz: Vector3f0): VectorAligned = VectorAligned(
    xyz: xyz, w: 0'f32)
converter ToVector3f0(vec: VectorAligned): Vector3f0 = vec.xyz
converter ToUInt(x: TraceMask): uint = x.uint

const
  tmEMPTY*: TraceMask = cast[TraceMask](0b00000000000000000000000000000000)
  tmSOLID*: TraceMask = cast[TraceMask](0b00000000000000000000000000000001)
  tmWINDOW*: TraceMask = cast[TraceMask](0b00000000000000000000000000000010)
  tmAUX*: TraceMask = cast[TraceMask](0b00000000000000000000000000000100)
  tmGRATE*: TraceMask = cast[TraceMask](0b00000000000000000000000000001000)
  tmSLIME*: TraceMask = cast[TraceMask](0b00000000000000000000000000010000)
  tmWATER*: TraceMask = cast[TraceMask](0b00000000000000000000000000100000)
  tmMIST*: TraceMask = cast[TraceMask](0b00000000000000000000000001000000)
  tmOPAQUE*: TraceMask = cast[TraceMask](0b00000000000000000000000010000000)
  tmLAST_VISIBLE_CONTENTS*: TraceMask = cast[TraceMask](0b00000000000000000000000010000000)
  tmALL_VISIBLE_CONTENTS*: TraceMask = cast[TraceMask](bitor(
      tmLAST_VISIBLE_CONTENTS, tmLAST_VISIBLE_CONTENTS - 1.TraceMask))
  tmTESTFOGVOLUME*: TraceMask = cast[TraceMask](0b00000000000000000000000100000000)
  tmUNUSED5*: TraceMask = cast[TraceMask](0b00000000000000000000001000000000)
  tmUNUSED6*: TraceMask = cast[TraceMask](0b00000000000000000000010000000000)
  tmTEAM1*: TraceMask = cast[TraceMask](0b00000000000000000000100000000000)
  tmTEAM2*: TraceMask = cast[TraceMask](0b00000000000000000001000000000000)
  tmIGNORE_NODRAW_OPAQUE*: TraceMask = cast[TraceMask](0b00000000000000000010000000000000)
  tmMOVEABLE*: TraceMask = cast[TraceMask](0b00000000000000000100000000000000)
  tmAREAPORTAL*: TraceMask = cast[TraceMask](0b00000000000000001000000000000000)
  tmPLAYERCLIP*: TraceMask = cast[TraceMask](0b00000000000000010000000000000000)
  tmMONSTERCLIP*: TraceMask = cast[TraceMask](0b00000000000000100000000000000000)
  tmCURRENT_0*: TraceMask = cast[TraceMask](0b00000000000001000000000000000000)
  tmCURRENT_90*: TraceMask = cast[TraceMask](0b00000000000010000000000000000000)
  tmCURRENT_180*: TraceMask = cast[TraceMask](0b00000000000100000000000000000000)
  tmCURRENT_270*: TraceMask = cast[TraceMask](0b00000000001000000000000000000000)
  tmCURRENT_UP*: TraceMask = cast[TraceMask](0b00000000010000000000000000000000)
  tmCURRENT_DOWN*: TraceMask = cast[TraceMask](0b00000000100000000000000000000000)
  tmORIGIN*: TraceMask = cast[TraceMask](0b00000001000000000000000000000000)
  tmMONSTER*: TraceMask = cast[TraceMask](0b00000010000000000000000000000000)
  tmDEBRIS*: TraceMask = cast[TraceMask](0b00000100000000000000000000000000)
  tmDETAIL*: TraceMask = cast[TraceMask](0b00001000000000000000000000000000)
  tmTRANSLUCENT*: TraceMask = cast[TraceMask](0b00010000000000000000000000000000)
  tmLADDER*: TraceMask = cast[TraceMask](0b00100000000000000000000000000000)
  tmHITBOX*: TraceMask = cast[TraceMask](0b01000000000000000000000000000000)
  tmMASK_ALL*: TraceMask = cast[TraceMask](0b0000000000000000000000000000000011111111111111111111111111111111'i64)
  tmMASK_SOLID* = cast[TraceMask](bitor(tmSOLID, tmMOVEABLE, tmWINDOW,
                                        tmMONSTER, tmGRATE))
  tmMASK_PLAYER_SOLID* = cast[TraceMask](bitor(tmPLAYERCLIP, tmMASK_SOLID))
  tmMASK_NPC_SOLID* = cast[TraceMask](bitor(tmMONSTERCLIP, tmMASK_SOLID))
  tmMASK_WATER* = cast[TraceMask](bitor(tmWATER, tmMOVEABLE, tmSLIME))
  tmMASK_SHOT* = cast[TraceMask](bitor(tmSOLID, tmMOVEABLE, tmWINDOW, tmMONSTER,
                                       tmDEBRIS, tmHITBOX))
  tmPlayerVisible* = bitor(tmMASK_PLAYER_SOLID, tmMASK_SHOT).TraceMask

proc initRay*(start, `end`: Vector3f0): Ray =
  result.delta = `end` - start
  result.start = start
  result.isSwept = result.delta.Vector3f0.lenSqr() != 0e0
  result.isRay = true



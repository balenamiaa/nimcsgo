import ../vtableinterface, ../structs/vector, ../structs/entity, ../structs/cusercmd



type PlayerMoveData* = object
  firstRunOfFunctions: bool
  gameCodeMovedPlayer: bool
  playerHandle, impulseCommand: cint
  viewAngles, absViewAngles: QAngle
  buttons, prevButtons: cint
  forwardMove, sideMove, upMove, maxSpeed, clientMaxSpeed: cfloat
  velocity: Vector3f0
  angles, prevAngles: QAngle
  outStepHeight: cfloat
  wishVelocity, jumpVelocity, constraintCenter: Vector3f0
  constraitRadius, constraintWidth, constraintSpeedFactor: cfloat
  m_pad_0: array[5, cfloat]
  absOrigin: Vector3f0

vtable:
  type IMoveHelper* = object
    playerMoveData*: PlayerMoveData
  
  methods:
    @1
    proc setHost*(host: ptr Entity)


vtable:
  type IGameMovement* = object
  
  methods:
    @1
    proc process_movement*(pEnt: ptr Entity, pPlayerMoveData: ptr PlayerMoveData)
    proc reset*()
    proc beginTrackPredictionErrors*(pEnt: ptr Entity)
    proc finishTrackPredictionErrors*(pEnt: ptr Entity)



vtable:
  type IPlayerPrediction* = object
  
  methods:  
    @14
    proc inPrediction*(): bool
    @19
    proc runCommand*(pEnt: ptr Entity, cmd: ptr CUserCmd, iMoveHelper: ptr IMoveHelper)
    proc beginMove*(pEnt: ptr Entity, cmd: ptr CUserCmd, iMoveHelper: ptr IMoveHelper, data: pointer)
    proc finishMove*(pEnt: ptr Entity, cmd: ptr CUserCmd, data: pointer)


genInstantiation IMoveHelper
genInstantiation IPlayerPrediction
genInstantiation IGameMovement
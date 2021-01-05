import ./recvprop


type
  ClientClassId* {.size: sizeof(cuint).} = enum
    cciAK47 = 1
    cciBaseAnimating = 2
    cciBaseAnimatingOverlay = 3
    cciBaseAttributableItem = 4
    cciBaseButton = 5
    cciBaseCombatCharacter = 6
    cciBaseCombatWeapon = 7
    cciBaseCSGrenade = 8
    cciBaseCSGrenadeProjectile = 9
    cciBaseDoor = 10
    cciBaseEntity = 11
    cciBaseFlex = 12
    cciBaseGrenade = 13
    cciBaseParticleEntity = 14
    cciBasePlayer = 15
    cciBasePropDoor = 16
    cciBaseTeamObjectiveResource = 17
    cciBaseTempEntity = 18
    cciBaseToggle = 19
    cciBaseTrigger = 20
    cciBaseViewModel = 21
    cciBaseVPhysicsTrigger = 22
    cciBaseWeaponWorldModel = 23
    cciBeam = 24
    cciBeamSpotlight = 25
    cciBoneFollower = 26
    cciBreakableProp = 27
    cciBreakableSurface = 28
    cciC4 = 29
    cciCascadeLight = 30
    cciChicken = 31
    cciColorCorrection = 32
    cciColorCorrectionVolume = 33
    cciCSGameRulesProxy = 34
    cciCSPlayer = 35
    cciCSPlayerResource = 36
    cciCSRagdoll = 37
    cciCSTeam = 38
    cciDEagle = 39
    cciDecoyGrenade = 40
    cciDecoyProjectile = 41
    cciDynamicLight = 42
    cciDynamicProp = 43
    cciEconEntity = 44
    cciEconWearable = 45
    cciEmbers = 46
    cciEntityDissolve = 47
    cciEntityFlame = 48
    cciEntityFreezing = 49
    cciEntityParticleTrail = 50
    cciEnvAmbientLight = 51
    cciEnvDetailController = 52
    cciEnvDOFController = 53
    cciEnvParticleScript = 54
    cciEnvProjectedTexture = 55
    cciEnvQuadraticBeam = 56
    cciEnvScreenEffect = 57
    cciEnvScreenOverlay = 58
    cciEnvToneMapController = 59
    cciEnvWind = 60
    cciFEPlayerDecal = 61
    cciFireCrackerBlast = 62
    cciFireSmoke = 63
    cciFireTrail = 64
    cciFish = 65
    cciFlashBang = 66
    cciFogController = 67
    cciFootstepControl = 68
    cciFuncDust = 69
    cciFuncLOD = 70
    cciFuncAreaPortalWindow = 71
    cciFuncBrush = 72
    cciFuncConveyor = 73
    cciFuncLadder = 74
    cciFuncMonitor = 75
    cciFuncMoveLinear = 76
    cciFuncOccluder = 77
    cciFuncReflectiveGlass = 78
    cciFuncRotating = 79
    cciFuncSmokeVolume = 80
    cciFuncTrackTrain = 81
    cciGameRulesProxy = 82
    cciHandleTest = 83
    cciHEGrenade = 84
    cciHostage = 85
    cciHostageCarriableProp = 86
    cciIncendiaryGrenade = 87
    cciInferno = 88
    cciInfoLadderDismount = 89
    cciInfoOverlayAccessor = 90
    cciItemHealthShot = 91
    cciItemDogTags = 92
    cciKnife = 93
    cciKnifeGG = 94
    cciLightGlow = 95
    cciMaterialModifyControl = 96
    cciMolotovGrenade = 97
    cciMolotovProjectile = 98
    cciMovieDisplay = 99
    cciParticleFire = 100
    cciParticlePerformanceMonitor = 101
    cciParticleSystem = 102
    cciPhysBox = 103
    cciPhysBoxMultiPlayer = 104
    cciPhysicsProp = 105
    cciPhysicsPropMultiPlayer = 106
    cciPhysMagnet = 107
    cciPlantedC4 = 108
    cciPlasma = 109
    cciPlayerResource = 110
    cciPointCamera = 111
    cciPointCommentaryNode = 112
    cciPointWorldText = 113
    cciPoseController = 114
    cciPostProcessController = 115
    cciPrecipitation = 116
    cciPrecipitationBlocker = 117
    cciPredictedViewModel = 118
    cciPropHallucination = 119
    cciPropDoorRotating = 120
    cciPropJeep = 121
    cciPropVehicleDriveable = 122
    cciRagDollManager = 123
    cciRagDollProp = 124
    cciRagDollPropAttached = 125
    cciRopeKeyframe = 126
    cciSCAR17 = 127
    cciSceneEntity = 128
    cciSensorGrenade = 129
    cciSensorGrenadeProjectile = 130
    cciShadowControl = 131
    cciSlideShowDisplay = 132
    cciSmokeGrenade = 133
    cciSmokeGrenadeProjectile = 134
    cciSmokeStack = 135
    cciSpatialEntity = 136
    cciSpotlightEnd = 137
    cciSprite = 138
    cciSpriteOriented = 139
    cciSpriteTrail = 140
    cciStatueProp = 141
    cciSteamJet = 142
    cciSun = 143
    cciSunlightShadowControl = 144
    cciTeam = 145
    cciTeamPlayRoundBasedRulesProxy = 146
    cciTEArmorRicochet = 147
    cciTEBaseBeam = 148
    cciTEBeamEntPoint = 149
    cciTEBeamEntities = 150
    cciTEBeamFollow = 151
    cciTEBeamLaser = 152
    cciTEBeamPoints = 153
    cciTEBeamRing = 154
    cciTEBeamRingPoint = 155
    cciTEBeamSpline = 156
    cciTEBloodSprite = 157
    cciTEBloodStream = 158
    cciTEBreakModel = 159
    cciTEBSPDecal = 160
    cciTEBubbles = 161
    cciTEBubbleTrail = 162
    cciTEClientProjectile = 163
    cciTEDecal = 164
    cciTEDust = 165
    cciTEDynamicLight = 166
    cciTEEffectDispatch = 167
    cciTEEnergySplash = 168
    cciTEExplosion = 169
    cciTEFireBullets = 170
    cciTEFizz = 171
    cciTEFootprintDecal = 172
    cciTEFoundryHelpers = 173
    cciTEGaussExplosion = 174
    cciTEGlowSprite = 175
    cciTEImpact = 176
    cciTEKillPlayerAttachments = 177
    cciTELargeFunnel = 178
    cciTEMetalSparks = 179
    cciTEMuzzleFlash = 180
    cciTEParticleSystem = 181
    cciTEPhysicsProp = 182
    cciTEPlantBomb = 183
    cciTEPlayerAnimEvent = 184
    cciTEPlayerDecal = 185
    cciTEProjectedDecal = 186
    cciTERadioIcon = 187
    cciTEShatterSurface = 188
    cciTEShowLine = 189
    cciTesla = 190
    cciTESmoke = 191
    cciTESparks = 192
    cciTESprite = 193
    cciTESpriteSpray = 194
    cciTestTraceLine = 196
    cciTEWorldDecal = 197
    cciTriggerPlayerMovement = 198
    cciTriggerSoundOperator = 199
    cciVGuiScreen = 200
    cciVoteController = 201
    cciWaterBullet = 202
    cciWaterLODControl = 203
    cciWeaponAug = 204
    cciWeaponAWP = 205
    cciWeaponBaseItem = 206
    cciWeaponBizon = 207
    cciWeaponCSBase = 208
    cciWeaponCSBaseGun = 209
    cciWeaponCycler = 210
    cciWeaponElite = 211
    cciWeaponFamas = 212
    cciWeaponFiveSeven = 213
    cciWeaponG3SG1 = 214
    cciWeaponGalil = 215
    cciWeaponGalilAR = 216
    cciWeaponGlock = 217
    cciWeaponHKP2000 = 218
    cciWeaponM249 = 219
    cciWeaponM3 = 220
    cciWeaponM4A1 = 221
    cciWeaponMAC10 = 222
    cciWeaponMag7 = 223
    cciWeaponMP5Navy = 224
    cciWeaponMP7 = 225
    cciWeaponMP9 = 226
    cciWeaponNegev = 227
    cciWeaponNOVA = 228
    cciWeaponP228 = 229
    cciWeaponP250 = 230
    cciWeaponP90 = 231
    cciWeaponSawedOff = 232
    cciWeaponSCAR20 = 233
    cciWeaponScout = 234
    cciWeaponSG550 = 235
    cciWeaponSG552 = 236
    cciWeaponSG556 = 237
    cciWeaponSSG08 = 238
    cciWeaponTaser = 239
    cciWeaponTec9 = 240
    cciWeaponTMP = 241
    cciWeaponUMP45 = 242
    cciWeaponUSP = 243
    cciWeaponXM1014 = 244
    cciWorld = 245
    cciDustTrail = 246
    cciMovieExplosion = 247
    cciParticleSmokeGrenade = 248
    cciRocketTrail = 249
    cciSmokeTrail = 250
    cciSporeExplosion = 251
    cciSporeTrail = 252
  CreateClientClassProcType = proc(entity, serial: cint): void {.cdecl.}
  CreateEventProcType = proc(): void {.cdecl.}
  ClientClass* = object
    procCreateClientClass*: CreateClientClassProcType
    procCreateEvent*: CreateEventProcType
    networkName*: cstring
    recvTable*: ptr RecvTable
    next*: ptr ClientClass
    classId*: ClientClassId


iterator children*(current: ptr ClientClass): lent ClientClass =
  var next: ptr ClientClass = current.next

  while next != nil:
    yield next[]
    next = next[].next


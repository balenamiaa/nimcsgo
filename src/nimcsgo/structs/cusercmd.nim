import ./vector

type 
  CmdButtons* = enum
    cbIN_ATTACK     
    cbIN_JUMP       
    cbIN_DUCK       
    cbIN_FORWARD    
    cbIN_BACK       
    cbIN_USE        
    cbIN_CANCEL     
    cbIN_LEFT       
    cbIN_RIGHT      
    cbIN_MOVE_LEFT  
    cbIN_MOVE_RIGHT 
    cbIN_ATTACK_2   
    cbIN_RUN        
    cbIN_RELOAD     
    cbIN_ALT_1      
    cbIN_ALT_2      
    cbIN_SCORE      
    cbIN_SPEED      
    cbIN_WALK       
    cbIN_ZOOM       
    cbIN_WEAPON_1   
    cbIN_WEAPON_2   
    cbIN_BULL_RUSH  
    cbIN_GRENADE_1  
    cbIN_GRENADE_2
  CmdButton* = cuint
  CUserCmd* = object
    padding: array[4, byte]
    commandNumber*: cint
    tickCount*: cint
    viewAngles*: QAngle
    aimDirection*: Vector3f0
    forwardMove*: cfloat
    sideMove*: cfloat
    upMove*: cfloat
    buttons*: CmdButton
    impulse*: uint8
    weaponSelect*: cint
    weaponSubtype*: cint
    randomSeed*: cint
    mouseDx*: cshort
    mouseDy*: cshort
    predicted*: bool
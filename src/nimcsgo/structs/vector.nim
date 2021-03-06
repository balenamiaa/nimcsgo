import math

type
  Number = int | float | uint
  ToFloat32 = concept x
    x.float32()
  FromFloat32 = concept x
    type Tx = x.type()
    x.Tx()
  Vector3f0* = object
    x*: float32
    y*: float32
    z*: float32
  QAngle* {.borrow: `.`.} = distinct Vector3f0

template implOpVec(operation: untyped, inPlaceOperation: untyped) = 
  proc operation*(a, b: Vector3f0): Vector3f0 = Vector3f0(x: operation(a.x, b.x), y: operation(a.y, b.y), z: operation(a.z, b.z))
  proc operation*(a: Vector3f0, scalar: ToFloat32): Vector3f0 = Vector3f0(x: operation(a.x, scalar.float32()), y: operation(a.y, scalar.float32()), z: operation(a.z, scalar.float32()))

  proc inPlaceOperation*(self: var Vector3f0, other: Vector3f0) = 
    self.x = operation(self.x, other.x)
    self.y = operation(self.y, other.y)
    self.z = operation(self.z, other.z)
  proc inPlaceOperation*(self: var Vector3f0, scalar: ToFloat32) = 
    self.x = operation(self.x, scalar.float32())
    self.y = operation(self.y, scalar.float32())
    self.z = operation(self.z, scalar.float32())


template implOpAng(operation: untyped, inPlaceOperation: untyped) = 
  proc operation*(a, b: QAngle): QAngle = Vector3f0(x: operation(a.x, b.x), y: operation(a.y, b.y), z: 0.float32).QAngle
  proc operation*(a: QAngle, scalar: ToFloat32): QAngle = Vector3f0(x: operation(a.x, scalar.float32()), y: operation(a.y, scalar.float32()), z: 0.float32()).QAngle

  proc inPlaceOperation*(self: var QAngle, other: QAngle) = 
    self.x = operation(self.x, other.x)
    self.y = operation(self.y, other.y)
    self.z = 0
  proc inPlaceOperation*(self: var QAngle, scalar: ToFloat32) = 
    self.x = operation(self.x, scalar.float32())
    self.y = operation(self.y, scalar.float32())
    self.z = 0
 

implOpVec(`+`, `+=`)
implOpVec(`-`, `-=`)
implOpVec(`*`, `*=`)
implOpVec(`/`, `/=`)
implOpAng(`+`, `+=`)
implOpAng(`-`, `-=`)
implOpAng(`*`, `*=`)
implOpAng(`/`, `/=`)


proc `==`*(a,b: QAngle): bool {.borrow.}




converter fromArray*(arr: array[1, float32]): Vector3f0 = Vector3f0(x: arr[0], y: 0, z: 0)
converter fromArray*(arr: array[2, float32]): Vector3f0 = Vector3f0(x: arr[0], y: arr[1], z: 0)
converter fromArray*(arr: array[3, float32]): Vector3f0 = Vector3f0(x: arr[0], y: arr[1], z: arr[2])
converter fromArray*[N: static[uint]](arr: array[N, float32]): Vector3f0 = Vector3f0(x: arr[0], y: arr[1], z: arr[2])

proc initVector3f0*(x, y, z: ToFloat32): Vector3f0 = Vector3f0(x: x.float32(), y: y.float32(), z: z.float32())

proc yaw*(self: QAngle): float32 = self.y
proc pitch*(self: QAngle): float32 = self.x
proc yaw*(self: var QAngle): var float32 = self.y
proc pitch*(self: var QAngle): var float32 = self.x

proc map*[T: FromFloat32, S: ToFloat32](self: Vector3f0, operation: proc(val: T): S): Vector3f0 = 
  Vector3f0(x: operation(T(self.x)).float32, y: operation(T(self.y)).float32, z: operation(T(self.z)).float32)
proc apply*[T: FromFloat32, S: ToFloat32](self: var Vector3f0, operation: proc(val: T): S) = 
  self.x = operation(T(self.x)).float32
  self.y = operation(T(self.y)).float32
  self.z = operation(T(self.z)).float32

proc map*[T: FromFloat32, S: ToFloat32](self: QAngle, operation: proc(val: T): S): QAngle = self.Vector3f0.map(operation).QAngle

proc sum*(self: Vector3f0): float = self.x + self.y + self.z
proc dot*(a: Vector3f0, b: Vector3f0): float = sum(a * b)
proc lenSqr*(self: Vector3f0): float = self.map(proc(x: float32): float32 = x * x).sum
proc len*(self: Vector3f0): float = self.lenSqr.sqrt()
proc unit*(self: Vector3f0): Vector3f0 = self.map(proc(x: float32): float32 = x / self.len)

proc sum*(self: QAngle): float = self.x + self.y
proc lenSqr*(self: QAngle): float = self.map(proc(x: float32): float32 = x * x).sum
proc len*(self: QAngle): float = self.lenSqr.sqrt()
proc unit*(self: QAngle): QAngle = self.map(proc(x: float32): float32 = x / self.len)


proc nullifiedX*(self: Vector3f0): Vector3f0 = Vector3f0(x: 0.float32, y: self.y, z: self.z)
proc nullifiedY*(self: Vector3f0): Vector3f0 = Vector3f0(x: self.x, y: 0.float32, z: self.z)
proc nullifiedZ*(self: Vector3f0): Vector3f0 = Vector3f0(x: self.x, y: self.y, z: 0.float32)

proc nullifiedYaw*(self: QAngle): QAngle = QAngle(initVector3f0(self.x, 0, 0))

proc inRadians*(self: QAngle): QAngle = self.map(proc(x: float32): float32 = x * (PI / 180e0).float32)
proc inDegrees*(self: QAngle): QAngle = self.map(proc(x: float32): float32 = x * (180e0 / PI).float32)

proc clamp*(self: var QAngle) = 
  self.x = self.x.clamp(-89.0, 89.0)
  self.y = self.y.clamp(-179.99, 179.99) #normalize handles yes this, but what if it's NaN?
  self.z = 0

proc normalize*(self: var QAngle) =

  if self.x > 90.float32: 
    self.x = -90.float32 + (self.x mod 90.float32)
  elif self.x < -90.float32:
    self.x = 90.float32 + (self.x mod 90.float32)

  if self.y > 180.float32: 
    self.y = -180.float32 + (self.y mod 180.float32)
  elif self.y < -180.float32:
    self.y = 180.float32 + (self.y mod 180.float32)

  if self.x == -90:
    self.x = 89.89

  if self.y == -180:
    self.y = 179.89
  
  self.z = 0

proc normalized*(self: QAngle): QAngle =
  result = self
  

  if self.x >= 90.float32: 
    result.x = -90.float32 + (self.x mod 90.float32)
  elif self.x < -90.float32:
    result.x = 90.float32 + (self.x mod 90.float32)

  if self.y >= 180.float32: 
    result.y = -180.float32 + (self.y mod 180.float32)
  elif self.y < -180.float32:
    result.y = 180.float32 + (self.y mod 180.float32)
  
  if result.x == -90:
    result.x = 89.89

  if result.y == -180:
    result.y = 179.89
  result.z = 0

proc `$`*(self: Vector3f0): string =
  "X: " & $self.x & '\n' &
  "Y: " & $self.y & '\n' &
  "Z: " & $self.z & '\n'

proc `$`*(self: QAngle): string =
  "Pitch: " & $self.x & "degrees \n" &
  "Yaw: " & $self.y & "degrees \n"

proc `!@`*[Tx: ToFloat32, Ty: ToFloat32](x: Tx, y: Ty): Vector3f0 = Vector3f0(x: x.float32, y: y.float32, z: 0.float32)
proc `!@`*[T: ToFloat32](intermediateVec: sink Vector3f0, z: T): Vector3f0 = 
  var moved = intermediateVec
  moved.z = z.float32
  moved

proc initQAngle*(yaw, pitch, roll: ToFloat32): QAngle = QAngle(pitch.float32 !@ yaw.float32 !@ 0'f32) 
proc initQAngle*(yaw, pitch: ToFloat32): QAngle = QAngle(pitch.float32 !@ yaw.float32 !@ 0'f32) 

proc lookAt*(src: Vector3f0, dest: Vector3f0): QAngle = 
  let delta = dest - src

  normalized inDegrees QAngle -delta.z.arctan2(delta.nullifiedZ.len) !@ (
    var yaw = delta.y.arctan2(delta.x)
    if yaw < 0.float32: yaw + 2.float32 * PI else: yaw 
  )

proc getFov*(curViewAng: QAngle, targetViewAng: QAngle, dist: float): float64 = 
  let delta = inRadians normalized targetViewAng - curViewAng

  len delta.x.abs.sin * dist !@ delta.y.abs.sin * dist 


proc velCompensated*(src: Vector3f0, relVec: Vector3f0, dist: float): Vector3f0 = src + relVec / dist
proc lerp*(targetViewAng: QAngle, curViewAng: QAngle, dist, t: float64): QAngle = 
  #let fov = curViewAng.getFov(targetViewAng, dist)

  let diff = normalized: targetViewAng - curViewAng

  if diff.len() == 0: return targetViewAng
  let unit = diff.unit()

  normalized: curViewAng + unit * min(t, unit.len())


proc forward*(self: QAngle): Vector3f0 = 
  let self = inRadians self
  var sp, sy, cp, cy: float
  
  sp = sin self.pitch()
  sy = sin self.yaw()
  cp = cos self.pitch()
  cy = cos self.yaw()

  result.x = cp * cy
  result.y = cp * sy
  result.z = -sp
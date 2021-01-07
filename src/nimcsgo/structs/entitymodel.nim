import ./vector

type EntityModel* = object
  handle: pointer
  name: array[260, char]
  load_flags: cint
  server_count: cint
  `type`: cint
  flags: cint
  vec_mins: Vector3f0
  vec_maxs: Vector3f0
  radius: cfloat
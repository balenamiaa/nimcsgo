


type GlobalVars* = object
  realTime*: cfloat
  frameCount*: cint
  absolute_frametime*, absolute_frame_start_time*, cur_time*, frame_time*: cfloat
  max_clients*: cint
  tickCounts*: cint
  interval_per_tick*, interpolation_amount*: cfloat
  sim_ticks_this_frame*, network_protocol*: cint
  pSaveData*: pointer
  isClient*, isRemoteClient*: bool
  timestamp_networking_base, timestamp_randomize_window: cint



var gCsGlobalVars* {.global.}: ptr GlobalVars = nil
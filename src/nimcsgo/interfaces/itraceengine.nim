import ../vtableinterface, ../structs/tracestructs, ../structs/entity, ../structs/vector


vtableInterface ITraceEngine:
  idx 5:
    proc prv_traceRay(self: ptr ITraceEngine, ray: ptr Ray, mask: TraceMask, filter: pointer, trace: ptr Trace): void {.thiscall.}
  proc traceRay*[T: TraceFilterConcept](self: ptr ITraceEngine, ray: ptr Ray, mask: TraceMask, filter: T, trace: ptr Trace): void = 
    prv_traceRay(self, ray, mask, cast[pointer](filter), trace)


genInstantiation ITraceEngine


proc isVisible*(self: ptr Entity, other: ptr Entity, pos: Vector3f0): bool =
  var trace: Trace
  var ray: Ray = initRay(self.eye(), pos)
  var filter = initTraceFilterGeneric(self)
  ITraceEngine.instance.traceRay(ray.addr, 0x4600400B.TraceMask, filter.filter.addr, trace.addr)
  trace.pEntity == other or trace.fraction > 0.97






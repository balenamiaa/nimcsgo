import ./vector

type
  RecvVarProxyProcTy* = proc(data: ptr RecvProxy, pStruct: pointer, pOut: pointer): void {.cdecl.}
  ArrayLengthRecvProxyProcTy* = proc(pStruct: pointer, idObject: cint, currentArrayLength: cint): void {.cdecl.}
  DataTableRecvVarProxyProcTy* = proc(data: ptr RecvProp, pOut: ptr pointer, pData: pointer, idObject: cint): void {.cdecl.}
  PropKind* {.size: sizeof(cint).} = enum
    ptInt = 0
    ptFloat
    ptVec
    ptVecXY
    ptString
    ptArray
    ptDataTable
    ptInt64
  PropVariant* = object #TODO: replace this with nim tagged union based on kind discriminator
    case kind: PropKind
    of ptInt:
      vInt: cint
    of ptFloat:
      vFloat: cfloat
    of ptVec:
      vVector: Vector3f0
    of ptVecXY:
      vVectorXY: Vector3f0
    of ptString:
      vString: cstring
    of ptArray:
      vArray: pointer
    of ptDataTable:
      vData: pointer
    of ptInt64:
      vInt64: clonglong
  RecvTable* = object
    pProps*: ptr RecvProp
    nProps*: cuint
    decoder*: pointer
    tableName*: cstring
    isInit: bool
    isInMainList: bool
  RecvProp* = object
    propName*: cstring
    propKind*: PropKind
    propFlags*: cint
    bufferSize*: cint
    isInsideArray*: cint
    pExtraData*: pointer
    propArray*: ptr RecvProp
    procArrayLengthProxy*: ArrayLengthRecvProxyProcTy
    procVarProxy*: RecvVarProxyProcTy
    procDataTableProxy*: DataTableRecvVarProxyProcTy
    dataTable*: ptr RecvTable
    offset*: cuint
    elementStride*: cint
    elementsCount*: cint
    parentPropArrayName*: cstring
  RecvProxy* = object
    recvProp*: ptr RecvProp
    value*: PropVariant
    idxElement*: cint
    idObject*: cint
  
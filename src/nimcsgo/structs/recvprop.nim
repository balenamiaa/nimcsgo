import ./vector

type
  RecvVarProxyProcTy* = proc(data: ptr CRecvProxy, pStruct: pointer, pOut: pointer): void {.cdecl.}
  ArrayLengthRecvProxyProcTy* = proc(pStruct: pointer, idObject: cint, currentArrayLength: cint): void {.cdecl.}
  DataTableRecvVarProxyProcTy* = proc(data: ptr CRecvProp, pOut: ptr pointer, pData: pointer, idObject: cint): void {.cdecl.}
  PropType* {.size: sizeof(cint).} = enum
    ptInt = 0
    ptFloat
    ptVec
    ptVecXY
    ptString
    ptArray
    ptDataTable
    ptInt64
  CVariantData* {.union.} = object
    cvdFloat*: cfloat
    cvdInt*: cint
    cvdString*: cstring
    cvdData*: pointer
    cvdVector*: Vector3f0
    cvdInt64*: clonglong
  CVariant* = object #TODO: replace this with nim tagged union based on kind discriminator
    data*: CVariantData
    propType*: PropType
  CRecvTable* = object
    pProps*: ptr CRecvProp
    nProps*: cuint
    decoder*: pointer
    tableName*: cstring
    isInit: bool
    isInMainList: bool
  CRecvProp* = object
    propName*: cstring
    propType*: PropType
    propFlags*: cint
    bufferSize*: cint
    isInsideArray*: cint
    pExtraData*: pointer
    propArray*: ptr CRecvProp
    procArrayLengthProxy*: ArrayLengthRecvProxyProcTy
    procVarProxy*: RecvVarProxyProcTy
    procDataTableProxy*: DataTableRecvVarProxyProcTy
    dataTable*: ptr CRecvTable
    offset*: cint
    elementStride*: cint
    elementsCount*: cint
    parentPropArrayName*: cstring
  CRecvProxy* = object
    recvProp*: ptr CRecvProp
    value*: CVariant
    idxElement*: cint
    idObject*: cint
  
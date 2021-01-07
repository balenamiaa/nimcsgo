import ../vtableinterface, ../structs/studio, ../structs/entitymodel
import options


vtableInterface IModelInfo:
  idx 32: 
    proc prv_studioModel(self: ptr IModelInfo, pEntityModel: ptr EntityModel): ptr StudioHdr {.thiscall.}
  proc studioModel*(self: ptr IModelInfo, pEntityModel: ptr EntityModel): Option[ptr StudioHdr] = self.prv_studioModel(pEntityModel).option

genInstantiation IModelInfo






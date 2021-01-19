import os, winim/lean

const path = currentSourcePath.parentDir() & "\\renderer"

{.passC: "-I" & path.}
{.passL: getEnv("GCC_PATH").parentDir() & "/i686-w64-mingw32/lib/libd3dx9.a", passL: getEnv("GCC_PATH").parentDir() & "/i686-w64-mingw32/lib/libgdi32.a".}
{.compile: path & "\\renderer.cpp", compile: path & "\\font.cpp".}


type
  Renderer* {.header:"renderer.h", importcpp: "Renderer".} = object
  Rect* {.header:"renderer.h", importcpp: "Rect".} = object
  D3DCOLOR* {.header: "nd3dtypes.h", importcpp: "D3DCOLOR".} = object
  IDirect3DDevice9* {.header: "d3d9.h", importcpp: "IDirect3DDevice9".} = object
  IDirect3DSurface9* {.header: "d3d9.h", importcpp: "IDirect3DSurface9".} = object
  IDirect3DPixelShader9* {.header: "d3d9.h", importcpp: "IDirect3DPixelShader9".} = object
  D3DSURFACE_DESC* {.header: "d3d9.h", importcpp: "D3DSURFACE_DESC".} = object
  IDirect3DVertexBuffer9* {.header: "d3d9.h", importcpp: "IDirect3DVertexBuffer9".} = object
  IDirect3DStateBlock9* {.header: "d3d9.h", importcpp: "IDirect3DStateBlock9".} = object
  ID3DXBuffer* {.header: "d3d9.h", importcpp: "ID3DXBuffer".} = object
  ID3DXFont* {.header: "d3d9.h", importcpp: "ID3DXFont".} = object
  D3DCAPS9* {.header: "d3d9.h", importcpp: "ID3DXFont".} = object
  FontWeight* {.size: sizeof(UINT).} = enum
    fwThin = 100
    fwNormal = 400
    fwBold = 700
    fwHeavy = 900
  D3DPRIMITIVETYPE* {.size: sizeof(cuint).} = enum
    D3DPT_POINTLIST      = 1,
    D3DPT_LINELIST       = 2,
    D3DPT_LINESTRIP      = 3,
    D3DPT_TRIANGLELIST   = 4,
    D3DPT_TRIANGLESTRIP  = 5,
    D3DPT_TRIANGLEFAN    = 6,



proc release(self: ptr IDirect3DSurface9) {.header: "d3dx9.h", importcpp: "#.Release()".}
proc getDeviceCaps(self: ptr IDirect3DDevice9, caps: var D3DCAPS9) {.header: "d3dx9.h", importcpp: "#.GetDeviceCaps(@)".}


var DEFAULT_CHARSET* {.header: "d3d9.h", importcpp: "DEFAULT_CHARSET".}: DWORD
var OUT_DEFAULT_PRECIS* {.header: "d3d9.h", importcpp: "OUT_DEFAULT_PRECIS".}: DWORD
var ANTIALIASED_QUALITY* {.header: "d3d9.h", importcpp: "ANTIALIASED_QUALITY".}: DWORD
var DEFAULT_PITCH* {.header: "d3d9.h", importcpp: "DEFAULT_PITCH".}: DWORD

proc d3dxCreateFont*(
  pDevice: ptr IDirect3DDevice9, height: INT, width: UINT = 0, weight: FontWeight = fwNormal, mipLevels: UINT = 0,
  italic: BOOL = true, charSet: DWORD = DEFAULT_CHARSET, outputPrecision: DWORD = OUT_DEFAULT_PRECIS, quality: DWORD = ANTIALIASED_QUALITY, pitchAndFamily: DWORD = DEFAULT_PITCH,
  fontname: LPCTSTR, ppOut: ptr ptr ID3DXFont): HRESULT {.header: "d3dx9.h", importcpp: "D3DXCreateFont(@)".}


#proc initRect*(x,y,w,h: cfloat): Rect {.header:"renderer.h", importcpp: "Rect(@)".}

#proc initRenderer*(pDevice: pointer): Renderer {.header: "renderer.h", importcpp: "Renderer(@)".}
#proc deinitRenderer*(renderer: Renderer) {.header: "renderer.h", importcpp: "#.~Renderer()".}
proc getTextLength*(font: ptr ID3DXFont, content: cstring): cint  {.header: "renderer.h", importcpp: "CRenderer::getTextLength(@)".}
proc drawText*(font: ptr ID3DXFont, x,y: cint, color: D3DCOLOR, outlined: bool, content: cstring) {.header: "renderer.h", importcpp: "CRenderer::drawText(@)".}
proc drawBorderedBox*(pDevice: ptr IDirect3DDevice9, x,y,w,h: cint = 0, thickness: cint = 1, color: D3DCOLOR)  {.header: "renderer.h", importcpp: "CRenderer::drawBorderedBox(@)".}
proc drawLine*(pDevice: ptr IDirect3DDevice9, x,y,x2,y2: cint = 0, color: D3DCOLOR)  {.header: "renderer.h", importcpp: "CRenderer::drawLine(@)".}
#proc release*(renderer: Renderer) {.header: "renderer.h", importcpp: "#.release()".}
#proc acquire*(renderer: Renderer) {.header: "renderer.h", importcpp: "#.acquire()".}

#proc begin*(renderer: Renderer, topology: cuint) {.header: "renderer.h", importcpp: "#.begin(@)".}
#proc `end`*(renderer: Renderer) {.header: "renderer.h", importcpp: "#.end()".}



proc rgba*(r, g, b, a: uint8): D3DCOLOR = {.emit: "return D3DCOLOR_RGBA(`r`, `g`, `b`, `a`);".}
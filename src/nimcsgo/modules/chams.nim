import base, options

{.emit:"""
#include <d3d9.h>
#include <d3dx9.h>
#define CUSTOMFVF (D3DFVF_XYZRHW | D3DFVF_TEX1)

IDirect3DPixelShader9* pixelshader = NULL;
LPDIRECT3DTEXTURE9 pTexture = NULL;

const BYTE bRed[60] = { 0x42, 0x4D, 0x3C, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x36, 0x00, 0x00,
    0x00, 0x28, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00,
    0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x20, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0x0B,
    0x00, 0x00, 0x12, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00,
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xFF, 0x00,
    0x00, 0x01 };

struct CUSTOMVERTEX {
    FLOAT x, y, z, r, h, w;
};

void* draw_points_ret_addr;

void* traverse_stack(void** ebp)
{
    if (ebp == nullptr)
        return nullptr;
 
    auto** next = *(void***)(ebp);
    if (ebp[1] == draw_points_ret_addr)
        return next[4];
 
    return traverse_stack(next);
}
 
void* get_ent()
{
    int data = 0;
    asm("movl %%ebp, %0"
        : "=r"(data));
    return traverse_stack((void**)(data));
}

""".}


var enabled*: bool = true


section ImGui("Chams", nil):
  igCheckbox("Enabled", enabled.addr)

section DrawIndexedPrimitive(pDevice, `type`, baseVertexIndex, minVertexIndex, numVertices, startIndex, primCount):
  var initialized {.global.} = false;
  if not initialized:
    let pattern = patternScan(xorEncrypt "8B 7D FC 03 F8", xorEncrypt "studiorender.dll").get()
    {.emit:"""
    D3DXCreateTextureFromFileInMemory(pDevice, (LPCVOID)&bRed, sizeof(bRed), &pTexture);
    draw_points_ret_addr = `pattern`;
    char szShader[256];
    sprintf(szShader, "ps.1.1\ndef c0, %f, %f, %f, %f\nmov r0,c0", 0.9, 0.0, 0.6, 0.5);
    ID3DXBuffer* pShaderBuf = NULL;
 
    D3DXAssembleShader(szShader, sizeof(szShader), NULL, NULL, 0, &pShaderBuf, NULL);
    pDevice->CreatePixelShader((const DWORD*)pShaderBuf->GetBufferPointer(), &pixelshader);
 
    """.}
    initialized = true

  if not enabled: return 
  if gGuiEnabled: return

  if gLocalPlayer.isNil(): return

  var pEnt: ptr Entity = nil
  {.emit: "`pEnt` = get_ent();".}

  if pEnt.isNil(): return
  if pEnt.lifestate() != elsAlive: return
  if pEnt == gLocalPlayer: return

  if pEnt.team() != gLocalPlayer.team() and pEnt.team() in {etT, etCt}:
    {.emit:"""
    IDirect3DPixelShader9* oldShader = nullptr;
    LPDIRECT3DTEXTURE9 oldtexture = nullptr;

    `pDevice`->GetTexture(0, &pTexture);
    `pDevice`->GetPixelShader(&oldShader);

    `pDevice`->SetTexture(0, pTexture);
    `pDevice`->SetPixelShader(pixelshader);

    """.}
    discard ogDrawIndexedPrimitive(pDevice, `type`, baseVertexIndex, minVertexIndex, numVertices, startIndex, primCount)
    {.emit:"""
    `pDevice`->SetPixelShader(oldShader);
    `pDevice`->SetTexture(0, oldtexture);
    """.}






section PostResetFrame(pDevice):
   {.emit:"""
if (pTexture != nullptr){
  pTexture->Release();
  D3DXCreateTextureFromFileInMemory(pDevice, (LPCVOID)&bRed, sizeof(bRed), &pTexture);
}

if (pixelshader != nullptr){
  pixelshader->Release();
  char szShader[256];
  sprintf(szShader, "ps.1.1\ndef c0, %f, %f, %f, %f\nmov r0,c0", 0.9, 0.0, 0.6, 0.5);
  ID3DXBuffer* pShaderBuf = NULL;

  D3DXAssembleShader(szShader, sizeof(szShader), NULL, NULL, 0, &pShaderBuf, NULL);
  pDevice->CreatePixelShader((const DWORD*)pShaderBuf->GetBufferPointer(), &pixelshader);
}
""".}
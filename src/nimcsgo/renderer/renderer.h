#pragma once

#include <d3d9.h>
#include <d3dx9.h>

namespace CRenderer{
  struct SD3DVertex
  {
    float x, y, z, rhw;
    DWORD color;
  };

  void drawText(ID3DXFont *font, int x, int y, D3DCOLOR color, bool outlined, char *string);
  int getTextLength(ID3DXFont *font, char *string);
  void drawLine(IDirect3DDevice9 *pDevice, int x, int y, int x2, int y2, D3DCOLOR color);
  void drawFilledBox(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, D3DCOLOR color);
  void drawFilledBoxOutlined(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color, D3DCOLOR outlinecolor);
  void drawBorderedBox(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color);
  void drawBorderedBoxOutline(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color, D3DCOLOR outlinecolor);
};
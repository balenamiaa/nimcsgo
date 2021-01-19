#include "renderer.h"
#include <stdio.h>
#include <stdarg.h>

void CRenderer::drawText(ID3DXFont *font, int x, int y, D3DCOLOR color, bool outlined, char *string)
{

  RECT pRect;
  if (outlined)
  {
    pRect.left = x - 1;
    pRect.top = y;
    font->DrawText(NULL, string, strlen(string), &pRect, DT_NOCLIP, D3DCOLOR_RGBA(0, 0, 0, 255));
    pRect.left = x + 1;
    pRect.top = y;
    font->DrawText(NULL, string, strlen(string), &pRect, DT_NOCLIP, D3DCOLOR_RGBA(0, 0, 0, 255));
    pRect.left = x;
    pRect.top = y - 1;
    font->DrawText(NULL, string, strlen(string), &pRect, DT_NOCLIP, D3DCOLOR_RGBA(0, 0, 0, 255));
    pRect.left = x;
    pRect.top = y + 1;
    font->DrawText(NULL, string, strlen(string), &pRect, DT_NOCLIP, D3DCOLOR_RGBA(0, 0, 0, 255));
  }
  pRect.left = x;
  pRect.top = y;
  font->DrawText(NULL, string, strlen(string), &pRect, DT_NOCLIP, color);
}
int CRenderer::getTextLength(ID3DXFont *font, char *string)
{
  RECT pRect = RECT();
  font->DrawText(NULL, string, strlen(string), &pRect, DT_CALCRECT, D3DCOLOR_RGBA(0, 0, 0, 0));
  return pRect.right - pRect.left;
}
void CRenderer::drawLine(IDirect3DDevice9 *pDevice, int x, int y, int x2, int y2, D3DCOLOR color)
{
  CRenderer::SD3DVertex pVertex[2] = {{x, y, 0.0f, 1.0f, color}, {x2, y2, 0.0f, 1.0f, color}};
  pDevice->SetFVF(D3DFVF_XYZRHW | D3DFVF_DIFFUSE);
  pDevice->DrawPrimitiveUP(D3DPT_LINELIST, 1, &pVertex, sizeof(CRenderer::SD3DVertex));
}
void CRenderer::drawFilledBox(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, D3DCOLOR color)
{
  CRenderer::SD3DVertex pVertex[4] = {{x, y + height, 0.0f, 1.0f, color}, {x, y, 0.0f, 1.0f, color}, {x + width, y + height, 0.0f, 1.0f, color}, {x + width, y, 0.0f, 1.0f, color}};
  pDevice->SetFVF(D3DFVF_XYZRHW | D3DFVF_DIFFUSE);
  pDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, pVertex, sizeof(CRenderer::SD3DVertex));
}
void CRenderer::drawFilledBoxOutlined(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color, D3DCOLOR outlinecolor)
{
  CRenderer::drawBorderedBox(pDevice, x, y, width, height, thickness, outlinecolor);
  CRenderer::drawFilledBox(pDevice, x + thickness, y + thickness, width - (thickness * 2), height - (thickness * 2), color);
}
void CRenderer::drawBorderedBox(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color)
{
  CRenderer::drawFilledBox(pDevice, x, y, width, thickness, color);
  CRenderer::drawFilledBox(pDevice, x, y, thickness, height, color);
  CRenderer::drawFilledBox(pDevice, x + width - thickness, y, thickness, height, color);
  CRenderer::drawFilledBox(pDevice, x, y + height - thickness, width, thickness, color);
}
void CRenderer::drawBorderedBoxOutline(IDirect3DDevice9 *pDevice, int x, int y, int width, int height, int thickness, D3DCOLOR color, D3DCOLOR outlinecolor)
{
  CRenderer::drawBorderedBox(pDevice, x, y, width, height, thickness, outlinecolor);
  CRenderer::drawBorderedBox(pDevice, x + thickness, y + thickness, width - (thickness * 2), height - (thickness * 2), thickness, color);
  CRenderer::drawBorderedBox(pDevice, x + (thickness * 2), y + (thickness * 2), width - (thickness * 4), height - (thickness * 4), thickness, outlinecolor);
}
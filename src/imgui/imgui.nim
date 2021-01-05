import os, winim/lean

{.passC: "-I" & currentSourcePath.parentDir() & "\\imgui" & " -I" & currentSourcePath.parentDir() & "\\imgui\\backends".}
{.compile: "imgui/imgui.cpp", compile: "imgui/imgui_widgets.cpp", compile: "imgui/imgui_draw.cpp", compile: "imgui/imgui_tables.cpp".}
{.compile: "imgui/backends/imgui_impl_dx9.cpp", compile("imgui/backends/imgui_impl_win32.cpp", "-DIMGUI_IMPL_WIN32_DISABLE_GAMEPAD -DNOGDI").}

const 
  implwin32 = "imgui_impl_win32.h"
  impldx9 = "imgui_impl_dx9.h"

{.emit:"""
#include "imgui.h"
#include <windows.h>
""".}

type IDirect3DDevice9* {.importc: "IDirect3DDevice9", header: "<d3d9.h>".} = object
type D3DPRESENT_PARAMETERS* {.importc: "D3DPRESENT_PARAMETERS", header: "<d3d9.h>".} = object

{.emit:"""
extern IMGUI_IMPL_API LRESULT ImGui_ImplWin32_WndProcHandler(HWND hWnd, UINT msg, WPARAM wParam, LPARAM lParam);""".}
proc ImGui_ImplWin32_WndProcHandler(hWnd: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT {.importcpp: "ImGui_ImplWin32_WndProcHandler(@)", header:implwin32.}


proc ImGui_ImplDX9_Init(pDevice: ptr IDirect3DDevice9): bool {.importcpp: "ImGui_ImplDX9_Init(@)", header:impldx9.}
proc ImGui_ImplDX9_Shutdown(): void {.importcpp: "ImGui_ImplDX9_Shutdown(@)", header:impldx9.}
proc ImGui_ImplDX9_NewFrame(): void {.importcpp: "ImGui_ImplDX9_NewFrame(@)", header:impldx9.}
proc ImGui_ImplDX9_InvalidateDeviceObjects(): void {.importcpp: "ImGui_ImplDX9_InvalidateDeviceObjects(@)", header:impldx9.}

proc win32Init*(hWnd: HWND):  bool {.importcpp: "ImGui_ImplWin32_Init(@)", header:implwin32.}
proc win32WndProc*(hWnd: HWND, msg: UINT, wParam: WPARAM, lParam: LPARAM): LRESULT = ImGui_ImplWin32_WndProcHandler(hWnd, msg, wParam, lParam)
proc win32NewFrame*(): void {.importcpp: "ImGui_ImplWin32_NewFrame(@)".}

proc dx9Init*(pDevice: ptr IDirect3DDevice9): bool = ImGui_ImplDX9_Init(pDevice)
proc dx9CreateDeviceObjects*(): bool {.importcpp: "ImGui_ImplDX9_CreateDeviceObjects(@)", header:impldx9.}
proc dx9Shutdown*(): void = ImGui_ImplDX9_Shutdown()
proc dx9NewFrame*(): void = ImGui_ImplDX9_NewFrame()
proc dx9InvalidateDeviceObjects*(): void = ImGui_ImplDX9_InvalidateDeviceObjects()
proc dx9RenderDrawData*(): void {.importcpp: "ImGui_ImplDX9_RenderDrawData(ImGui::GetDrawData())", header: impldx9.}

proc igCreateContext*(): pointer {.importcpp: "ImGui::CreateContext(@)".}
proc igNewFrame*(): void {.importcpp: "ImGui::NewFrame(@)".}
proc igRender*(): void {.importcpp: "ImGui::Render(@)".}
proc igEndFrame*(): void {.importcpp: "ImGui::EndFrame(@)".}
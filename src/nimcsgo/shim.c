#include <windows.h>
#include <stdio.h>
#pragma comment(lib, "user32.lib");

extern void __cdecl NimMain(void);
extern void __cdecl Entry(HINSTANCE);

void mainDllThread(HINSTANCE hInstance)
{
  AllocConsole();
  freopen_s((FILE**)stdout, "CONOUT$", "w", stdout);
  NimMain();
  Entry(hInstance);
}

__declspec(dllexport) BOOL WINAPI DllMain(HINSTANCE hInstance, DWORD dwReason, LPVOID lpReserved)
{
  switch (dwReason)
  {
  case DLL_PROCESS_ATTACH:
    DisableThreadLibraryCalls(hInstance);
    CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)mainDllThread, &hInstance, NULL, NULL);
    break;
  case DLL_PROCESS_DETACH:
    FreeLibraryAndExitThread(hInstance, 0);
    break;
  default:
    break;
  }
  return 1;
}
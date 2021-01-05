import os, winim/lean, winim/inc/tlhelp32


assert(paramCount() >= 2, "Invalid number of arguments")

let dllPath = paramStr(1).string
let targetExeFile = paramStr(2).string


let processId = block:
  var result: uint = 0
  let hProcessSnap: HMODULE = CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0)
  assert(hProcessSnap != INVALID_HANDLE_VALUE, "Couldn't create process snapshot")

  var pe32: PROCESSENTRY32
  pe32.dwSize = sizeof(PROCESSENTRY32).DWORD
  
  if Process32First(hProcessSnap, pe32) == 0:
    CloseHandle(hProcessSnap)
    raise newException(AssertionError, "Couldn't get first process")
  while true:
    if pe32.szExeFile.addr.cstring == targetExeFile:
      result = pe32.th32ProcessID.uint
      break
    
    if Process32Next(hProcessSnap, pe32) == 0:
      CloseHandle(hProcessSnap)
      raise newException(AssertionError, "Couldn't get next process")
  
  CloseHandle(hProcessSnap)
  result

let hProcess = OpenProcess(PROCESS_ALL_ACCESS, false, processId.DWORD)
assert(hProcess != 0, "Couldn't open handle to the process")


let ntOpenFile = GetProcAddress(LoadLibrary("ntdll"), "NtOpenFile")
assert(ntOpenFile != nil, "Couldn't get NtOpenFile address")

var originalBytes: array[5, byte]
var patchedBytes: array[5, byte]
copyMem(originalBytes.addr, ntOpenFile, 5)

var originalProtection: DWORD = 0
VirtualProtectEx(hProcess, ntOpenFile, 5, PAGE_READWRITE, originalProtection.addr)
ReadProcessMemory(hProcess, ntOpenFile, patchedBytes.addr, 5, nil)
WriteProcessMemory(hProcess, ntOpenFile, originalBytes.addr, 5, nil)
VirtualProtectEx(hProcess, ntOpenFile, 5, originalProtection, originalProtection.addr)

var data: pointer = VirtualAllocEx(hProcess, nil, dllPath.len.SIZE_T + 1, MEM_RESERVE or MEM_COMMIT, PAGE_EXECUTE_READWRITE)
WriteProcessMemory(hProcess, data, cast[pointer](dllPath.cstring), dllPath.len.SIZE_T + 1, nil)
let hThread = CreateRemoteThread(hProcess, nil, 0, cast[LPTHREAD_START_ROUTINE](GetProcAddress(GetModuleHandle("kernel32.dll"), "LoadLibraryA")), data, 0, nil)
WaitForSingleObject(hThread, INFINITE)

VirtualProtectEx(hProcess, ntOpenFile, 5, PAGE_READWRITE, originalProtection.addr)
WriteProcessMemory(hProcess, ntOpenFile, patchedBytes.addr, 5, nil)
VirtualProtectEx(hProcess, ntOpenFile, 5, originalProtection, originalProtection.addr)

CloseHandle(hProcess)
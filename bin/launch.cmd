@echo off
rem Reassembles LabVIEWMCP.exe from its two parts on first run (ZCode refuses any
rem single archive entry above 50 MB, and the official exe is ~85 MB), then execs it.
setlocal
set "BIN=%~dp0"
set "EXE=%BIN%LabVIEWMCP.exe"
if not exist "%EXE%" (
  copy /b "%BIN%LabVIEWMCP.exe.part00"+"%BIN%LabVIEWMCP.exe.part01" "%EXE%" >nul
  if errorlevel 1 (
    echo launch.cmd: failed to reassemble LabVIEWMCP.exe 1>&2
    exit /b 1
  )
)
"%EXE%" %*

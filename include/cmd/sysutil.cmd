::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: sysutil.cmd
:: Include version: 0.0.1
:: Include description: windows cmd system information.
::::::::::::::::::::::::::::::::::::::::::::

:: Main Logic
@echo off
::@echo on
::cls
set /a EnableDebug=0
if /i "%EnableDebug%" EQU "1" echo P1=%1 & echo.P2=%2 & echo.P3=%3 & echo.P4=%4 & echo.P5=%5 & echo.P6=%6 & echo.P7=%7 & echo.P8=%8 & echo.P9=%9
if /i "%EnableDebug%" EQU "1" echo P~1=%~1 & echo.P~2=%~2 & echo.P~3=%~3 & echo.P~4=%~4 & echo.P~5=%~5 & echo.P~6=%~6 & echo.P~7=%~7 & echo.P~8=%~8 & echo.P~9=%~9
if /i "%EnableDebug%" EQU "1" echo %~n0.cmd
:: Debug (Turn On/Off)
::echo (%~n0.cmd) P1=%1 P2=%2 P3=%3 P4=%4 P5=%5 P6=%6 P7=%7 P8=%8 P9=%9

:: Function: Main
:: Syntax: sysutil.cmd "[label]" ...
:: %~1 - label
goto %~1
echo ignored

:: Function: CPUArchitecture
:: Syntax: call sysutil.cmd "CPUARCH" "[rootPath]"
:: %~2 - rootPath
:CPUARCH
::https://en.wikipedia.org/wiki/List_of_Microsoft_Windows_versions
set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 set _os_bitness=32
  )
echo Operating System is %_os_bitness% bit
echo.
wmic os get version
ver
echo.
echo sysinfo... ?
:: %TMP% ???????? no admin perm (http://stackoverflow.com/a/4342516)
systeminfo >sysinfo_output.txt 2>sysinfo_error.txt
echo.
set ProgramFiles
pause
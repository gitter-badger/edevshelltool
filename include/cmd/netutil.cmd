::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: netutil.cmd
:: Include version: 0.0.1
:: Include description: network utils
::::::::::::::::::::::::::::::::::::::::::::

:: Pre-Initialization
@echo off
::@echo on
::cls

:: Debug Batch Script
set /a EnableDebug=0
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( echo Path + Filename + Extension: %0 & echo.Path: %~dp0 & echo.Filename: (%~n0^^^) )
if /i "%EnableDebug%" EQU "1" ( echo --------- & echo.  Debug Batch End & echo.--------- )
if /i "%EnableDebug%" EQU "1" ( pause )

:: Debug Parameters
set /a EnableDebugParameters=1
if /i "%EnableDebugParameters%" EQU "1" ( echo --------- & echo.  Debug Parameters & echo.--------- )
if /i "%EnableDebugParameters%" EQU "1" ( echo P1=%1 & echo.P~1=%~1 & echo."P1"="%1" & echo."P~1"="%~1" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P2=%2 & echo.P~2=%~2 & echo."P2"="%2" & echo."P~2"="%~2" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P3=%3 & echo.P~3=%~3 & echo."P3"="%3" & echo."P~3"="%~3" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P4=%4 & echo.P~4=%~4 & echo."P4"="%4" & echo."P~4"="%~4" )
if /i "%EnableDebugParameters%" EQU "1" ( echo P5=%5 & echo.P~5=%~5 & echo."P5"="%5" & echo."P~5"="%~5" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P6=%6 & echo.P~6=%~6 & echo."P6"="%6" & echo."P~6"="%~6" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P7=%7 & echo.P~7=%~7 & echo."P7"="%7" & echo."P~7"="%~7" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P8=%8 & echo.P~8=%~8 & echo."P8"="%8" & echo."P~8"="%~8" )
::if /i "%EnableDebugParameters%" EQU "1" ( echo P9=%9 & echo.P~9=%~9 & echo."P9"="%9" & echo."P~9"="%~9" )
if /i "%EnableDebugParameters%" EQU "1" ( echo --------- & echo.  Debug Parameters End & echo.--------- )
if /i "%EnableDebugParameters%" EQU "1" ( pause )

:: Initialization
for %%k in (%0) do set batchName=%%~nk

:: Main Logic
goto %~1
echo.ignored

:: label: DOWNFILE
:DOWNFILE
:: With PowerShell 2.0 (Windows 7 preinstalled) you can use:
::(New-Object Net.WebClient).DownloadFile('http://www.foo.com/package.zip', 'package.zip')
:: Starting with PowerShell 3.0 (Windows 8 preinstalled) you can use Invoke-WebRequest:
::Invoke-WebRequest http://www.foo.com/package.zip -OutFile package.zip
powershell -Command "(New-Object Net.WebClient).DownloadFile('http://www.foo.com/package.zip', 'package.zip')"
powershell -Command "Invoke-WebRequest http://www.foo.com/package.zip -OutFile package.zip"
goto exitOk

:: Terminate Include Subroutine
:exitOk
:: Exit only the script (or subroutine) but not CMD.EXE
exit /b
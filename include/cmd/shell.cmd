::::::::::::::::::::::::::::::::::::::::::::
:: Include filename: shell.cmd
:: Include version: 0.0.2
:: Include description: a simple include cmd script that can do shell things.
::::::::::::::::::::::::::::::::::::::::::::

:: Main Logic
@echo off
::@echo on
::cls
set /a EnableDebug=0
if /i "%EnableDebug%" EQU "1" echo --------- & echo.  Debug & echo.---------
if /i "%EnableDebug%" EQU "1" echo Script: %~n0.cmd & echo.
if /i "%EnableDebug%" EQU "1" echo P1=%1 & echo.P~1=%~1 & echo."P1"="%1" & echo."P~1"="%~1"
if /i "%EnableDebug%" EQU "1" echo P2=%2 & echo.P~2=%~2 & echo."P2"="%2" & echo."P~2"="%~2"
if /i "%EnableDebug%" EQU "1" echo P3=%3 & echo.P~3=%~3 & echo."P3"="%3" & echo."P~3"="%~3"
if /i "%EnableDebug%" EQU "1" echo P4=%4 & echo.P~4=%~4 & echo."P4"="%4" & echo."P~4"="%~4"
if /i "%EnableDebug%" EQU "1" echo P5=%5 & echo.P~5=%~5 & echo."P5"="%5" & echo."P~5"="%~5"
if /i "%EnableDebug%" EQU "1" echo P6=%6 & echo.P~6=%~6 & echo."P6"="%6" & echo."P~6"="%~6"
if /i "%EnableDebug%" EQU "1" echo P7=%7 & echo.P~7=%~7 & echo."P7"="%7" & echo."P~7"="%~7"
if /i "%EnableDebug%" EQU "1" echo P8=%8 & echo.P~8=%~8 & echo."P8"="%8" & echo."P~8"="%~8"
if /i "%EnableDebug%" EQU "1" echo P9=%9 & echo.P~9=%~9 & echo."P9"="%9" & echo."P~9"="%~9"
if /i "%EnableDebug%" EQU "1" echo --------- & echo.  Debug & echo.---------
if /i "%EnableDebug%" EQU "1" pause
goto %~1
echo ignored

:: label: LOG
:LOG
echo %DATE%%TIME% - %~3 >>%~2appLog.txt 2>>%~2errorLog.txt
echo %DATE%%TIME% - %~3
goto EXIT

:: label: EXIT
:EXIT
exit /b

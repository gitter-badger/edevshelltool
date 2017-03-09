::::::::::::::::::::::::::::::::::::::::::::
:: Authors: alex1a, ljmf00
:: Description: Boostrap script for Windows systems.
::::::::::::::::::::::::::::::::::::::::::::

:: Initialization
@echo off
::@echo on
cls
set /p BuildVersion=<%~dp0version.txt
set AppTitle="EDev Shell Tool v%BuildVersion%"
title %AppTitle%

:: Path Initialization
set LocalDir=%~dp0
:: /src
set LocalSourceDir=%~dp0src\
set LocalSourceCmdDir=%LocalSourceDir%cmd
set LocalSourceBashDir=%LocalSourceDir%bash
set LocalSourcePsDir=%LocalSourceDir%ps
:: /lib
set LocalLibraryDir=%~dp0lib\
set LocalLibraryCmdDir=%LocalLibraryDir%cmd
set LocalLibraryBashDir=%LocalLibraryDir%bash
set LocalLibraryPsDir=%LocalLibraryDir%ps
:: /include
set LocalIncludeDir=%~dp0include\
set LocalIncludeCmdDir=%LocalIncludeDir%cmd
set LocalIncludeBashDir=%LocalIncludeDir%bash

:: Includes Initialization
set IncludeCmdShell=%LocalIncludeCmdDir%\shell.cmd
set IncludeCmdElevate=%LocalIncludeCmdDir%\elevate.cmd

:: Main Logic
set RunCmdScript=%LocalSourceCmdDir%\run.cmd
call %IncludeCmdShell% "LOG" "%LocalDir%" "Initialization completed"
:: Elevate Permissions
call %IncludeCmdElevate% "ELEVATE" "%LocalDir%" "%RunCmdScript%" %AppTitle% "test arg 4 with spaces"
call %IncludeCmdShell% "LOG" "%LocalDir%" "TEST"

:: Debug Console Close
::exit /b
pause >nul
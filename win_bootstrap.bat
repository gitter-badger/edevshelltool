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
set LocalDir=%~dp0
set LocalSourceDir=%~dp0src\
set LocalSourceCmdDir=%LocalSourceDir%cmd
set LocalSourceBashDir=%LocalSourceDir%bash
set LocalSourcePsDir=%LocalSourceDir%ps
set LocalLibraryDir=%~dp0lib\
set LocalLibraryCmdDir=%LocalLibraryDir%cmd
set LocalLibraryBashDir=%LocalLibraryDir%bash
set LocalLibraryPsDir=%LocalLibraryDir%ps
set LocalIncludeDir=%~dp0include\
set LocalIncludeCmdDir=%LocalIncludeDir%cmd
set LocalIncludeBashDir=%LocalIncludeDir%bash
title %AppTitle%

:: Elevate Permissions
call %LocalIncludeCmdDir%\shell.cmd "LOG" "%LocalDir%" "Calling Admin CMD (%LocalSourceCmdDir%\run.cmd)"
call %LocalIncludeCmdDir%\shell.cmd "ELEVATE" "%LocalDir%" "%LocalSourceCmdDir%\run.cmd" "%AppTitle%"

:: Terminate
::exit
pause >nul

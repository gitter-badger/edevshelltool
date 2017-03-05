::::::::::::::::::::::::::::::::::::::::::::
:: Filename: steamcmd_guardian_win.bat
:: Version: 1.2
:: Authors: ckynick254
:: References: https://developer.valvesoftware.com/wiki/SteamCMD#SteamCMD_Guardian_1.2
:: Updated: Yes (alex1a)
:: Description: SteamCMD Guardian Tool.
::::::::::::::::::::::::::::::::::::::::::::

::=======================::
:: SteamCMD Guardian 1.2 ::
::       ckynick254      ::
::=======================::
set programname=SteamCMD Guardian 1.1
::=======================::
::  SET YOUR VARIABLES!  ::
::=======================::
set servername=
set username=
set password=
::=======================::
::      Your folder      ::
::    Replace after =    ::
::=======================::
set runcmd=E:\Games\
 
::=======================::
::   End of variables    ::
::=======================::
 
:: This will keep the window clean and easy to read
@ECHO off
 
:: Sets the title of the window
title %programname% - %servername%
 
:: Clears the window incase there is anything there
cls
COLOR 1f
CD %runcmd%
 
:: Prints to the window what we are doing
ECHO %programname% has been started!
:start
ECHO.
ECHO.
ECHO   ##############################################################
ECHO   #                    Dedicated Server                        #
ECHO   # 1 - Half-Life: Deathmatch and Counter-Strike               #
ECHO   # 2 - Counter-Strike: Global Offensive                       #
ECHO   # 3 - Nuclear Dawn Dedicated Server                          #
ECHO   # 4 - Red Orchestra Dedicated Server                         #
ECHO   # 5 - Red Orchestra 2: Heroes of Stalingrad Dedicated Server #
ECHO   # 6 - Killing Floor Dedicated Server                         #
ECHO   # 7 - Team Fortress 2 Dedicated Server Beta                  #
ECHO   # 8 - HELP!                                                  #
ECHO   # 9 - Exit                                                   #
ECHO   ##############################################################
ECHO.
ECHO.
 
:: Delete variable %A%
SET "A="
SET /P A=Set Your Choice And Press Enter: 
ECHO Loading .........
IF "%A%"=="1" set app=90 
IF "%A%"=="2" set app=740
IF "%A%"=="3" set app=111710
IF "%A%"=="4" set app=223240
IF "%A%"=="5" set app=212542
IF "%A%"=="6" set app=215350
IF "%A%"=="7" set app=229830
IF "%A%"=="8" ECHO.
IF "%A%"=="8" ECHO https://developer.valvesoftware.com/wiki/SteamCMD
IF "%A%"=="8" ECHO.
IF "%A%"=="8" PAUSE
IF "%A%"=="8" goto start
IF "%A%"=="9" EXIT
 
:: This is a return point in case the server crashes or is closed
:restart
ECHO.
ECHO (%date%)(%time%) %servername% is now ONLINE
ECHO Watching %servername% for crashes...
>> "%servername%.log" ECHO.
>> "%servername%.log" ECHO (%date%)(%time%) %servername% is now ONLINE
>> "%servername%.log" ECHO (%date%)(%time%) Watching %servername% for crashes...
 
::Start the actual update window
start /wait steamcmd +login %username% %password% +force_install_dir %runcmd%%app%Server\ +app_update %app% validate
ECHO (%time%) WARNING: srcds closed or crashed, restarting.
ECHO.
ECHO (%date%)(%time%) Crash or Close detected!
ECHO %servername% is now restarting...
>> "%servername%.log" ECHO.
>> "%servername%.log" ECHO (%date%)(%time%) Crash or Close detected!
>> "%servername%.log" ECHO (%date%)(%time%) %servername% is now restarting...
 
::Server crashed or closed, so we point it to the return point to start the server again
GOTO restart
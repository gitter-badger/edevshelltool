@echo off

echo.%~dp0
echo.%0
echo.%~0
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
echo.%batchName%
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
echo.%vbsGetPrivileges%

pause

SET INPUT=
SET /P INPUT=Type 1 for client 2 for server then press ENTER:
IF /I '%INPUT%'=='1' GOTO MINECRAFTCLIENT
IF /I '%INPUT%'=='2' GOTO MINECRAFTSERVER

:MINECRAFTCLIENT
java -jar %~dp0etc\minecraft\Launcher_EN.jar
pause

:MINECRAFTSERVER
java -Xmx1024M -Xms1024M -jar %~dp0etc\minecraft\minecraft_server183.jar
pause


 IF "%PATH%" == "" GOTO NOPATH
   :YESPATH
   @ECHO The PATH environment variable was detected.
   @ECHO
   @ECHO %PATH%
   PAUSE
   @ECHO
   @ECHO Adding new folder to PATH environment variable.
   SETX PATH "%PATH%;C:\MinGW\bin"
   @ECHO New folder successful saved on PATH environment variable.
   @ECHO
   @ECHO %PATH%
   PAUSE
   GOTO END
   :NOPATH
   @ECHO The PATH environment variable was NOT detected.
   PAUSE
   GOTO END
:END



:: PHP DEV WEB SERVER

C:\php\php.exe -S localhost:80 -t D:\ProgrammingFiles\mainpage
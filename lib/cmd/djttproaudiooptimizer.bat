@echo off
if exist %USERPROFILE%\DJbatch.txt goto menu
start reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
echo Don't delete this file! The Ultimate Dj Batch file needs it to run fine! >> %USERPROFILE%\DJbatch.txt

:menu
ECHO.
ECHO. Welcome to the DJTT Pro Audio Optimizer
ECHO.
ECHO.
ECHO. Press 1 Optimize
ECHO. Press 2 Restore
ECHO. Press 3 Quit
ECHO.
ECHO.
Set /p input=What do you want to do?

IF %Input% == 1 GOTO Optimize
IF %Input% == 2 GOTO Restore
IF %Input% == 3 GOTO Quit

:Optimize
CLS
ECHO.
ECHO. Optimizing your computer now!
ECHO.

rem Stopping Windows Firewall, Windows Defender and Avast!...
net stop mpssvc /yes 2>%USERPROFILE%\temp.txt
net stop windefend /yes 2>%USERPROFILE%\temp.txt
net stop "avast! Antivirus" /yes 2>%USERPROFILE%\temp.txt

rem Stopping DHCP Client, Wireless LAN and Bluetooth...
net stop WinHttpAutoProxySvc /yes 2>%USERPROFILE%\temp.txt
net stop dhcp /yes 2>%USERPROFILE%\temp.txt
net stop wlansvc /yes 2>%USERPROFILE%\temp.txt
net stop btwdins /yes 2>%USERPROFILE%\temp.txt
net stop [service name] /yes 2>%USERPROFILE%\temp.txt

rem Stopping Other Network Related Services...
net stop "dns cache" /yes 2>%USERPROFILE%\temp.txt
net stop netprofm /yes 2>%USERPROFILE%\temp.txt
net stop nlasvc /yes 2>%USERPROFILE%\temp.txt
net stop netman /yes 2>%USERPROFILE%\temp.txt
net stop iphlpsvc /yes 2>%USERPROFILE%\temp.txt
net stop lanmanworkstation /yes 2>%USERPROFILE%\temp.txt
net stop "Bonjour Service" /yes 2>%USERPROFILE%\temp.txt
net stop dhcp /yes 2>%USERPROFILE%\temp.txt
net stop nsi /yes 2>%USERPROFILE%\temp.txt
net stop lanmanserver /yes 2>%USERPROFILE%\temp.txt
net stop lmhosts /yes 2>%USERPROFILE%\temp.txt
net stop "shared access" /yes 2>%USERPROFILE%\temp.txt
net stop nettcpportsharing /yes 2>%USERPROFILE%\temp.txt
net stop remoteaccess /yes 2>%USERPROFILE%\temp.txt
net stop alg /yes 2>%USERPROFILE%\temp.txt
net stop bits /yes 2>%USERPROFILE%\temp.txt
net stop "peerdists vc" /yes 2>%USERPROFILE%\temp.txt
net stop certpropsvc /yes 2>%USERPROFILE%\temp.txt
net stop homegrouplistener /yes 2>%USERPROFILE%\temp.txt
net stop homegroupprovider /yes 2>%USERPROFILE%\temp.txt
net stop winrm /yes 2>%USERPROFILE%\temp.txt
net stop Broswer /yes 2>%USERPROFILE%\temp.txt
net stop TrkWks /yes 2>%USERPROFILE%\temp.txt


rem Stopping other Windows Services...
net stop wscsvc /yes 2>%USERPROFILE%\temp.txt
net stop DPS /yes 2>%USERPROFILE%\temp.txt
net stop CscService /yes 2>%USERPROFILE%\temp.txt
net stop WPDBusEnum /yes 2>%USERPROFILE%\temp.txt
net stop ProtectedStorage /yes 2>%USERPROFILE%\temp.txt
net stop RemoteRegistry /yes 2>%USERPROFILE%\temp.txt
net stop seclogon /yes 2>%USERPROFILE%\temp.txt
net stop wscsvc /yes 2>%USERPROFILE%\temp.txt

rem Stopping Blue Tooth Services
net stop bthserv /yes 2>%USERPROFILE%\temp.txt

rem Stopping Remote Desktop and Remote Assistance Services
net stop sessionenv /yes 2>%USERPROFILE%\temp.txt
net stop termservice /yes 2>%USERPROFILE%\temp.txt

rem Stopping Windows Update Services
net stop wuauserv /yes 2>%USERPROFILE%\temp.txt

rem Stopping iPod Services
rem net stop "ipod service" /yes 2>%USERPROFILE%\temp.txt
rem net stop "Apple Mobile Device" /yes 2>%USERPROFILE%\temp.txt

rem Stopping Stuff that makes your PC look nice...
net stop themes /yes 2>%USERPROFILE%\temp.txt
net stop sensrsvc /yes 2>%USERPROFILE%\temp.txt
net stop AeLookupSvc /yes 2>%USERPROFILE%\temp.txt
net stop UxSms /yes 2>%USERPROFILE%\temp.txt

rem Stopping Scanner, Camera and other imaging Services...
net stop stisvc /yes 2>%USERPROFILE%\temp.txt
net stop hpqddsvc /yes 2>%USERPROFILE%\temp.txt
net stop hpslpsvc /yes 2>%USERPROFILE%\temp.txt

rem Stopping Windows Media Playing Sharing...
net stop WMPnetworksvc /yes 2>%USERPROFILE%\temp.txt

rem Stopping Tablet Device Support...
net stop tabletinputservice /yes 2>%USERPROFILE%\temp.txt

rem Stopping Other Windows Services...
net stop bdesvc /yes 2>%USERPROFILE%\temp.txt
net stop wbengine /yes 2>%USERPROFILE%\temp.txt
net stop uiodetect /yes 2>%USERPROFILE%\temp.txt
net stop defragsvc /yes 2>%USERPROFILE%\temp.txt
net stop axinstsv /yes 2>%USERPROFILE%\temp.txt
net stop "w32time" /yes 2>%USERPROFILE%\temp.txt
net stop wercplsupport /yes 2>%USERPROFILE%\temp.txt
net stop PnkBstrA /yes 2>%USERPROFILE%\temp.txt
net stop TeamViewer6 /yes 2>%USERPROFILE%\temp.txt
net stop HPSLPSVC /yes 2>%USERPROFILE%\temp.txt
net stop Wsearch /yes 2>%USERPROFILE%\temp.txt
net stop NAUpdate /yes 2>%USERPROFILE%\temp.txt

rem Stopping Printer Services
net stop spooler /yes 2>%USERPROFILE%\temp.txt

rem stopping useless programs
Taskkill /f /im TeamViewer.exe 2>%USERPROFILE%\temp.txt
Taskkill /im firefox.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im uTorrent.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im Dropbox.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im steam.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im "AAM Updates Notifier.exe" 2>%USERPROFILE%\temp.txt
Taskkill /f /im AvastUI.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im BTTray.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im hpqtra08.exe 2>%USERPROFILE%\temp.txt
Taskkill /f /im hpwuschd2.exe  2>%USERPROFILE%\temp.txt
Taskkill /f /im iexplorer.exe 2>%USERPROFILE%\temp.txt

rem Stop defragmentating RAM
Taskkill /im ramsaverpro.exe 2>%USERPROFILE%\temp.txt

if exist %USERPROFILE%\temp.txt del %USERPROFILE%\temp.txt

ECHO.
ECHO. Your PC has been optimized
ECHO.
ECHO.
ECHO. Press 1 if you want to restore everything for normal use
ECHO. Press 2 to quit
ECHO.
ECHO.
Set /p input=What do you want to do?

IF %Input% == 1 GOTO Restore
IF %Input% == 2 GOTO Quit

:Restore
CLS
ECHO.
ECHO. Restoring everything for normal use!
ECHO.
rem Defragmentating your RAM
if exist "%SYSTEMDRIVE%\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "%SYSTEMDRIVE%\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe"
if exist "%SYSTEMDRIVE%\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "%SYSTEMDRIVE%\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe"

rem Starting Windows Firewall, Windows Defender and Avast!...
net start mpssvc 2>%USERPROFILE%\temp.txt
net start windefend 2>%USERPROFILE%\temp.txt
net start "avast! Antivirus" 2>%USERPROFILE%\temp.txt

rem Starting DHCP Client, Bluetooth and Wireless LAN...
net start WinHttpAutoProxySvc 2>%USERPROFILE%\temp.txt
net start dhcp 2>%USERPROFILE%\temp.txt
net start wlansvc 2>%USERPROFILE%\temp.txt
net start btwdins 2>%USERPROFILE%\temp.txt

rem Starting Other Network Related Services...
net start "dns cache" 2>%USERPROFILE%\temp.txt
net start netprofm 2>%USERPROFILE%\temp.txt
net start nlasvc 2>%USERPROFILE%\temp.txt
net start netman 2>%USERPROFILE%\temp.txt
net start iphlpsvc 2>%USERPROFILE%\temp.txt
net start lanmanworkstation 2>%USERPROFILE%\temp.txt
net start "Bonjour Service" 2>%USERPROFILE%\temp.txt
net start dhcp 2>%USERPROFILE%\temp.txt
net start nsi 2>%USERPROFILE%\temp.txt
net start lanmanserver 2>%USERPROFILE%\temp.txt
net start lmhosts 2>%USERPROFILE%\temp.txt
net start "shared access" 2>%USERPROFILE%\temp.txt
net start nettcpportsharing 2>%USERPROFILE%\temp.txt
net start remoteaccess 2>%USERPROFILE%\temp.txt
net start alg 2>%USERPROFILE%\temp.txt
net start bits 2>%USERPROFILE%\temp.txt
net start peerdistsvc 2>%USERPROFILE%\temp.txt
net start certpropsvc 2>%USERPROFILE%\temp.txt
net start homegrouplistener 2>%USERPROFILE%\temp.txt
net start homegroupprovider 2>%USERPROFILE%\temp.txt
net start winrm 2>%USERPROFILE%\temp.txt
net start Broswer 2>%USERPROFILE%\temp.txt
net start TrkWks 2>%USERPROFILE%\temp.txt


rem Starting other Windows Services...
net start wscsvc 2>%USERPROFILE%\temp.txt
net start DPS 2>%USERPROFILE%\temp.txt
net start CscService 2>%USERPROFILE%\temp.txt
net start WPDBusEnum 2>%USERPROFILE%\temp.txt
net start ProtectedStorage 2>%USERPROFILE%\temp.txt
net start RemoteRegistry 2>%USERPROFILE%\temp.txt
net start seclogon 2>%USERPROFILE%\temp.txt
net start wscsvc 2>%USERPROFILE%\temp.txt
net start osppsvc 2>%USERPROFILE%\temp.txt

rem Starting Blue Tooth Services
net start bthserv 2>%USERPROFILE%\temp.txt

rem Starting Remote Desktop and Remote Assistance Services
net start sessionenv 2>%USERPROFILE%\temp.txt
net start termservice 2>%USERPROFILE%\temp.txt

rem Starting Windows Update Service
net start wuauserv 2>%USERPROFILE%\temp.txt

rem Starting iPod Services
net start "ipod service" 2>%USERPROFILE%\temp.txt
net start "Apple Mobile Device" 2>%USERPROFILE%\temp.txt

rem Starting Stuff that makes your PC look nice...
net start themes 2>%USERPROFILE%\temp.txt
net start sensrsvc 2>%USERPROFILE%\temp.txt
net start AeLookupSvc 2>%USERPROFILE%\temp.txt
net start UxSms 2>%USERPROFILE%\temp.txt

rem Starting Scanner, Camera and other imaging Services...
net start stisvc 2>%USERPROFILE%\temp.txt
net start hpqddsvc 2>%USERPROFILE%\temp.txt
net start hpslpsvc 2>%USERPROFILE%\temp.txt

rem Starting Windows Media Playing Sharing...
net start WMPnetworksvc 2>%USERPROFILE%\temp.txt

rem Starting Tablet Device Support...
net start tabletinputservice 2>%USERPROFILE%\temp.txt

rem Starting Other Windows Services...
net start bdesvc 2>%USERPROFILE%\temp.txt
net start wbengine 2>%USERPROFILE%\temp.txt
net start uiodetect 2>%USERPROFILE%\temp.txt
net start defragsvc 2>%USERPROFILE%\temp.txt
net start axinstsv 2>%USERPROFILE%\temp.txt
net start "w32time" 2>%USERPROFILE%\temp.txt
net start wercplsupport 2>%USERPROFILE%\temp.txt
net start PnkBstrA 2>%USERPROFILE%\temp.txt
net start TeamViewer6 2>%USERPROFILE%\temp.txt
net start HPSLPSVC 2>%USERPROFILE%\temp.txt
net start Wsearch 2>%USERPROFILE%\temp.txt

rem Starting Printer Services
net start spooler 2>%USERPROFILE%\temp.txt

rem Stop RAM Defragmentation
Taskkill /im ramsaverpro.exe 2>%USERPROFILE%\temp.txt

if exist %USERPROFILE%\temp.txt del %USERPROFILE%\temp.txt

ECHO.
ECHO. Your PC has been restored
ECHO.
ECHO.
ECHO. Press 1 if you want to optimize your laptop for a gig
ECHO. Press 2 to quit
ECHO.
ECHO.
Set /p input=What do you want to do?

IF %Input% == 1 GOTO Optimize
IF %Input% == 2 GOTO Quit

:Quit
echo.
ECHO.
ECHO. Thanks for using this! Credits to SmiTTTen - DJ Trancicted - Stashe
ping 123.45.67.89 -n 1 -w 5000 > nul
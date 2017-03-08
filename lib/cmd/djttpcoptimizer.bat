@Echo off
if exist C:\Users\%Username%\DJbatch.txt goto menu
start reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f 
Echo Don't delete this file! The Ultimate Dj Batch file needs it to run fine! >> C:\Users\%Username%\DJbatch.txt
 
 
:menu
ECHO.
ECHO. Welcome to the DJTT PC Optimizer v1.30
ECHO.
ECHO.
ECHO. Press 1 if you want to optimize your laptop for a gig
ECHO. Press 2 if you want to restore everything for normal use
echo. Press 3 if you want to install RAM Saver Pro
ECHO. Press 4 to quit
ECHO.
ECHO.
Set /p input=What do you want to do?
 
 
IF %Input% == 1 GOTO Optimize
IF %Input% == 2 GOTO Restore
IF %Input% == 3 GOTO Install
IF %Input% == 4 Goto Quit 
 
 
:Install
ECHO.
ECHO. If needed, you have to click on download! We will continue soon! 
start http://www65.zippyshare.com/d/30032647/19/ramsaverpro.exe
ping 123.45.67.89 -n 1 -w 30000 > nul
ECHO. 
Echo. The Ram Saver pro installer will be launched now! Install the program as usual!
if not exist "C:\Users\%Username%\Downloads\ramsaverpro.exe" goto error
if exist "C:\Users\%Username%\Downloads\ramsaverpro.exe" start C:\Users\%Username%\Downloads\ramsaverpro.exe
ping 123.45.67.89 -n 1 -w 25000 > nul
ECHO.
ECHO. Ram Saver Pro has been installed
ECHO.
ECHO.
ECHO. Press 1 if you want to optimize your laptop for a gig
ECHO. Press 2 if you want to restore everything for normal use
ECHO. Press 3 to quit
ECHO.
ECHO.
Set /p input=What do you want to do?
 
 
IF %Input% == 1 GOTO Optimize
IF %Input% == 2 GOTO Restore
IF %Input% == 3 Goto Quit 
 
 
:error
Echo.
Echo.
ECHO I can't find the installer of RamSaver Pro, please locate your installer and install the program as usual
pause
goto menu
 
 
 
:Optimize
CLS
ECHO.
ECHO. Optimizing your computer now!
ECHO.
rem Defragmentating your RAM
start "DJ Script" "C:\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe"
 
 
rem Stopping Windows Firewall, Windows Defender and Avast!...
net stop mpssvc /yes
net stop windefend /yes
net stop "avast! Antivirus" /yes
 
 
rem Stopping DHCP Client, Wireless LAN and Bluetooth...
net stop WinHttpAutoProxySvc /yes
net stop dhcp /yes
net stop wlansvc /yes
net stop btwdins /yes
 
 
rem Stopping Other Network Related Services...
net stop "dns cache" /yes
net stop netprofm /yes
net stop nlasvc /yes
net stop netman /yes
net stop iphlpsvc /yes
net stop lanmanworkstation /yes
net stop "Bonjour Service" /yes
net stop dhcp /yes
net stop nsi /yes
net stop lanmanserver /yes
net stop lmhosts /yes
net stop "shared access" /yes
net stop nettcpportsharing /yes
net stop remoteaccess /yes
net stop alg /yes
net stop bits /yes
net stop "peerdists vc" /yes
net stop certpropsvc /yes
net stop homegrouplistener /yes
net stop homegroupprovider /yes
net stop winrm /yes
net stop Broswer /yes
net stop TrkWks /yes
 
 
 
rem Stopping other Windows Services...
net stop wscsvc /yes
net stop DPS /yes
net stop CscService /yes
net stop WPDBusEnum /yes
net stop ProtectedStorage /yes
net stop RemoteRegistry /yes
net stop seclogon /yes
net stop wscsvc /yes
 
 
rem Stopping Blue Tooth Services
net stop bthserv /yes
 
 
rem Stopping Remote Desktop and Remote Assistance Services
net stop sessionenv /yes
net stop termservice /yes
 
 
rem Stopping Windows Update Services
net stop wuauserv /yes
 
 
rem Stopping iPod Services
net stop "ipod service" /yes
net stop "Apple Mobile Device" /yes
 
 
rem Stopping Stuff that makes your PC look nice...
net stop themes /yes
net stop sensrsvc /yes
net stop AeLookupSvc /yes
net stop UxSms /yes
 
 
rem Stopping Scanner, Camera and other imaging Services...
net stop stisvc /yes
net stop hpqddsvc /yes
net stop hpslpsvc /yes
 
 
rem Stopping Windows Media Playing Sharing...
net stop WMPnetworksvc /yes
 
 
rem Stopping Tablet Device Support...
net stop tabletinputservice /yes
 
 
rem Stopping Other Windows Services...
net stop bdesvc /yes
net stop wbengine /yes
net stop uiodetect /yes
net stop defragsvc /yes
net stop axinstsv /yes
net stop "w32time" /yes
net stop wercplsupport /yes
net stop PnkBstrA /yes
net stop TeamViewer6 /yes
net stop HPSLPSVC /yes
net stop Wsearch /yes
net stop NAUpdate /yes
 
 
 
rem Stopping Printer Services
net stop spooler /yes
 
 
rem stopping useless programs
Taskkill /f /im TeamViewer.exe
Taskkill /im firefox.exe
Taskkill /f /im uTorrent.exe
Taskkill /f /im Dropbox.exe
Taskkill /f /im steam.exe
Taskkill /f /im "AAM Updates Notifier.exe"
Taskkill /f /im AvastUI.exe
Taskkill /f /im BTTray.exe
Taskkill /f /im hpqtra08.exe
Taskkill /f /im hpwuschd2.exe 
Taskkill /f /im iexplorer.exe
 
 
rem Stop defragmentating RAM
Taskkill /im ramsaverpro.exe
 
 
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
if exist "C:\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "C:\Program Files\WinTools Software\RAM Saver Professional\ramsaverpro.exe"
if exist "C:\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe" start "DJ Script" "C:\Program Files (x86)\WinTools Software\RAM Saver Professional\ramsaverpro.exe"
 
 
rem Starting Windows Firewall, Windows Defender and Avast!...
net start mpssvc
net start windefend
net start "avast! Antivirus"
 
 
rem Starting DHCP Client, Bluetooth and Wireless LAN...
net start WinHttpAutoProxySvc
net start dhcp
net start wlansvc
net start btwdins
 
 
rem Starting Other Network Related Services...
net start "dns cache"
net start netprofm
net start nlasvc
net start netman
net start iphlpsvc
net start lanmanworkstation
net start "Bonjour Service"
net start dhcp
net start nsi
net start lanmanserver
net start lmhosts
net start "shared access"
net start nettcpportsharing
net start remoteaccess
net start alg
net start bits
net start peerdistsvc
net start certpropsvc
net start homegrouplistener
net start homegroupprovider
net start winrm
net start Broswer
net start TrkWks
 
 
 
rem Starting other Windows Services...
net start wscsvc
net start DPS
net start CscService
net start WPDBusEnum
net start ProtectedStorage
net start RemoteRegistry
net start seclogon
net start wscsvc
net start osppsvc
 
 
rem Starting Blue Tooth Services
net start bthserv
 
 
rem Starting Remote Desktop and Remote Assistance Services
net start sessionenv
net start termservice
 
 
rem Starting Windows Update Service
net start wuauserv
 
 
rem Starting iPod Services
net start "ipod service"
net start "Apple Mobile Device"
 
 
rem Starting Stuff that makes your PC look nice...
net start themes
net start sensrsvc
net start AeLookupSvc
net start UxSms
 
 
rem Starting Scanner, Camera and other imaging Services...
net start stisvc
net start hpqddsvc
net start hpslpsvc
 
 
rem Starting Windows Media Playing Sharing...
net start WMPnetworksvc
 
 
rem Starting Tablet Device Support...
net start tabletinputservice
 
 
rem Starting Other Windows Services...
net start bdesvc
net start wbengine
net start uiodetect
net start defragsvc
net start axinstsv
net start "w32time"
net start wercplsupport
net start PnkBstrA
net start TeamViewer6
net start HPSLPSVC
net start Wsearch
 
 
rem Starting Printer Services
net start spooler
 
 
rem Stop RAM Defragmentation
Taskkill /im ramsaverpro.exe
 
 
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
Echo.
ECHO.
ECHO. Thanks for using this! Credits to SmiTTTen - DJ Trancicted - Stashe
ping 123.45.67.89 -n 1 -w 5000 > nul
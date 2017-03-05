###############################################################################
### Chocolatey                                                                #
###############################################################################

#Write-Host "$promptchar $scriptFileName - Installing Chocolatey..." -foregroundcolor White -backgroundcolor Blue
Write-Host "$promptchar $scriptFileName - Installing Chocolatey..."
if ((which cinst) -eq $null) {
    iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
    Refresh-Environment
    choco feature enable -n=allowGlobalConfirmation
}

#Write-Host "$promptchar $scriptFileName - Showing Chocolatey Packages..." -foregroundcolor White -backgroundcolor Blue
Write-Host "$promptchar $scriptFileName - Showing Chocolatey Packages..."

choco version all

Write-Host "Press any key to continue ..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
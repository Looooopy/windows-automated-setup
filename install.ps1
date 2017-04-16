Try
{
  choco --version
  $chocolateyInstalled=$True
}
catch
{
  $chocolateyInstalled=$False
}

if($chocolateyInstalled)
{
  Write-Host "Update Chocolatey"
  choco upgrade chocolatey
}
else
{
  Write-Host "Install Chocolatey"
  iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
}

# Install BoxStarter
CINST Boxstarter
Import-Module Boxstarter.Chocolatey


# Windows config
./windows-reg/install-reg.ps1
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar -EnableOpenFileExplorerToQuickAccess -EnableShowRecentFilesInQuickAccess -EnableShowFrequentFoldersInQuickAccess -EnableExpandToOpenFolder
Enable-RemoteDesktop
Disable-InternetExplorerESC
Disable-MicrosoftUpdate
Disable-BingSearch

# Web browsers
CINST -y googlechrome
CINST -y firefox
CINST -y postman

# Dev tools
CINST -y git.install
CINST -y cmder
CINST -y Atom
CINST -y docker-for-windows
CINST -y docker-compose
CINST -y selenium-chrome-driver

# Install Postman collections...
# Install Atom plugins...
# Install cmder settings...

# Dev debug tools
CINST -y sysinternals
CINST -y wireshark

# Dev api
CINST -y dotnetcore

# Dev folders
New-Item -path "c:\projects\git" -type directory -force
New-Item -path "c:\projects\visualstudioonline" -type directory -force

#Dev config

# Copy atom proxy that is used from bash on ubuntu on windows to parse filepaths
New-Item ./tools/AtomProxyCmd/bin/1.0.0.1/ -ItemType Directory
$release_version="0.0.1"
$atomProxyCmdVersion="1.0.0.1"
wget "https://github.com/Looooopy/windows-automated-setup/releases/download/$release_version/AtomProxyCmd.exe" -OutFile "./tools/AtomProxyCmd/bin/$atomProxyCmdVersion/AtomProxyCmd.exe"
wget "https://github.com/Looooopy/windows-automated-setup/releases/download/$release_version/CommandLine.dll" -OutFile "./tools/AtomProxyCmd/bin/$atomProxyCmdVersion//CommandLine.dll"
$atompath = Split-Path (Get-Command atom).Path
cp ./tools/AtomProxyCmd/bin/$atomProxyCmdVersion/* $atompath

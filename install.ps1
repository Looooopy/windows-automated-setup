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

CINST Boxstarter
Import-Module Boxstarter.Chocolatey

./windows-reg/install-reg.ps1

# Copy atom proxy that is used from bash on ubuntu on windows to parse filepaths
$atompath = Split-Path (Get-Command atom).Path
cp ./tools/AtomProxyCmd/bin/1.0.0.1/* $atompath

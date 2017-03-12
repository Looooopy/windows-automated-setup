#Requires -RunAsAdministrator

Write-Host "Adding Registry:" -foregroundcolor "DarkCyan"
$major = [environment]::OSVersion.Version.Major
if( $major -eq 10)
{
  .\windows-reg\windows10\add-long-paths.ps1
}
else
{
  Write-Host "Windows Major Version: $major"
}

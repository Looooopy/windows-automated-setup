# use when editing scrupt anmd debugging
# Import-Module -Name ".\..\modules\set-registry.psm1" -Force
Import-Module -Name ".\windows-reg\modules\set-registry.psm1"
$val = "LongPathsEnabled"
Write-Host "  [$val] - Adding support for long filenames in path" -foregroundcolor "green"
Set-Registry -p "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -n $val -v "1" -t "DWORD"

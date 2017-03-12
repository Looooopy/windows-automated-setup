#$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem"
#$regName = "LongPathsEnabled"
#$regValue = "0"
#$regType = "expandstring"
#$default = $null
# Binary	      Binary data
# DWord	        A number that is a valid UInt32
# ExpandString	A string that can contain environment variables that are dynamically expanded
# MultiString   A multiline string
# String        Any string value
# QWord         8 bytes of binary data

function Set-Registry()
{
  [CmdletBinding()]
    param (
        [parameter(Mandatory=$true)]
        [alias("p", "path")]
        [string[]]$regPath,

        [parameter(Mandatory=$true)]
        [alias("n", "name")]
        [string]$regName,

        [parameter(Mandatory=$true)]
        [alias("v", "value")]
        [string]$regValue,

        [parameter(Mandatory=$true)]
        [ValidateSet('DWord','Binary','ExpandString','MultiString','String', 'QWord', ignorecase=$True)]
        [alias("t", "type")]
        [string]$regType,

        [parameter(Mandatory=$false)]
        [alias("ns", "noneSilent")]
        [switch]$regNoneSilent
    )
    PROCESS {
      IF(!(Test-Path $regPath))
      {
        IF($regNoneSilent)
        {
          New-Item -Path $regPath -Value $default -Force
        }
        else
        {
          New-Item -Path $regPath -Value $default -Force | Out-Null
        }
      }

      IF($regNoneSilent)
      {
        New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType $regType -Force        
      }
      else
      {
        New-ItemProperty -Path $regPath -Name $regName -Value $regValue -PropertyType $regType -Force | Out-Null
      }
    }
}

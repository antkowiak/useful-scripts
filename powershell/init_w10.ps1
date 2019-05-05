# Initialize my common preferences on a Windows 10 installation

# Set PowerShell execution policy to be able to make registry changes
Set-ExecutionPolicy RemoteSigned

# Disable startup delay
if (!(Get-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force


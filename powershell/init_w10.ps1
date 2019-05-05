# Initialize my common preferences on a Windows 10 installation

# Set PowerShell execution policy to be able to make registry changes
Set-ExecutionPolicy RemoteSigned

# Disable startup delay
if (!(Get-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize"
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" -Name "StartupDelayInMSec" -Value 0 -Type DWord -Force

# Show "My Computer" on the desktop
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" -Value 0 -Type DWord -Force

# Force Icon View in Control Panel
if (!(Get-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies"
}
if (!(Get-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ForceClassicControlPanel" -Value 1 -Type DWord -Force

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
if (!(Get-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies"
}
if (!(Get-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer"
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "ForceClassicControlPanel" -Value 1 -Type DWord -Force

# Always show file extensions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Value 0 -Type DWord -Force

# Always show all files
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowSuperHidden" -Value 1 -Type DWord -Force

# Alwas show all icons in notification area
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0 -Type DWord -Force

# Remove "People" icon from task bar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name "PeopleBand" -Value 0 -Type DWord -Force

# Disable Ads
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Value 0 -Type DWord -Force

# Disable App Suggestions
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Value 0 -Type DWord -Force
if (!(Get-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent"
}
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord -Force

# Uninstall and disable One Drive
taskkill /f /im OneDrive.exe
if (Test-Path -Path "$Env:SystemRoot\System32\OneDriveSetup.exe" -PathType Leaf)
{
  "$Env:SystemRoot\System32\OneDriveSetup.exe /uninstall"
}
if (Test-Path -Path "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe" -PathType Leaf)
{
  "$Env:SystemRoot\SysWOW64\OneDriveSetup.exe /uninstall"
}
Remove-Item $Env:UserProfile\OneDrive
Remove-Item $Env:LocalAppData\Microsoft\OneDrive
Remove-Item $Env:ProgramData\Microsoft OneDrive
Remove-Item C:\OneDriveTemp
REG Delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
REG Delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f
if (!(Get-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -ErrorAction SilentlyContinue))
{
  New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive"
}
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Value 1 -Type DWord -Force

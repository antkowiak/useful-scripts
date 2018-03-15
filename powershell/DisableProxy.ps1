$reg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"

Set-ItemProperty -Path $reg -Name ProxyEnable -Value 0

try
{
    Remove-ItemProperty -Path $reg -Name ProxyServer
}
catch
{
}

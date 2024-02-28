# confirm current setting (follows are default settings)
Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\w32time\TimeProviders\NtpServer'

# Enable NTP Server feature
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\TimeProviders\NtpServer" -Name "Enabled" -Value 1

# set [AnnounceFlags] to 5
# number means
# 0x00 : Not a time server
# 0x01 : Always time server
# 0x02 : Automatic time server
# 0x04 : Always reliable time server
# 0x08 : Automatic reliable time server
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\services\W32Time\Config" -Name "AnnounceFlags" -Value 5
Restart-Service w32Time

# if Windows Firewall is running, allow NTP port
New-NetFirewallRule `
-Name "NTP Server Port" `
-DisplayName "NTP Server Port" `
-Description 'Allow NTP Server Port' `
-Profile Any `
-Direction Inbound `
-Action Allow `
-Protocol UDP `
-Program Any `
-LocalAddress Any `
-LocalPort 123
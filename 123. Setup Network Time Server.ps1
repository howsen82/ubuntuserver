# -----------------
# Server
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

# -----------------
# Client
# confirm current synchronization NTP Server
> w32tm /query /source

# change target NTP Server (replace to your timezone server)
# number means
# 0x01 : SpecialInterval
# 0x02 : UseAsFallbackOnly
# 0x04 : SymmetricActive
# 0x08 : NTP request in Client mode
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters" -Name "NtpServer" -Value "ntp.nict.jp,0x8"
Restart-Service w32Time

# re-sync manually
w32tm /resync

# verify status
> w32tm /query /status

(Get-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters").GetValue("Type")
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\w32time\Parameters" -Name "Type" -Value "NTP"
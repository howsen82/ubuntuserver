# Display network interfaces
Get-NetIPInterface -AddressFamily IPv4

# change DNS setting to refer to AD DS
Set-DnsClientServerAddress -InterfaceIndex 3 -ServerAddresses "10.0.0.100" -PassThru

> ipconfig /all | Select-String -Pattern "DNS"

# Join in domain
Add-Computer -DomainName 'rebeladmin.com' -Credential (New-Object PSCredential("rebeladmin\Administrator", (ConvertTo-SecureString -AsPlainText "UserP@ssw0rd01" -Force)))
Restart-Computer -Force

# After restarting, verify to logon as a domain user
> whoami
# Get IP Information
Get-NetIPConfiguration
Get-NetIPAddress
Get-NetIPInterface

# Configure IP Address
New-NetIPAddress -InterfaceIndex 4 -IPAddress 10.10.10.12 -PrefixLength 24 -DefaultGateway 10.10.10.1
Set-DNSClientServerAddress -InterfaceIndex 4 -ServerAddresses 10.10.10.10, 10.10.10.11
Get-NetIPConfiguration

# Set PC Name
> hostname
Rename-Computer WEB4
Restart-Computer

# Join domain
Add-Computer

# Remote Powershell Access
Enter-PSSession -ComputerName 'WEB4' -Credential 'administrator'

# Install Active Directory
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-WindowsFeature DNS

# Promote this server to a domain controller
Install-ADDSDomainController -InstallDns -DomainName "contoso.local"
> repadmin /showrepl
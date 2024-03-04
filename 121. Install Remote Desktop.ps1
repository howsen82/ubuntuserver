# Install RDS and other services and tools
Install-WindowsFeature Remote-Desktop-Services,RDS-Web-Access,RDS-RD-Server,RDS-Connection-Broker,RDS-Licensing,RDS-Gateway -IncludeManagementTools
# restart computer to apply changes
Restart-Computer -Force

# Enable PowerShell remote connection
Enable-PSRemoting

# configure ConnectionBroker/WebAccessServer/SessionHostServer
# specify Server's hostname or IP address for each value
# New deployment
# Import module
Import-Module remotedesktop
$singleserverdeployment = "REBEL-SDC01.rebeladmin.com"
$connectionBroker=$singleserverdeployment
$webAccessServer=$singleserverdeployment
$sessionHost=$singleserverdeployment
New-RDSessionDeployment -ConnectionBroker $connectionBroker -WebAccessServer $webAccessServer -SessionHost $sessionHost

# confirm settings
Get-RDServer
Get-ChildItem 'Cert:\LocalMachine\My'

# remove the auto-generated certificate
Remove-Item 'Cert:\LocalMachine\My\DD346A7E2069F7F254B37B953BCB65E8477061A3'
New-SelfSignedCertificate `
-DnsName $singleserverdeployment `
-KeyAlgorithm RSA `
-KeyLength 2048 `
-CertStoreLocation "Cert:\LocalMachine\My" `
-NotAfter (Get-Date).AddYears(10)
Get-ChildItem 'Cert:\LocalMachine\My'
> dir cert:\localmachine\my

# set a new certificate to the IIS for RDWeb site (Default Web Site)
$Cert = Get-ChildItem Cert:\LocalMachine\My\78EC2EFB4BE155649FF153F694AADA882010694C
Import-Module WebAdministration
Get-Website

$Cert | New-Item 0.0.0.0!443 -Value $Cert 
Set-Item IIS:\SslBindings\0.0.0.0!443 -Value $Cert

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
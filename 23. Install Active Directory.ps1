# Run on DC1
# DC1 is initially a stand-alone work group server you convert
# into a DC with DNS.
# You should install DC1 with PowerShell and VSCode

# 1. Installing the AD Domain Services feature and management tools
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# 2. Importing the ADDeployment module
Import-Module -Name ADDSDeployment 

# 3. Examining the commands in the ADDSDeployment module
Get-Command -Module ADDSDeployment

# 4. Creating a secure password for the Administrator
$PasswordHT = @{
    String      = 'Pa$$w0rd'  # Change to more secure password
    AsPlainText = $true
    Force       = $true
}
$SecurePW = ConvertTo-SecureString @PasswordHT

# Make sure Administrator account has password preset before proceeding with the following account

# 5. Testing DC Forest installation starting on DC1
$ForestHT = @{
    DomainName           = 'Reskit.Org'
    InstallDNS           = $true
    NoRebootOnCompletion = $true
    SafeModeAdministratorPassword = $SecurePW
    ForestMode           = 'WinThreshold'
    DomainMode           = 'WinThreshold'
}
Test-ADDSForestInstallation @ForestHT -WarningAction SilentlyContinue

# 6. Creating Forest Root DC on DC1
$NewActiveDirectoryParameterHashTable = @{
    DomainName                    = 'Reskit.Org'
    SafeModeAdministratorPassword = $SecurePW
    InstallDNS                    = $true
    DomainMode                    = 'WinThreshold'
    ForestMode                    = 'WinThreshold'
    Force                         = $true
    NoRebootOnCompletion          = $true
    WarningAction                 = 'SilentlyContinue'
}
Install-ADDSForest @NewActiveDirectoryParameterHashTable

# Or powershell command

Install-ADDSForest -DomainName 'rebeladmin.com' -CreateDnsDelegation:$false -DatabasePath 'C:\Windows\NTDS' -DomainMode '7' -DomainNetbiosName 'REBELADMIN' -ForestMode '7' -InstallDns:$true -LogPath 'C:\Windows\NTDS' -NoRebootOnCompletion:$True -SysvolPath 'C:\Windows\SYSVOL' -Force:$true -SafeModeAdministratorPassword $SecurePW

# 7. Checking key AD and related services
Get-Service -Name DNS, Netlogon
Get-Service -Name ADWS, KDC, NetLogon, DNS

# 8. Checking DNS zones
Get-DnsServerZone

# 8a. Checking Domain Controller
Get-ADDomainController

# 8b. Checking for Domain
Get-ADDomain Reskit.Org

# 9c. Check for Domain Controller shares the SYSVOL folder
Get-SMBShare SYSVOL

# 9. Restarting DC1 to complete promotion
Restart-Computer -Force
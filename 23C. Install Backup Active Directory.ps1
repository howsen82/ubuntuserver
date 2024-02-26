# Installation Checklist
# 1. Prepare the physical/virtual resources for the domain controller
# 2. Install Windows Server 2022 Standard/Datacenter
# 3. Patch the servers with the latest Windows updates
# 4. Assign a dedicated IP address to the domain controller
# 5. Add the domain controller to the existing AD domain as a domain member
# 6. Find information about existing domain sites and the initial replication method
# 7. Log in to the server with a privileged account (such as Schema Admin or Enterprise Admin)
# 8. Install the AD DS role
# 9. Configure the AD DS role
# 10. Review the logs to verify healthy AD DS installation and configuration
# 11. Configure service and performance monitoring
# 12. Configure AD DS backup/DR

# Installation steps
# 1. Log in to the server as a member of the Schema Admin or Enterprise Admin group.
# 2. Here, verify the static IP address allocation by using ipconfig /all
# 3. Launch the PowerShell console as an administrator.

# Join domain
# DNS Server set to primary forest
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools
Install-ADDSDomainController -CreateDnsDelegation:$false -NoGlobalCatalog:$true -InstallDns:$true -DomainName "rebeladmin.com" -SiteName "Default-First-Site-Name" -ReplicationSourceDC "REBEL-SDC01.rebeladmin.com" -DatabasePath "C:\Windows\NTDS" -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$true -SysvolPath "C:\Windows\SYSVOL" -Force:$true

# Or

$PasswordHT = @{
    String      = 'Pa$$w0rd'  # Change to more secure password
    AsPlainText = $true
    Force       = $true
}
$SecurePW = ConvertTo-SecureString @PasswordHT

$BackupActiveDirectoryParameterHashTable = @{
    CreateDnsDelegation           = $false
    NoGlobalCatalog               = $false
    InstallDNS                    = $true
    DomainName                    = 'rebeladmin.com'
    SiteName                      = 'Default-First-Site-Name'
    ReplicationSourceDC           = 'REBEL-SDC01.rebeladmin.com'
    DatabasePath                  = 'C:\Windows\NTDS'
    LogPath                       = 'C:\Windows\NTDS'
    SafeModeAdministratorPassword = $SecurePW
    NoRebootOnCompletion          = $true
    SysvolPath                    = 'C:\Windows\SYSVOL'
    Force                         = $true
}
Install-ADDSDomainController @BackupActiveDirectoryParameterHashTable

# 4. Checking key AD and related services
Get-Service -Name ADWS, KDC, NetLogon, DNS

# 5. The following command will list the domain controllers, along with their IP addresses and the sites they belong to
Get-ADDomainController -Filter * | Format-Table Name, IPv4Address, Site

# 6. The following command will list the global catalog servers that are available
# in the domain and confirm that this new domain controller server isn't a
# global catalog server
Get-ADDomainController -Discover -Service 'GlobalCatalog'

# 7. As per our plan, the next step is to move the infrastructure master role to the
# new additional domain controller
Move-ADDirectoryServerOperationMasterRole -Identity REBEL-SDC-02 -OperationMasterRole InfrastructureMaster
Get-ADDomain | Select-Object InfrastructureMaster

# Active Directory health check
> Repadmin /showrepl
> Repadmin /showrepl REBEL-SDC-03
> Repadmin /replicate REBEL-SDC-03.rebeladmin.com REBEL-PDC-01.rebeladmin.com DC=rebeladmin,DC=com
> Repadmin /replicate REBEL-SDC-03.rebeladmin.com REBEL-PDC-01.rebeladmin.com DC=rebeladmin,DC=com /full
> Repadmin /replsummary
> Repadmin /replsummary /errorsonly
# check if SYSVOL replication uses DFSR by using
> dfsrmig /getmigrationstate

# Health check
# Check what the additional roles installed in the domain controller are
Get-WindowsFeature -ComputerName DC01 | Where-Object Installed
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName
> dcdiag /e
> dcdiag /s:REBEL-SDC-03
> dcdiag /test:replications /s:REBEL-SDC-03
> dcdiag /test:Services
> dcdiag /test:DNS /DNSBasic
> dcdiag /test:DNS /DnsForwarders
> dcdiag /test:DNS /DnsRecordRegistration
# Complete health report
> dcdiag /v /c /e /s:DC01 | Out-File C:\healthreport.txt

# Active Directory migration checklist
• Evaluate the business requirements for AD migration
• Perform an audit on the existing AD infrastructure
• Provide an implementation plan
• Prepare the physical/virtual resources for the domain controller
• Install Windows Server 2022 Standard/Datacenter
• Patch the servers with the latest Windows updates
• Assign a dedicated IP address to the domain controller
• Install the AD DS role
• Migrate the application and server roles from the existing domain controllers
• Migrate the FSMO roles to the new domain controllers
• Add new domain controllers to the existing monitoring system
• Add new domain controllers to the existing DR solution
• Decommission all the old domain controllers
• Raise the domain and forest functional levels
• Perform ongoing maintenance (Group Policy review, new feature implementations, identifying and fixing AD infrastructure issues, and more)
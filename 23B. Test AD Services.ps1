# Windows domain controller installed
Get-ADForest | Format-List Name, ForestMode

# Enable Privileged Access Management (PAM) Features
Enable-ADOptionalFeature 'Privileged Access Management Feature' -Scope ForestOrConfigurationSet -Target Reskit.Org

# Get Domain members
Get-ADGroupMember -Identity 'Domain Admins'

# Add domain user granted for 60 minutes using Domain Admins
Add-ADGroupMember -Identity 'Domain Admins' -Members 'acurtiss' -MemberTimeToLive (New-TimeSpan -Minutes 60)

# Get remaining time left available for Domain Admin
Get-ADGroup 'Domain Admins' -Property member -ShowMemberTimeToLive

# Find domain-level FSMO roles
Get-ADDomain | Select-Object InfrastructureMaster, PDCEmulator, RIDMaster

# Find forest-level FSMO roles
Get-ADForest | Select-Object DomainNamingMaster, SchemaMaster

# Transferring FSMO roles
# Active Directory Users and Computers > Right-click the domain name > Operations Masters > PDC > Change
# Transfer RID Master
Move-ADDirectoryServerOperationMasterRole -Identity "REBEL-SDC02" RIDMaster
# Transfer PDC Emulator
Move-ADDirectoryServerOperationMasterRole -Identity "REBEL-SDC02" PDCEmulator
# Transfer Infrastructure Master
Move-ADDirectoryServerOperationMasterRole -Identity "REBEL-SDC02" InfrastructureMaster
# Transfer Schema Master
Move-ADDirectoryServerOperationMasterRole -Identity "REBEL-SDC02" SchemaMaster
# Transfer Domain Naming Master
Move-ADDirectoryServerOperationMasterRole -Identity "REBEL-SDC02" DomainNamingMaster

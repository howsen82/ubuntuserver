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
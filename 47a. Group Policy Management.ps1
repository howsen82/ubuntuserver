# View GPO Details
Get-GPO -Name "Test Users"

# Check Group Inheritance
Get-GPInheritance -Target 'OU=Users,OU=Europe,DC=rebeladmin,DC=com'

# Block Inheritance
Set-GPInheritance -Target 'OU=Users,OU=Europe,DC=rebeladmin,DC=com' -IsBlocked Yes

# Create New GPO
New-GPO -Name 'GPO-Test-A'
# Create New GP Link
New-GPLink -Name 'GPO-Test-A' -Target 'OU=Users,OU=Europe,DC=rebeladmin,DC=com'
# Or
# New GPO and GP Link
New-GPO -Name 'GPO-Test-B' | New-GPLink -Target 'OU=Users,OU=Europe,DC=rebeladmin,DC=com'

# Disable GP Link
Set-GPLink -Name GPO-Test-B -Target "OU=Users,OU=Europe,DC=rebeladmin,DC=com" -LinkEnabled No

# Remove GP Link
Remove-GPLink -Name GPO-Test-B -Target "OU=Users,OU=Europe,DC=rebeladmin,DC=com"

# Remove GPO
Remove-GPO -Name GPO-Test-A

# Update Group Policy client PC
> gpupdate /force
# show current user list
Get-ADUser -Filter * | Format-Table DistinguishedName

# Add [ADUser01] user
New-ADUser ADUser01 `
-Surname ADUser01 `
-GivenName ADUser01 `
-DisplayName "AD User01" `
-EmailAddress "ADUser01@srv.world" `
-AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd01" -Force) `
-ChangePasswordAtLogon $true `
-Enabled $true

Get-ADUser -Identity ADUser01

# with specify [OU], run like follows
New-ADUser ADUser02 `
-Path "OU=Hiroshima,DC=srv,DC=world" `
-Surname ADUser02 `
-GivenName ADUser02 `
-DisplayName "AD User02" `
-EmailAddress "ADUser02@srv.world" `
-AccountPassword (ConvertTo-SecureString -AsPlainText "P@ssw0rd02" -Force) `
-ChangePasswordAtLogon $true `
-Enabled $true

# Reset password
Set-ADAccountPassword -Identity ADUser02 `
-NewPassword (ConvertTo-SecureString -AsPlainText "UserP@ssw0rd02" -Force) `
-Reset

# Delete a user
Remove-ADUser -Identity "CN=Redstone,CN=Users,DC=srv,DC=world"
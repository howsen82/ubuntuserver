# Install AD FS Role
> dir Cert:\LocalMachine\My
Install-WindowsFeature ADFS-Federation -IncludeManagementTools

# Configure ADFS Role
Import-Module ADFS
$credentials = Get-Credential
Install-AdfsFarm `
-CertificateThumbprint:"DA063314E9D7021424B0DC1985B9FD67E4ACF12B" `
-FederationServiceDisplayName:"REBELADMIN INC" `
-FederationServiceName:"adfs.rebeladmin.com" `
-ServiceAccountCredential $credentials

Get-WinEvent "AD FS/Admin" | Where-Object {$_.ID -eq "100"} | Format-List

# --------------
# Installing WAP
> dir Cert:\LocalMachine\My
# Install Web Application Proxy Feature
Install-WindowsFeature Web-Application-Proxy -IncludeManagementTools

# Configure the proxy
$credentials = Get-Credential
Install-WebApplicationProxy `
-FederationServiceName "adfs.rebeladmin.com" `
-FederationServiceTrustCredential $credentials `
-CertificateThumbprint "DA063314E9D7021424B0DC1985B9FD67E4ACF12B"

Get-WinEvent "AD FS/Admin" | Where-Object {$_.ID -eq "396"} | Format-List

# Add Application to Proxy
Add-WebApplicationProxyApplication -BackendServerUrl 'https://myapp.rebeladmin.com/myapp/' -ExternalCertificateThumbprint '3E0ED21E43BEB1E44AD9C252A92AD5AFB8E5722E' -ExternalUrl 'https://myapp.rebeladmin.com/myapp/' -Name 'MyApp' -ExternalPreAuthentication AD FS -ADFSRelyingPartyName 'myapp.rebeladmin.com'

# -------------
# Integrating with Azure MFA
# Create Cert for Azure MFA configuration
$certbase64 = New-AdfsAzureMfaTenantCertificate -TenantID 05c6f80c-61d9-44df-bd2d-4414a983c1d4

# Login to Microsoft Services to get TenantId
Login-AzureRmAccount

# Connect to Microsoft Services
Connect-MsolService

# Configure Principle Cred
New-MsolServicePrincipalCredential -AppPrincipalId 981f26a1-7f43-403b-a875-f8b09b8cd720 -Type asymmetric -Usage verify -Value $certbase64

# Enable Azure MFA for ADFS 
Set-AdfsAzureMfaTenant -TenantId 05c6f80c-61d9-44df-bd2d-4414a983c1d4 -ClientId 981f26a1-7f43-403b-a875-f8b09b8cd720
# ADCS Role Install with MGMT Tools
Add-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools

# Configure Standalone CA
# CAType
# - StandaloneRootCA, EnterpriseRootCA, EnterpriseSubordinateCA, StandaloneSubordinateCA
Install-AdcsCertificationAuthority -CACommonName "REBELAdmin Root CA" -CAType StandaloneRootCA -CryptoProviderName "RSA#Microsoft Software Key Storage Provider" -HashAlgorithmName SHA256 -KeyLength 2048 -ValidityPeriod Years -ValidityPeriodUnits 20

> certutil.exe -setreg ca\DSConfigDN CN=Configuration,DC=rebeladmin,DC=com

# Install Web Server
Install-WindowsFeature Web-WebServer -IncludeManagementTools

# Create a folder and create a share so that it can be used as the virtual directory
> mkdir C:\CertEnroll
New-smbshare -name CertEnroll C:\CertEnroll -FullAccess SYSTEM,"rebeladmin\Domain Admins" -ChangeAccess "rebeladmin\Cert Publishers"

certutil -setreg CA\CRLPublicationURLs "1:C:\Windows\system32\CertSrv\CertEnroll\%3%8%9.crl \n10:ldap:///CN=%7%8,CN=%2,CN=CDP,CN=Public Key Services,CN=Services,%6%10\n2:http://crt.rebeladmin.com/CertEnroll/%3%8%9.crl"
certutil -setreg CA\CACertPublicationURLs "1:C:\Windows\system32\CertSrv\CertEnroll\%1_%3%4.crt\n2:ldap:///CN=%7,CN=AIA,CN=Public Key Services,CN=Services,%6%11\n2:http://crt.rebeladmin.com/CertEnroll/%1_%3%4.crt"
certutil -setreg ca\ValidityPeriod "Years"
certutil -setreg ca\ValidityPeriodUnits 10
certutil -setreg CA\CRLPeriodUnits 13
certutil -setreg CA\CRLPeriod "Weeks"
certutil -setreg CA\CRLDeltaPeriodUnits 0
certutil -setreg CA\CRLOverlapPeriodUnits 6
certutil -setreg CA\CRLOverlapPeriod "Hours"
Restart-Service certsvc
certutil -crl
certutil -f -dspublish "REBEL-SDC01.rebeladmin.com_REBELAdmin Root CA.crt" RootCA
certutil -f -dspublish "REBELAdmin Root CA.crl"

# Setting up Issuing CA
Add-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools
Add-WindowsFeature ADCS-Web-Enrollment
Install-ADcsCertificationAuthority -CACommonName "REBELAdmin IssuingCA" -CAType EnterpriseSubordinateCA -CryptoProviderName "RSA#Microsoft Software Key Storage Provider" -HashAlgorithmName SHA256 -KeyLength 2048
Install-ADCSWebEnrollment

# Issuing a certificate for the issuing CA
certreq -submit "REBEL-SDC01.rebeladmin.com_REBELAdmin IssuingCA.req"
# Go to Server Manager | Tools | Certification Authority | Pending Requests
certreq -retrieve 2 "C:\REBEL-CA1.rebeladmin.com_REBELAdmin_IssuingCA.crt"
certutil -installcert "C:\REBEL-CA1.rebeladmin.com_REBELAdmin_IssuingCA.crtstart-service certsvc"

# Post-configuration tasks
# CDP locations
certutil -setreg CA\CRLPublicationURLs "1: C:\Windows\system32\CertSrv\CertEnroll\%3%8%9.crl\n2:http://crt.rebeladmin.com/CertEnroll/%3%8%9.crl\n3:ldap:///CN=%7%8,CN=%2,CN=CDP,CN=Public Key Services,CN=Services,%6%10"
# AIA locations
certutil -setreg CA\CACertPublicationURLs "1: C:\Windows\system32\CertSrv\CertEnroll\%1_%3%4.crt\n2:http://crt.rebeladmin.com/CertEnroll/%1_%3%4.crt\n3:ldap:///CN=%7,CN=AIA,CN=Public Key Services,CN=Services,%6%11"
# CA and CRL time limits
certutil -setreg CA\CRLPeriodUnits 7
certutil -setreg CA\CRLPeriod "Days"
certutil -setreg CA\CRLOverlapPeriodUnits 3
certutil -setreg CA\CRLOverlapPeriod "Days"
certutil -setreg CA\CRLDeltaPeriodUnits 0
certutil -setreg ca\ValidityPeriodUnits 3
certutil -setreg ca\ValidityPeriod "Years"
Restart-Service certsvc
certutil -crl

# Backup/Restore Certificate Authority
Backup-CARoleService C:\CertEnroll
Restore-CARoleService C:\CertEnroll -Force
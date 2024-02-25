# Install Active Directory Federation Service (AD FS)
# This cmdlet will install the AD FS role.
Install-WindowsFeature ADFS-Federation

# Install Active Directory Lightweight Directory Services (AD LDS)
# This cmdlet will install AD LDS.
Install-WindowsFeature ADLDS

# Install Active Directory Rights Management Services (AD RMS)
# This cmdlet will install AD RMS. This role has two subfeatures,
# which are AD Rights Management Server and Identity
# Federation Support. If required, these individual roles can be installed using
# Install-WindowsFeature ADRMS, ADRMS-Server, ADRMS-Identity
# or
# Install-WindowsFeature ADRMS -IncludeAllSubFeature.
# It will install all the subfeatures.
Install-WindowsFeature ADRMS, ADRMS-Server, ADRMS-Identity
Install-WindowsFeature ADRMS -IncludeAllSubFeature

# Install Active Directory Certificate Services (AD CS)
# This cmdlet will install AD CS. This role has six subroles, which
# are certification authority (ADCS-Cert-Authority), Certificate
# Enrollment Policy Web Service (ADCS-Enroll-Web-Pol),
# Certificate Enrollment Web Service (ADCS-Enroll-Web-Svc),
# Certification Authority Web Enrollment (ADCS-Web-Enrollment),
# Network Device Enrollment Service (ADCS-Device-Enrollment),
# and Online Responder (ADCS-Online-Cert). These subfeatures can
# be added individually or together.
Install-WindowsFeature AD-Certificate
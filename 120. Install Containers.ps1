# Install Containers
Add-WindowsFeature Containers

# Installing Docker for Windows
Install-Module -Name DockerMsftProvider -Repository PSGallery -Force
Install-Package -Name docker -ProviderName DockerMsftProvider -Force
Restart-Computer
Start-Service docker
Get-Service Docker

> docker pull mcr.microsoft.com/windows/nanoserver:ltsc2022
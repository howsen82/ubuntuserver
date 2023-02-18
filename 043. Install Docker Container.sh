# Install Docker
sudo apt install docker.io
systemctl status docker
systemctl enable --now docker
sudo usermod -aG docker <username> # Add user account to the group

# Search image
docker search ubuntu # Search for ubuntu image from docker hub repositories
docker pull ubuntu # Download the image from docker hub to local image repositories
docker images # See all images in local docker
docker rmi <image-id> # Remove image from local docker image repository
docker run -it ubuntu /bin/bash # Run the ubuntu and execute bash script
docker start <container-id> # Start docker container
docker attach <container-id> # Get back to the bash shell
docker stop <container-id> # Stop docker container
docker run -dit ubuntu /bin/bash # Run the ubuntu and execute bash script with detached mode

# Start container with apache
docker run -dit -p 8080:80 ubuntu /bin/bash
docker attach dfb3e
apt update
apt install apache2
/etc/init.d/apache2 start

# Create new image of the container
docker commit <container-id> ubuntu/apache-server:1.0

# Automatye docker image with Dockerfile
FROM ubuntu
MAINTAINER Jay <jay@somewhat.net>
# Avoid confirmation messages
ARG DEBIAN_FRONTEND=noninteractive
# Update the container's packages
RUN apt update; apt dist-upgrade -y
# Install apache2 and vim
RUN apt install -y apache2 vim-nox
# Start Apache
ENTRYPOINT apache2ctl -D FOREGROUND

# Build image from Dockerfile and start new container
docker build -t learnlinux/apache-server:1.0 .
docker run -dit -p 8080:80 learnlinux/apache-server:1.0

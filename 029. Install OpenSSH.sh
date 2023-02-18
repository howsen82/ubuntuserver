# Install the OpenSSH client utility
sudo apt install openssh-client

# Check the OpenSSH system status
systemctl status ssh

# Install for OpenSSH server
sudo apt install openssh-server

# if the SSH server is not running services, execute
sudo systemctl start ssh
sudo systemctl enable ssh
sudo ss -tunlp | grep ssh

# To connect to server
ssh <ip-address>
ssh username@ip-address # connect with username

# If connect using different port beside 22
ssh -p 2242 fmulder@192.168.1.120

# Exit from SSH
exit
# Or Ctrl + d

# Using SSH key management, after key creation will locate public/private key in /home/<username>/.ssh
ssh-keygen
# After key creation, id_rsa will be private key

# To copy public key over remote target server, it will save to the target server with the .ssh folder with filename of authorized_keys file
ssh-copy-id -i ~/.ssh/id_rsa.pub 192.168.1.150

# To see ssh-agent process ID running in the background
eval $(ssh-agent)
# Allow us add SSH key to our running ssh-agent
ssh-add ~/.ssh/id_rsa

# To change passphase of an OpenSSH key
ssh-keygen -p

# To simplify SSH connections with config file
nano /home/your_username/.ssh/config
# Entries example
host myserver
  Hostname 192.168.1.23
  Port 22
  User jdoe

Host nagios
  Hostname nagios.mynetwork.org
  Port 2222
  User nagiosuser

# Usage:
ssh nagios
ssh -p 2222 nagiosuser@nagios.mynetwork.org
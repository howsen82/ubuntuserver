# Connect to Custom OpenSSH Server
ssh -p 65123 steven@192.168.41.128

# Scp usage
scp -p 65123 myfile myserver:/path/to/dir

# Add SSH users to groups
sudo groupadd sshusers
sudo usermod -aG sshusers myuser

# Under /etc/ssh/sshd_config
# Which allow groups of users allow to use OpenSSH
Port 65332
Protocol 2
AllowUsers larry moe curly
AllowGroups admins sshusers gremlins
PermitRootLogin no
PasswordAuthentication no

sudo systemctl restart ssh
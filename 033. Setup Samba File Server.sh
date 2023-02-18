# Install Samba File Sharing
sudo apt install samba

# Samba server will start automatically, then stop it to do configuration for /etc/samba/smb.conf
sudo systemctl stop smbd
sudo mv /etc/samba/smb.conf /etc/samba/smb.conf.orig # Rename file for backup

# Create new file /etc/samba/smb.conf
[global]
server string = File Server
workgroup = WORKGROUP
security = user
map to guest = Bad User
name resolve order = host bcast wins
include = /etc/samba/smbshared.conf

# Create new file /etc/samba/smbshared.conf
[Documents]
path = /share/documents
force user = jdoe
force group = users
public = yes
writable = no

[Public]
path = /share/public
force user = jdoe
force group = users
create mask = 0664
force create mode = 0664
directory mask = 0777
force directory mode = 0777
public = yes
writable = yes

# It will create a shared name of //servername/Documents and //servername/Public
# Public share with read/write attribute
# Document with read-only

sudo mkdir /share
sudo mkdir /share/documents
sudo mkdir /share/public

# Make sure 'jdoe' user with user group of 'users' exists
sudo chown -R jdoe:users /share

sudo systemctl start smbd
sudo systemctl status smbd

# In ubuntu client, access share folder
sudo apt install smbclient
sudo apt install cifs-utils

# If file manager didn't show the shares, create entry in /etc/fstab
# Assuming the local directory exists for '/mnt/documents'
# noauto indicate won't mount Samba share at boot time
//myserver/share/documents /mnt/documents cifs username=myuser,noauto 0 0
sudo mount /mnt/documents

# mount the Samba share without adding an fstab entry
sudo mount -t cifs //myserver/Documents -o username=myuser /mnt/documents
# Add new user
sudo useradd -d /home/jdoe -m jdoe
sudo passwd jdoe

# Alternative way
sudo adduser dscully

# Removing user
sudo userdel dscully
ls -l /home

sudo mkdir -p /store/file_archive
sudo userdel -r dscully
sudo rm -r /home/dscully

# Password file
cat /etc/passwd #User name
sudo cat /etc/shadow #Hashed Password

# Search for specific user
sudo cat /etc/passwd | grep root

# Show the password status was last changed
# Status
# L = Locked
# P = Password set and usable
# NP = No password was being set
sudo passwd -S <username>

# Check for manual for command
man ls
man passwd
man shadow

# View current user profile
ls -la /etc/skel
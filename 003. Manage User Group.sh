# View all user groups
cat /etc/group

# Add new group
sudo groupadd admins

# Delete user group
sudo groupdel admins

# Assign a user associate with the group
# -a Ammend
# -G modify secondary group membership
sudo usermod -aG admins myuser

# Change user primary group
sudo usermod -g <group-name> <username>

# Change user home directory path, moving home directory as well and change account
sudo usermod -d /home/jsmith jdoe -m
sudo usermod -l jsmith jdoe

# Assign a user to a group
sudo gpasswd -a <username> <group>

# Remove a user from a group
sudo gpasswd -d <username> <group-to-remove>
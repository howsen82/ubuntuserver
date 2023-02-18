# Assign user allow to use sudo
sudo usermod -aG sudo <username>

# View the sudoers
sudo cat /etc/sudoers
# eg. Allow 'charlie'  user to reboot and shutdown, but unable to install package
charlie   ALL=(ALL:ALL) /sbin/reboot /sbin/shutdown
charlie   ubuntu=(ALL:ALL) /usr/bin/apt # Allow to use apt update, apt dist-upgrade
charlie   ubuntu= /usr/bin/apt # Prevent charlie from using -u option to run commands as other users
charlie   ubuntu=(dscully:admins) ALL # Allow charlie to run command on behalf of dscully in group 'admins'.
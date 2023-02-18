# View storage by human readable form in MB
df -h
df -i

# Find out which directory is using most space
sudo ncdu -x /home

# Show top 15 largest directories in current working directory
du -cksh * | sort -hr | head -n 15

# Filesystem checker
sudo touch /forcefsck # Reboot server to perform filesystem check
sudo touch /home/forcefsck

# See how much data is being written to or read from disks (I/O)
sudo iotop
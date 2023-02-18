# View disk usage in human readable form
df -h

# View disk usage in bits
df -i

# Install NCurses Disk Usage package
sudo apt install ncdu
ncdu

# Monitor memory usage
free
free -m # Show memory in megabytes

# Turn on memory swap
sudo swapon -a

# Turn off memory swap
sudo swapoff -a

# Assign swap file with 4G predefined sizes
sudo fallocate -l 4G /swapfile
sudo chmod 0600 /swapfile
sudo mkswap /swapfile
sudo swapon -a
free -m # Check swap file size
cat /proc/sys/vm/swappiness # Check for current swap memory usage percentage
sudo sysctl vm.swappiness=30 # Change the percentage of RAM to trigger using swap file

# Or (Edit configuration to trigger it)
/etc/sysctl.conf
vm.swappines=30 # default is 60

# Show load average performance
cat /proc/loadavg

#View resource usage with htop
sudo apt install -y htop
htop
htop -d 70 # Update every 7 seconds
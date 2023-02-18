# Manage LXD container
sudo snap install lxd
sudo usermod -aG lxd <username>
lxd init
# Lanuch Ubuntu with LXD
lxc launch ubuntu:22.04 mycontainer

# List the containers
lxc list

# Start a container
lxc start <container>
# Stop a container
lxc stop <container>
# Remove a container
lxc delete <container>
# List the downloaded images
lxc image list
# Remove an image
lxc image delete <image_name>

# Open a shell inside LXD container in root mode
lxc exec mycontainer bash

# Login to container using username
lxc exec mycontainer -- su --login ubuntu
# Press Ctrl + d to logout

# Auto start LXD container when boot up
lxc config set mycontainer boot.autostart 1

sudo apt update && sudo apt install apache2
# get current LXD container IP
ip addr show
curl <container-ip>

# Create a profile
lxc profile create external
lxc profile edit external

description: External access profile
devices:
  eth0:
  name: eth0
  nictype: bridged
  parent: br0
  type: nic

# Launch ubuntu with network interface created profile name (external)
lxc launch ubuntu:22.04 mynewcontainer -p default -p external

# Append profile to existing running container
lxc profile add mycontainer external
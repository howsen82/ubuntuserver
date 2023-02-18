# See the no of cpu support for virtualization
egrep -c '(vmx|svm)' /proc/cpuinfo

# Setup virtual machine server
sudo apt install bridge-utils libvirt-clients libvirt-daemon-system qemu-system-x86

# Verify running status
systemctl status libvirtd

# Stop service, perform other configuration
sudo systemctl stop libvirtd
sudo groupadd kvm # Add new group if not exists in /etc/group
sudo groupadd libvirt
sudo usermod -aG kvm jay # Add user to the required group
sudo usermod -aG libvirt jay

# Ensure user of the 'kvm' group have access /var/lib/libvirt/images
sudo chown :kvm /var/lib/libvirt/images
sudo chmod g+rw /var/lib/libvirt/images # Set permission

# Start the service
sudo systemctl start libvirtd
sudo systemctl status libvirtd

# Install virtualization manager on client machine
sudo apt install ssh-askpass virt-manager
# Then run Virtual Machine Manager

# Steps
# Click close when virtual machine manager prompt errors
# 1. Click on File -> Add Connection
# 2. Hypervisor: QEMU/KVM
# 3. Select "Connect to remote host over SSH"
# 4. Username: jay
# 5. Hostname: 192.168.41.128
# 6. Select "Autoconnect" if required
# 7. Click "Connect"
# 8. Prompt for fingerprint access, type 'yes' and OK
# 9. Type password for jay
# 10. Then new connection was added successfully
# 11. After that, right click newly added connection, select 'Properties' from the menu
# 12. Click on 'Storage' tab
# 13. Click on 'Add Pool' button located at left bottom corner
# 14. Set 'Name' to ISO, 'Target Path' to /var/lib/libvirt/images/ISO
# 15. Click Finish
# 16. In the 'Name' field, change name from pool to ISO

# Update permission for directory owned by proper user, and members of the kvm group will have read write access to it.
sudo chown root:kvm /var/lib/libvirt/images/ISO
sudo chmod g+rw /var/lib/libvirt/images/ISO

# After done, you can create new virtual machine

# Server
# Configure the network to bridge mode, which obtains IP from local DHCP
sudo nano /etc/netplan/00-installer-config.yaml

# Change from
network:
  ethernets:
    ens33:
      addresses: [192.168.41.128/24]
      routes:
      - to: default
        via: 192.168.41.2
      nameservers:
        addresses: [192.168.41.2]
  version: 2

# To

network:
  ethernets:
    ens33:
      dhcp4: false    
    bridges:
      br0:
        interfaces: [ens33]
        dhcp4: true
        parameters:
          stp: false
          forward-delay: 0
  version: 2

sudo netplan apply

# To see the virtual machine lists
virsh list
virsh start vm-name
virsh shutdown vm-name
virsh suspend vm-name
virsh resume vm-name
virsh destroy vm-name
virsh undefine vm-name
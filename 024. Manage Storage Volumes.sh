# List all disks
sudo fdisk -l

# After added/attached disk, run
dmesg --follow

# Show disk volume info
lsblk

# Create a partition
sudo fdisk /dev/sdb
g # m - MBR g - GPT
sudo mkds.ext4 /dev/sdb1 # Format partition using ext4 filesystem
sudo mkds.ext4 /dev/sdb1 # Format partition using XFS filesystem
sudo mkdir /mnt/vol1 # Mount volume path
sudo mount /dev/sdb1 /mnt/vol1 # Mount
sudo mount /dev/sdb1 -t ext4 /mnt/vol1 # Mount with disk of ext4
sudo umount /mnt/vol1 # Unmount the volume

# See all volumes
cat /etc/fstab
# List all volumes UUID
blkid

# Adding volume to /etc/fstab
blkid /dev/sdb1

# Tell system to automatically mount that volume whenever system boots
sudo mount -a

sudo mount /mnt/ext_disk

# Check for storage LVM package
apt search lvm2 | grep installed
sudo apt install -y lvm2 # Installed when storage LVM was not found

#e.g.
sudo pvcreate /dev/sdb
sudo pvcreate /dev/sdc
sudo pvcreate /dev/sdd
sudo pvcreate /dev/sde

# Create column group
sudo vgcreate vg-test /dev/sdb

# Check storage LVM2 information
sudo vgdisplay

# Create a logical volume of 5GB from the virtual disk
sudo lvcreate -n myvol1 -L 5g vg-test
sudo lvdisplay

# List all partitions
sudo fdisk -l

# Create a partition
sudo fdisk /dev/sdb

# Format a partition with EXT4
sudo mkfs.ext4 /dev/sdb1

# Format a partition using XFS
sudo mkfs.xfs /dev/sdb1

# Mount a partition
sudo mkdir /mnt/vol1
sudo mount /dev/sdb1 /mnt/vol1
sudo mount /dev/sdb1 -t ext4 /mnt/vol1 # Mount to EXT4 format
sudo umount /mnt/vol1

# Install crypt package
sudo apt install cryptsetup

# Use cryptsetup to format disk
sudo cryptsetup luksFormat /dev/sdb

# Create one encrypted disk
sudo cryptsetup luksFormat /dev/sdb backup_drive
# Format to ext4 filesystem and attached to /dev/mapper/backup_drive
sudo mkfs.ext4 -L "backup_drive" /dev/mapper/backup_drive
# Mount the disk
# Mount the encrypted disk located at /dev/mapper/backup_drive
sudo mount /dev/mapper/backup_drive /media/backup_drive

# Unmount the drive device
sudo umount /media/backup_drive
sudo cryptsetup luksClose /dev/mapper/backup_drive

# Mount the volume
sudo cryptsetup luksOpen /dev/sdb backup_drive
sudo mount /dev/mapper/backup_drive /media/backup_drive

# Change the passphase
sudo cryptsetup luksChangeKey /dev/sdb -S 0
# Transfer file recursively
sudo rsync -r /home/myuser /backup

# Transfer file with original attribute permissions
sudo rsync -a /home/myuser /backup

# Transfer file with verbose mode
sudo rsync -av /home/myuser /backup

# Transfer file over SSH
sudo rsync -av /home/myuser admin@192.168.1.5:/backup

# Transfer file to copy and match both side have the same file included files being remove from source directory
sudo rsync -av --delete /src /target

# -a archive
# -l symbolic link
# -p preserve permissions
# -g preserve group ownership
# -o preserve the owner
# -D preserve device files
# -a = -rlptgoD

# Transfer file
# This one is particularly useful. Normally, when a file is updated on /src and then copied over to
# /target, the copy on /target is overwritten with the new version. If files exists on target, file
# being copied will be rename on target
sudo rsync -avb --delete /src /target

# Backup with incremental backup
sudo rsync -avb --delete --backup-dir=/backup/incremental /src /target
# e.g
CURDATE=$(date +%m-%d-%Y)
sudo rsync -avb --delete --backup-dir=/backup/incremental/$CURDATE /src /target
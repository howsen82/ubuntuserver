# Sample
# -a: archive
# -v: verbose output
# -b: backup mode
rsync -avb --delete --backup-dir=/backup/incremental/08-17-2022 /src /target

#/bin/bash
curdate=$(date +%m-%d-%Y)
if [ ! -f /usr/bin/rsync ]; then
    sudo apt install -y rsync
fi
rsync -avb --delete --backup-dir=/backup/incremental/$curdate /src /target

# Execute bash script
chmod +x backup.sh
sudo mv backup.sh /usr/local/bin
# Install NFS Share, which start automatically
# and create a default /etc/exports
sudo apt install nfs-kernel-server

# Create a directory as example
sudo mkdir /exports

# Example folder structure, create the directory
/exports/backup
/exports/documents
/exports/public

# In the /etc/exports file (which we’re creating fresh), I’ll insert the following four lines
/exports *(ro,fsid=0,no_subtree_check)
/exports/backup 192.168.1.0/255.255.255.0(rw,no_subtree_check)
/exports/documents 192.168.1.0/255.255.255.0(ro,no_subtree_check)
/exports/public 192.168.1.0/255.255.255.0(rw,no_subtree_check)

# Configure mapping
# configure this, open /etc/idmapd.conf
# Domain = localdomain
# Uncomment it, set Domain = local.lan where DNS name is configure for
# After all has been configure, restart it to make changes
sudo systemctl restart nfs-kernel-server
sudo exportfs -a

# Client access (Debian-based)
sudo apt install nfs-common
sudo mount myserver:/documents /mnt/documents
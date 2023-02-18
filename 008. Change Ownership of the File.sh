# Change ownership recursively for file
sudo chown sue myfile.txt

# Change ownership recursively for folders
sudo chown -R sue mydir

# Change ownership recursively to a group
sudo chown sue:sales myfile.txt

# Change ownership to group
sudo chgrp sales myfile.txt
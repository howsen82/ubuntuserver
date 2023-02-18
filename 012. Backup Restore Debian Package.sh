# Export list of installed package to a file
dpkg --get-selections > packages.list

# Import packge list
tmux install

sudo apt install dselect
sudo dselect update
sudo dpkg --set-selections < packages.list
sudo apt-get dselect-upgrade
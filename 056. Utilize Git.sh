# Install Git
sudo apt install git

sudo mkdir /git
sudo chown jay:jay /git

# Setup and create /git directory on your Apache server and cd into that directory
# Create local git repository
git init --bare apache2
# Clone your repository
git clone 192.168.1.101:/git/apache2

# Backup apache web server
sudo cp -rp /etc/apache2 /etc/apache2.bak
sudo mv /etc/apache2/* /git/apache2 # Move all content into /etc/apache2 into repository
sudo rm /etc/apache2 # Remove directory
sudo find /git/apache2 -name '.?*' -prune -o -exec chown root:root {} + # Change .git ownership of the files to root instead of users
sudo ln -s /git/apache2 /etc/apache2 # Create a symbolic link to Git repository
ls -l /etc | grep apache2 # Verify symbolic link
sudo systemctl reload apache2

git add .
git commit -am "My first commit"
git push origin master

# Restore a repository onto another server
git clone 192.168.1.101:/git/apache2

git commit -a -m "Updated config files."
git push origin master

# Install package to browse all git commits
sudo apt install tig

# Restore from a git
git checkout <commit-hash>
git checkout main
git revert --no-commit <commit-hash>

git commit -a -m "The previous commit broke the application. Reverting."git
push origin master
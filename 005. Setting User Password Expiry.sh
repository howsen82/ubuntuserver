# View password expiration information
sudo chage -l <username>

# Force user account for password change when first login
sudo chage -d 0 <username>

# Change user password change expiration days and require
# password change in 90 days
sudo chage -M 90 <username>

# Enforce password policy
sudo apt install libpam-cracklib
sudo nano /etc/pam.d/common-password
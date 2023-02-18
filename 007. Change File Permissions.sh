# Remove read access to the file
chmod o-r budget.txt
chmod o-r /home/sue/budget.txt

# Add read/write to user column
chmod u+rw <filename>
chmod g+r <filename> # The owning group is given read access
chmod o-rw <filename> # Other is stripped of the read write

Read: 4
Write: 2
Execute: 1

#e.g
# 600 User has read and write
# Output: -rw-------
chmod 600 filename.txt
#
# 740 User has read, write, and execute. Group has read. Other has no access
# Output: -rwxr-----
chmod 740 filename.txt
#
# 770 Both User and Group has read, write, and execute. Other has no access
# Output: -rwxrwx---
chmod 770 filename.txt
#
# 777 Everyone has access anthing
# Output: -rwxrwxrwx
chmod 777 filename.txt

# Change the access rights in folder with recursive file changes
chmod 770 -R mydir
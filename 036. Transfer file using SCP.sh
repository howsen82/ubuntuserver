# Copy file to jdoe
scp myfile.txt jdoe@192.168.1.50:/home/jdoe
scp myfile.txt jdoe@192.168.1.50: #same command

# Copy from remote to current directory
scp jdoe@192.168.1.50:myfile.txt .

# Do recursive copy from local /home/jdoe/downloads/linux_iso to remote machine 192.168.1.50
scp -r /home/jdoe/downloads/linux_iso jdoe@192.168.1.50:downloads

scp -r /home/jdoe/downloads/linux_iso jdoe@192.168.1.50:/home/jdoe/downloads

# If SSH using different port, copy
scp -P 2222 -r /home/jdoe/downloads/linux_iso jdoe@192.168.1.50:downloads

# Copy in verbose mode
scp -rv /home/jdoe/downloads/linux_iso jdoe@192.168.1.50:downloads
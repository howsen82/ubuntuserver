# Make a copy of the file
cp file1 file2

# Copy system log store in working directory
sudo cp /var/log/syslog /home/<username>/syslog
sudo cp /var/log/syslog .

# Copy directory recusrively
sudo cp -r /var/log/apt .

# Move files
mv file1 file2

# Write to output stream
cat /var/log/syslog > ~/logfile.txt

# Hard link
ln file1 file3

# Execute script
chmod +x ~/myscript.sh
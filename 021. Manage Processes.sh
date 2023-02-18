# Get process for nano editor
ps au | grep nano

# Install htop process package
sudo apt install htop
htop & # Show how many processes was running

# Show the process run on my own
ps

# Get running process ID
pidof vim

# Get all process list
ps au
ps aux # With no limit

# Query Nginx process
ps aux | grep nginx
ps u -C nginx
ps aux --sort=-pcpu # Sort by the most CPU usage

# Show top 5 processes
ps aux --sort=-pcpu | head -n 5 # Sort by percentage of CPU utilization
ps aux --sort=-pmem | head -n 5 # Sort by amount of memory

# Show processes list
ps -l

# Change process priority to 10
renice -n 10 -p <process-id> # NI change to 10, PRI to 90

# Change proces priority example
nice -n 10 vim
sudo nice -n -10 vim
renice -n 10 42467
sudo renice -n -10 42467

# Killing a process
sudo kill <process-id>

# Killing all proces
sudo killall myprocess
sudo killall -9 myprocess

# Get SSH system control process
systemctl | grep ssh
systemctl status ssh
systemctl status -l ssh

sudo systemctl stop ssh
sudo systemctl start ssh
sudo systemctl enable ssh
sudo systemctl disable ssh

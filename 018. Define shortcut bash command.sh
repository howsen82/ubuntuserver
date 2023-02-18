# Create a shortcut of alias
alias install="sudo apt install"
alias i='sudo apt install'

# View the top 10 most-CPU-consuming processes
alias cpu10='ps -L aux | sort -nr -k 3 | head -10'

# View the top 10 most-RAM-consuming processes
alias mem10='ps -L aux | sort -nr -k 4 | head -10'

# View all mounted filesystems, and present the information in a clean tabbed layout
alias lsmount='mount | column -t'

# Clear the screen by simply typing c
alias c=clear
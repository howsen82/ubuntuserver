# List all scheduling tasks available
crontab -l

# List crontab tasks for 'jdoe'
sudo crontab -u jdoe -l

# Create new crontab for current user
crontab -e

# m h dom mon dow command
# m = Minute
# h = Hour
# dow = Day
3 0 * * 4 /usr/local/bin/cleanup.sh
* 0 * * * /usr/bin/apt update
0 1 1 * * /usr/local/bin/run_report.sh
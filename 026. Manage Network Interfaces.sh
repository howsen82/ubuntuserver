# Show IP Addresses
ip addr show
ip a # same command

# Bring down a network interface
sudo ip link set eth0 down
sudo ip link set wlan0 down

# Bring up a network interface
sudo ip link set eth0 up
sudo ip link set wlan0 up

# if using net-tools utility, bring network interface down/up
sudo ifconfig eth0 down
sudo ifconfig eth0 up
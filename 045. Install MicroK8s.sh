# Pre-requisite
# Check snap package management install or not
which snap

# If not
sudo dnf install snapd

# Install MicroK8s (Linux)
sudo snap install microk8s --classic

# Install MicroK8s (macOS)
# Go to https://brew.sh, install brew package manager
brew install ubuntu/microk8s/microk8s

# Install MicroK8s (Windows)
# Go to https://microk8s.io

# Check the status for MicroK8s
sudo microk8s kubectl get all --all-namespaces

# Enable MicroK8s DNS
sudo microk8s enable dns

# To omit need of sudo command, you can do it as
sudo usermod -aG microk8s <username>

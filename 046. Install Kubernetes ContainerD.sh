# Master Node - Control Plane 192.168.41.130
# Worker Node - Control Plane 192.168.41.131

# Initial
sudo apt update
sudo apt install curl gnupg2 software-properties-common apt-transport-https ca-certificates -y

# Cluster machine (Master and Worker Node)
# Install containerd
sudo mkdir -p /etc/apt/keyrings
sudo apt install containerd
systemctl status containerd

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install containerd.io -y

# Setup configuration
sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo nano /etc/containerd/config.toml
# Lookup line [plugins."io.containerd.grpc.v1.cri".containerd.runtimes.runc.options]
# Under SystemdCgroup = false
# Set it to
# SystemdCgroup = true
sudo systemctl restart containerd
sudo systemctl enable containerd

# Disable swap
sudo swapoff -a # Disable swap
free -m # See the status for swap is 0
sudo nano /etc/fstab
# Comment out /swap.img     none    swap    sw  0

sudo nano /etc/sysctl.conf
# Lookup #net.ipv4.ip_forward=1
# Uncomment it
# net.ipv4.ip_forward=1

# Install kubernetes
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubeadm kubelet kubectl kubernetes-cni

# Other settings files
sudo modprobe br_netfilter
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sudo nano /etc/sysctl.conf
# Uncomment net.ipv4.ip forward=1, then save it
sudo sysctl -w net.ipv4.ip_forward=1

# Initial Master Node (Control Plane)
sudo kubeadm config images pull
sudo kubeadm init --pod-network-cidr=10.244.0.0/16
# sudo kubeadm init --control-plane-endpoint=172.16.250.216 --node-name controller --pod-network-cidr=10.244.0.0/16

# Save config
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/v0.21.1/Documentation/kube-flannel.yml
# Or kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
# Check running status
kubectl get pods --all-namespaces
kubectl get nodes
kubectl get --raw='/readyz?verbose' # Check status health

# Join Worker Node (Worker Node - Pods)
sudo kubeadm join 192.168.41.130:6443 --token a0vmmz.o0o09bb2opke381n --discovery-token-ca-cert-hash sha256:f0570209bd5a17031cb6a9fe45706a02f320dfac9933b4df5368c5f0afc0ee8f
# Or get from master node for join link
kubeadm token create --print-join-command
# To see generated token
kubeadm token list
# Get discovery-token-ca-cert-hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

# Go master node, to verify worker node has been added to the control plane (master)
kubectl get nodes
# Label the worker node
# e.g. kubectl label node <node-name> node-role.kubernetes.io/worker=worker
kubectl label node node node-role.kubernetes.io/worker=worker

# Bring worker node (Off from Control Plane) - Master node
kubectl drain node --delete-emptydir-data --force --ignore-daemonsets # Status change to [Ready,SchedulingDisabled]
kubectl get nodes # Check Status
kubectl uncordon # Bring back to Status = Ready
# -- Worker Node Session
sudo kubeadm reset
sudo su -
iptables -F && iptables -t nat -F && iptables -t mangle -F && iptables -X
exit
# -- Master Node (Control Plane)
kubectl delete node <node>
kubectl delete node node

# Check Metrics API Availability
kubectl top nodes

# Install Metrics API Server
kubectl apply -f https://raw.githubusercontent.com/techiescamp/kubeadm-scripts/main/manifests/metrics-server.yaml

# Display statistic
kubectl top nodes

# View Pods CPU and Memory usage
kubectl top pod -n kube-system

https://thenewstack.io/how-to-deploy-kubernetes-with-kubeadm-and-containerd/
https://devopscube.com/setup-kubernetes-cluster-kubeadm/
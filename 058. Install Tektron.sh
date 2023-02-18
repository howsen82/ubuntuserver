# Install Tektron Pipeline
# https://github.com/tektoncd/pipeline
kubectl apply --filename https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
# Or
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/previous/v0.44.0/release.yaml

# Install Tektron Triggers
# kubectl apply --filename \
# https://github.com/tektoncd/triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
# Or
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/previous/v0.22.1/release.yaml
kubectl apply -f https://storage.googleapis.com/tekton-releases/triggers/previous/v0.22.1/interceptors.yaml

# Install Tektron Dashboard
# https://github.com/tektoncd/dashboard
kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/latest/release.yaml
# Or
kubectl apply -f https://storage.googleapis.com/tekton-releases/dashboard/previous/v0.32.0/release.yaml

# Install Tektron CLI
sudo apt update;sudo apt install -y gnupg
sudo mkdir -p /etc/apt/keyrings/
sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/tektoncd.gpg --keyserver keyserver.ubuntu.com --recv-keys 3EFE0E0A2F2F60AA
echo "deb [signed-by=/etc/apt/keyrings/tektoncd.gpg] http://ppa.launchpad.net/tektoncd/cli/ubuntu eoan main"|sudo tee /etc/apt/sources.list.d/tektoncd-ubuntu-cli.list
sudo apt update && sudo apt install -y tektoncd-cli

# Install Tektron CLI
# Go to https://github.com/tektoncd/cli/releases
curl -LO https://github.com/tektoncd/cli/releases/download/v0.29.1/tektoncd-cli-0.29.1_Linux-64bit.deb
sudo dpkg -i ./tektoncd-cli-0.29.1_Linux-64bit.deb

# helloworld-task.yaml
kubectl create -f helloworld-task.yaml
# Output: task.tekton.dev/hello created

kubectl get tasks
# Output
# NAME    AGE
# hello   8s

# List all tasks
tkn taskrun ls

# See the log file
tkn taskrun logs build-app-run-65vmh -f
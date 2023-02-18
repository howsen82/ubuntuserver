# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Go to IAM, Users. Then click on User Name, Go to Security Credential
# Create access key when it was not available
# Key in Access Id and Access Key into environment variable
export AWS_ACCESS_KEY_ID="AKIAVNXBZU2OBNWQQ7ET"
export AWS_SECRET_ACCESS_KEY="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"

# Initialize terraform to ensure required components it needs to interact with AWS
terraform init
# Not make any changes but instead check for syntax, if no mistakes or syntax error,
# output will be as follow
# Plan: 1 to add, 0 to change, 0 to destroy.
terraform plan

# Apply changes if no mistaken
# If it was completed, it shows
# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
terraform apply

# Perform a destroy and remove infrastructure from EC2 instance
terraform destroy
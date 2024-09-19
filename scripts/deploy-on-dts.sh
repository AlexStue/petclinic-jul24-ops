#!/bin/bash
# This script deploys the application on the remote server

# Enable error handling: the script will exit on any command failure
set -e

# Step 1: Install Terraform on the remote server
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
sudo apt-get update
sudo apt-get install -y terraform

# Step 2: Clone the repository containing the Terraform code
git clone https://github.com/AlexStue/petclinic-jul24-ops.git

# Step 3: Navigate to the Terraform directory and deploy infrastructure
cd /home/ubuntu/petclinic-jul24-ops/terraform
terraform init
terraform plan
terraform apply -auto-approve

# After this, your application should be up and running on the server.
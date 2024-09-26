#!/bin/bash
# This script deploys the application on the remote server

# Enable error handling: the script will exit on any command failure
set -e

# Function to handle apt-get lock
handle_lock() {
  local lock_file=$1
  local retries=10
  local wait_time=10  # in seconds

  while [ $retries -gt 0 ]; do # errors vefore ?!
    if sudo lsof $lock_file; then
      echo "Lock file $lock_file is held by another process. Retrying in $wait_time seconds..."
      sleep $wait_time
      retries=$((retries - 1))
    else
      return 0 # errors before?!
    fi
  done

  echo "Failed to acquire lock after multiple retries. Exiting."
  exit 1
}

# Step 1: Install Terraform on the remote server
echo "Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
echo "Adding HashiCorp repository..."
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"

# Handle apt-get lock
handle_lock "/var/lib/dpkg/lock-frontend"

echo "Updating package lists..."
sudo apt-get update
echo "Installing Terraform..."
sudo apt-get install -y terraform

# Step 2: Clone the repository containing the Terraform code
REPO_URL="https://github.com/AlexStue/petclinic-jul24-ops.git"
DIR_NAME="petclinic-jul24-ops"

if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Pulling the latest changes..."
  cd "$DIR_NAME" || exit
  git pull origin main
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  git clone "$REPO_URL"
fi

# Step 3: Navigate to the Terraform directory and deploy infrastructure
cd /home/ubuntu/petclinic-jul24-ops/terraform
echo "Initializing Terraform..."
terraform init
echo "Planning Terraform deployment..."
terraform plan
echo "Applying Terraform deployment..."
terraform apply -auto-approve

echo "Deployment completed successfully."
repositories
#!/bin/bash
# This script deploys the application on the remote server

# Enable error handling: the script will exit on any command failure
set -e

# Function to handle apt-get lock
handle_lock() {
  local lock_file=$1
  local retries=10
  local wait_time=10  # in seconds

  while [ $retries -gt 0 ]; do
    if sudo lsof $lock_file &> /dev/null; then
      echo "Lock file $lock_file is held by another process. Retrying in $wait_time seconds..."
      sleep $wait_time
      retries=$((retries - 1))
    else
      return 0 # No lock detected
    fi
  done

  echo "Failed to acquire lock after multiple retries. Exiting."
  exit 1
}

# Step 1: Install Terraform on the remote server
echo "Adding HashiCorp GPG key..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
echo "Adding HashiCorp repository..."
sudo apt-add-repository -y "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"

# Handle apt-get lock
handle_lock "/var/lib/dpkg/lock-frontend"

echo "Updating package lists..."
sudo apt-get update -qq # The -qq flag suppresses output (quiet mode)
echo "Installing Terraform..."
sudo apt-get install -y terraform

# Step 2: Clone the repository containing the Terraform code
REPO_URL="https://github.com/AlexStue/petclinic-jul24-ops.git"
DIR_NAME="petclinic-jul24-ops"

# Clone or pull the latest changes from the repository
if [ -d "$DIR_NAME" ]; then
  echo "Directory $DIR_NAME already exists. Checking for updates..."
  cd "$DIR_NAME" || exit
  # Fetch the latest changes without merging and discard them
  git fetch origin main
  # Reset to the latest version on the remote, discarding local changes
  git reset --hard origin/main
else
  echo "Directory $DIR_NAME does not exist. Cloning the repository..."
  git clone "$REPO_URL"
  cd "$DIR_NAME" || exit
fi

# Step 3: Navigate to the Terraform directory and deploy infrastructure
cd terraform || { echo "Terraform directory not found."; exit 1; }

echo "Initializing Terraform..."
terraform init

# Plan and apply changes while handling potential state lock issues
{
  echo "Planning Terraform deployment..."
  terraform plan

  echo "Applying Terraform deployment..."
  terraform apply -auto-approve
} || {
  echo "Encountered an error during the Terraform operation, possibly due to state lock."
  echo "Consider unlocking the state or waiting for other operations to finish."
  exit 1
}

echo "Deployment completed successfully."

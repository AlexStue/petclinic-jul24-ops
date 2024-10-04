#!/bin/bash
# set -x # command for debugging
# set -e # Exit on any error

echo "Provisioning local Ubuntu machine"
sudo apt-get update
sudo apt-get install -y curl apt-transport-https

echo "Installing Minikube"
# Download and install Minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

echo "Starting Minikube"
minikube start --driver=virtualbox

echo "Configuring kubectl"
# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/latest.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/

# Update kubectl context to point to Minikube
kubectl config use-context minikube

echo "Installing NGINX Ingress Controller"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

echo "Minikube setup is complete!"

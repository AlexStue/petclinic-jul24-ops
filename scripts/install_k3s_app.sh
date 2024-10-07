#!/bin/bash
set -x # command for debugging
set -e # Exit on any error
 
echo "Provisioning local Ubuntu machine"
sudo apt-get update
sudo apt-get install -y curl
 
echo "Installing K3s"
# Uncomment the following line when using NGINX as ingress
# curl -sfL https://get.k3s.io | sh -s - --disable-network-policy --disable-edit-support --disable-cloud-controller --disable-traefik

# Default installation (with Traefik as ingress)
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644

echo "Configuring kubectl"
mkdir -p ~/.kube

if [ -f /etc/rancher/k3s/k3s.yaml ]; then
  sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
  sudo chown $USER:$USER ~/.kube/config
  sudo chmod 644 ~/.kube/config
else
  echo "Error: K3s configuration file not found. Installation may have failed."
  exit 1
fi

# Comment out below when using Traefik
# echo "Installing NGINX Ingress Controller"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml

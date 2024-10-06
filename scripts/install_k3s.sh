 #!/bin/bash
 set -x # command for debugging
 set -e # Exit on any error
 
 echo "Provisioning local Ubuntu machine"
 sudo apt-get update
 sudo apt-get install -y curl
 
 echo "Installing K3s"
 # use this when using traefik as ingress
 curl -sfL https://get.k3s.io
# use following when using nginx as ingress!!! 
# curl -sfL https://get.k3s.io | sh -s - --disable-network-policy --disable-edit-support --disable-cloud-controller --disable-traefik
 
 echo "Configuring kubectl"
 mkdir -p ~/.kube
 sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
 sudo chown $USER:$USER ~/.kube/config
 sudo chmod 644 ~/.kube/config
 


# should be deleted whe choosing to use TRAEFIK
# echo "Installing NGINX Ingress Controller"
# kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
# 
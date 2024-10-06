#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/petclinic-combined.yml
sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/nginx-combined.yml
# sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/ingress-traefik.yml
# sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/dashboard-ingress.yml
# sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/tls-secret.yml
#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/petclinic-combined.yml
sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/nginx-combined.yml
sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/ingress-nginx.yml
# sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/dashboard-ingress.yml
# sudo kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/tls-secret.yml
#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/petclinic-combined.yml
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/nginx-combined.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/ingress-traefik.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/dashboard-ingress.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/tls-secret.yml
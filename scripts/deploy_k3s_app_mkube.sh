#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s_mkube/petclinic-combined.yml
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s_mkube/nginx-combined.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s_mkube/dashboard-ingress.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s_mkube/letsencrypt-clusterissuer.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s_mkube/cert.yml
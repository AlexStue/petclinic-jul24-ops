#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/petclinic-combined.yml
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/nginx-combined.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/dashboard-ingress.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/letsencrypt-clusterissuer.yml
# kubectl apply -f /home/ubuntu/petclinic-jul24-ops/minikube/cert.yml
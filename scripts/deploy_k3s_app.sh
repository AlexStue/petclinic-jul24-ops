#!/bin/bash
set -e # Exit on any error

echo "Applying Kubernetes deployment"
kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/petclinic-combined.yml

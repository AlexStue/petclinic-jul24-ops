provider "local" {}

resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Provisioning local Ubuntu machine"
      sudo apt-get update
      sudo apt-get install -y curl
      curl -sfL https://get.k3s.io | sh -
      mkdir -p ~/.kube
      sudo cp /etc/rancher/k3s/k3s.yaml ~/.kube/config
      sudo chown $USER:$USER ~/.kube/config
      sudo chmod 644 ~/.kube/config
      sudo chmod 644 /etc/rancher/k3s/k3s.yaml
    EOT
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {
    command = <<-EOT
      echo "Applying Kubernetes deployment"
      kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/namespace-default/petclinic-combined.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/namespace-default/ingress-traefik.yml
      kubectl apply -f /home/ubuntu/petclinic-jul24-ops/k3s/namespace-default/tls-secret.yml
    EOT
  }

  depends_on = [null_resource.k3s_setup]
}

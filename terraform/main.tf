resource "null_resource" "install_k3s" {
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = var.server_ip
      user        = var.ssh_user
      private_key = file(var.ssh_private_key)
    }

    inline = [
      # Update and install necessary dependencies
      "sudo apt-get update -y",
      "sudo apt-get install -y curl",

      # Install K3s (with local etcd database)
      "curl -sfL https://get.k3s.io | sh -"
    ]
  }
}

resource "kubectl_manifest" "nginx_deployment" {
  yaml_body = file("/home/ubuntu/k3s/nginx-combined.yml")
}


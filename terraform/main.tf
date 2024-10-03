provider "local" {}

resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    command = "bash ~/petclinic-jul24-ops/scripts/install_k3s.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {
    command = "bash ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  depends_on = [null_resource.k3s_setup]
}

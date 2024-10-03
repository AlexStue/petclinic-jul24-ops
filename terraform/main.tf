provider "local" {}

resource "null_resource" "make_scripts_executable" {
  provisioner "local-exec" {
    command = "chmod +x ~/petclinic-jul24-ops/scripts/install_k3s.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "make_app_script_executable" {
  provisioner "local-exec" {
    command = "chmod +x ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    command = "bash ~/petclinic-jul24-ops/scripts/install_k3s.sh"
  }

  depends_on = [null_resource.make_scripts_executable]

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {
    command = "bash ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  depends_on = [null_resource.make_app_script_executable, null_resource.k3s_setup]
}

provider "local" {}

resource "null_resource" "make_scripts_executable" {
  provisioner "local-exec" {
    command = "chmod +x ~/petclinic-jul24-ops/scripts/install_k3s_app.sh"
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "make_app_script_executable" {
  provisioner "local-exec" {
    command = "chmod +x ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  triggers = {
    always_run = timestamp()
  }
}
resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    command = <<EOT
      sudo chmod 644 /etc/rancher/k3s/k3s.yaml
      bash ~/petclinic-jul24-ops/scripts/install_k3s_app.sh
    EOT
  }

  depends_on = [null_resource.make_scripts_executable]

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {

    command = "bash ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  depends_on = [null_resource.make_app_script_executable, null_resource.k3s_setup]
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = <<EOT
      for i in {1..10}; do
        if ! fuser /var/lib/dpkg/lock-frontend; then
          bash ~/petclinic-jul24-ops/scripts/deploy-on-dts.sh
          exit 0
        else
          echo "Lock held, waiting..."
          sleep 10
        fi
      done
      echo "Failed to acquire lock after retries."
      exit 1
    EOT
  }
  triggers = {
    always_run = timestamp()
  }

  depends_on = [null_resource.apply_k3s_deployment]
}

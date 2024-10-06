provider "local" {}

resource "null_resource" "make_scripts_executable" {
  provisioner "local-exec" {
    # command = "chmod +x ~/petclinic-jul24-ops/scripts/install_minikube.sh"
    command = "chmod +x ~/petclinic-jul24-ops/scripts/install_k3s.sh"
  }

  triggers = {
    always_run = timestamp()
  }
}

resource "null_resource" "make_app_script_executable" {
  provisioner "local-exec" {
    # command = "chmod +x ~/petclinic-jul24-ops/scripts/deploy_minikube_app.sh"
    command = "chmod +x ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
  }

  triggers = {
    always_run = timestamp()
  }
}

# resource "null_resource" "minikube_setup" {
resource "null_resource" "k3s_setup" {
  provisioner "local-exec" {
    # command = "bash ~/petclinic-jul24-ops/scripts/install_minikube.sh"
    command = "bash ~/petclinic-jul24-ops/scripts/install_k3s.sh"
  }

  depends_on = [null_resource.make_scripts_executable]

  triggers = {
    always_run = timestamp()
  }
}

# resource "null_resource" "apply_minikube_deployment" {
resource "null_resource" "apply_k3s_deployment" {
  provisioner "local-exec" {
    # command = "bash ~/petclinic-jul24-ops/scripts/deploy_k3s_app.sh"
    command = "bash ~/petclinic-jul24-ops/scripts/deploy_minikube_app.sh"
  }

  # depends_on = [null_resource.make_app_script_executable, null_resource.minikube_setup]
  depends_on = [null_resource.make_app_script_executable, null_resource.k3s_setup]
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "bash ~/petclinic-jul24-ops/scripts/deploy-on-dts.sh"  # Replace with the actual path to your_script.sh
  }
  
  # optionally use triggers if you want to force rerun
  triggers = {
    always_run = timestamp()
  }

  # Specify dependencies if the script needs to run after previous resources
  # depends_on = [null_resource.apply_minikube_deployment]
  depends_on = [null_resource.apply_k3s_deployment]
}

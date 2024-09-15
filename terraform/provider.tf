provider "local" {}

provider "null" {}

provider "template" {}

provider "kubectl" {
  host                   = "https://${var.server_ip}:6443"
  client_certificate     = file("/etc/rancher/k3s/k3s.yaml")
  client_key             = file("/etc/rancher/k3s/k3s.yaml")
  cluster_ca_certificate = file("/etc/rancher/k3s/k3s.yaml")
  load_config_file       = false
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["config", "view", "--raw"]
    command     = "kubectl"
  }
}
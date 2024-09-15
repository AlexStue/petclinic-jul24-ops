variable "server_ip" {
  description = "Public IP of the Ubuntu server where K3s will be installed."
  default     = 54.78.36.93
}

variable "ssh_user" {
  description = "SSH username to access the server."
  type        = string
  default     = "ubuntu"
}

variable "ssh_private_key" {
  description = "SSH private key for authenticating."
  type        = string
  default     = "./path/to/id_rsa"
}

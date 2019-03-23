variable "gzip" {
  description = "gzip the cloud-init config"
  default = "true"
}

variable "base64_encode" {
  description = "base64 encode the cloud-init config"
  default = "true"
}

variable "efs_filesystem_id" {
  description = "the efs filesystem id. (required when install_efs is enabled)"
  default  = ""
}

variable "efs_mount_path" {
  description = "the efs filesystem id. (required when install_efs is enabled)"
  default = ""
}

variable "extra_user_data" {
  description = "append an extra userdata shell script to cloud-init"
  default = ""
}

variable "install_docker" {
  description = "install docker"
  default = "1"
}

variable "install_docker_compose" {
  description = "install docker compose"
  default = "1"
}

variable "install_docker_version" {
  description = "the docker version to install"
  default = "18.06.3"
}

variable "install_ansible" {
  description = "instal ansible"
  default = "0"
}

variable "install_efs" {
  description = "install efs"
  default = "0"
}

variable "install_rancher_server" {
  description = "install single node rancher server"
  default = "0"
}

variable "install_rancher_version" {
  description = "the rancher server version"
  default = "stable"
}

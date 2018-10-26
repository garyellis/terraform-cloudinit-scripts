variable "efs_filesystem_id" {
  description = "the efs filesystem id. (required when install_efs is enabled)"
  default  = ""
}

variable "efs_mount_path" {
  description = "the efs filesystem id. (required when install_efs is enabled)"
  default = ""
}

variable "install_efs" {
  description = "install efs?"
  default = "0"
}

variable "install_rancher_server" {
  description = "install single node rancher server?"
  default = "0"
}

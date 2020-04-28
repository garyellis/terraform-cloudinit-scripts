variable "gzip" {
  description = "gzip the cloud-init config"
  type        = bool
  default     = false
}

variable "base64_encode" {
  description = "base64 encode the cloud-init config"
  type        = bool
  default     = false
}

variable "extra_user_data_script" {
  description = "append an extra userdata shell script to cloud-init"
  type        = string
  default     = ""
}

variable "extra_user_data_yaml" {
  description = "add cloud-config userdata configuration"
  type        = string
  default     = ""
}

variable "install_ansible" {
  description = "instal ansible"
  type        = bool
  default     = false
}

variable "install_docker" {
  description = "install docker"
  type        = bool
  default     = false
}

variable "install_docker_compose" {
  description = "install docker compose"
  type        = bool
  default     = false
}

variable "docker_compose_version" {
  description = "the docker compose version"
  type        = string
  default     = "1.24.1"
}

variable "docker_version" {
  description = "the docker version to install"
  type        = string
  default     = "19.03.8"
}

variable "docker_yum_repo_url" {
  description = "override the docker yum repo url as needed"
  type        = string
  default     = "https://download.docker.com/linux/centos/7/$basearch/stable"
}

variable "docker_yum_repo_gpgkey_url" {
  description = "override the docker yum repo gpg key as needed"
  type        = string
  default     = "https://download.docker.com/linux/centos/gpg"
}

variable "install_http_proxy_env" {
  description = "Setup http proxy environment"
  type        = bool
  default     = false
}

variable "http_proxy" {
  description = "the http proxy"
  type        = string
  default     = ""
}

variable "https_proxy" {
  description = "the https proxy"
  type        = string
  default     = ""
}

variable "no_proxy" {
  description = "the no proxy list"
  type        = string
  default     = ""
}

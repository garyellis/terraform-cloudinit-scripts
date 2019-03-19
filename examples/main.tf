module "userdata_docker" {
  source = "../"

  base64_encode  = "false"
  gzip            = "false"
  install_docker  = "1"
}



module "userdata_docker_and_docker_compose" {
  source = "../"

  base64_encode          = "false"
  gzip                   = "false"
  install_docker         = "1"
  install_docker_compose = "1" # install docker compose does not currently implicitly enable install_docker
}

module "userdata_ansible" {
  source = "../"

  base64_encode   = "false"
  gzip            = "false"
  install_docker  = "0"
  install_ansible = "1"
}


module "userdata_docker_and_ansible_and_rancher" {
  source = "../"

  base64_encode          = "false"
  gzip                   = "false"
  install_docker         = "1"
  install_ansible        = "1"
  install_rancher_server = "1"
}






output "userdata_docker" { 
  value = "${module.userdata_docker.cloudinit_userdata}"
}

output "userdata_docker_and_docker_compose" {
  value = "${module.userdata_docker_and_docker_compose.cloudinit_userdata}"
}

output "userdata_ansible" {
  value = "${module.userdata_ansible.cloudinit_userdata}"
}

output "userdata_docker_and_ansible_and_rancher" {
  value = "${module.userdata_docker_and_ansible_and_rancher.cloudinit_userdata}"
}

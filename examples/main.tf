locals {
  custom_user_data_yaml = <<EOT
#cloud-config
runcmd:
  - echo "hello foo bar shell script"
EOT

  custom_user_data_script = <<EOT
#!/bin/bash
echo "hello foo bar shell script part"

EOT
}

module "userdata_docker" {
  source = "../"

  base64_encode          = false
  gzip                   = false
  install_docker         = true
  install_docker_compose = true
  extra_user_data_script = local.custom_user_data_script
  extra_user_data_yaml   = local.custom_user_data_script

}



output "userdata_docker" {
  value = module.userdata_docker.cloudinit_userdata
}

output "cloudinit_shellscripts" {
  value = module.userdata_docker.cloudinit_shellscripts
}

output "cloudinit_yamls" {
  value = module.userdata_docker.cloudinit_yamls
}


# setup the cloud-init yaml
locals {
  extra_user_data_yaml    = var.extra_user_data_yaml
  cloud_init_yamls        = compact(list(local.extra_user_data_yaml))
}

# setup the cloud-init shell scripts
locals {
  docker = !var.install_docker ? "" : templatefile("${path.module}/templates/docker.sh.tmpl", {
      docker_version         = var.docker_version,
      install_docker_compose = var.install_docker_compose,
      docker_compose_version = var.docker_compose_version
  })
  extra_user_data_script   = var.extra_user_data_script
  cloud_init_shellscripts = compact(list(local.docker, local.extra_user_data_script))
}

data "template_cloudinit_config" "config" {
  gzip          = var.gzip
  base64_encode = var.base64_encode

  dynamic "part" {
    iterator = part
    for_each = local.cloud_init_yamls
    content {
      content_type = "text/cloud-config"
      content = part.value
    }
  }

  dynamic "part" {
      iterator = part
      for_each = local.cloud_init_shellscripts
      content {
          content_type = "text/x-shellscript"
          content = part.value
      }
  }
}

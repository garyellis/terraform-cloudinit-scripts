output "cloudinit_yamls" {
  value = local.cloud_init_yamls
}

output "cloudinit_shellscripts" {
  value = local.cloud_init_shellscripts
}

output "cloudinit_userdata" {
  value = data.template_cloudinit_config.config.rendered
}


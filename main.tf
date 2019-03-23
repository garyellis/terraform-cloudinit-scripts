data "template_file" "noop" {
  template = "${file("${path.module}/templates/noop.sh.tpl")}"
}


data "template_file" "efs" {
#  count = "${var.install_efs ? 1 : 0}"

  template = "${file("${path.module}/templates/efs.sh.tpl")}"
  vars {
    efs_filesystem_id = "${var.efs_filesystem_id}"
    efs_mount_path = "${var.efs_mount_path}"
  }
}

data "template_file" "docker" {
  template = "${file("${path.module}/templates/docker.sh.tpl")}"
  vars {
    install_docker_version = "${var.install_docker_version}"
    install_docker_compose = "${var.install_docker_compose}"
  }
}

data "template_file" "ansible" {
  template = "${file("${path.module}/templates/ansible.sh")}"
  vars {}
}


data "template_file" "rancher_server" {
  template = "${file("${path.module}/templates/rancher_single_node.sh.tpl")}"
  vars {
    install_rancher_version = "${var.install_rancher_version}"
  }
}

data "template_file" "extra_user_data" {
  template = <<EOF
#!/bin/bash

${var.extra_user_data}
  EOF
}


data "template_cloudinit_config" "config" {
  gzip          = "${var.gzip}"
  base64_encode = "${var.base64_encode}"

  # install and configure efs
  part {
    content_type = "text/x-shellscript"
    content      = "${var.install_efs ? data.template_file.efs.rendered : data.template_file.noop.rendered}"
  }

  # install docker
  part {
    content_type = "text/x-shellscript"
    content      = "${var.install_docker ? data.template_file.docker.rendered : data.template_file.noop.rendered}"
  }

  # install ansible
  part {
    content_type = "text/x-shellscript"
    content      = "${var.install_ansible ? data.template_file.ansible.rendered : data.template_file.noop.rendered}"
  }

  # install rancher server
  part {
    content_type = "text/x-shellscript"
    content      = "${var.install_rancher_server ? data.template_file.rancher_server.rendered : data.template_file.noop.rendered}"
  }

  # extra user_defined userdata
  part {
    content_type = "text/x-shellscript"
    content      = "${var.extra_user_data != "" ? data.template_file.extra_user_data.rendered : data.template_file.noop.rendered}"
  }
}

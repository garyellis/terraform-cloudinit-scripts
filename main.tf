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
    docker_version = "17.03.1"
  }
}


data "template_file" "rancher_server" {
  template = "${file("${path.module}/templates/rancher_server.sh.tpl")}"
}


data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  # install and configure efs
  part {
    content_type = "text/x-shellscript"
    content      = "${var.install_efs ? data.template_file.efs.rendered : data.template_file.noop.rendered}"
  }

  # install docker
  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.docker.rendered}"
  }

  # install rancher server
  part {
    content_type = "text/x-shellscript"
		content      = "${var.install_rancher_server ? data.template_file.rancher_server.rendered : data.template_file.noop.rendered}"
  }
}

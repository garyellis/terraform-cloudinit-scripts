# tf_module_cloud_init

Centrally manage cloud-init scripts. This module supports the following usages:

* Create multi-part cloud-init configs
* Toggle switch to  control which shell scripts are used.
* Use the cloud-init config output as input to `aws_instance`, `aws_launch_template` and `aws_launch_configuration` resources.

## Why centralize cloud-init scripting?

* Loose coupling infrastructure resources to "user_data" scripts promotes terraform modules reusability and extensibility.
* Centrally managing bootstrap scripts aids in genericising the bootstrap process. Bootstrapping different CM tools should be a trivial task.
* A collection of cloud-init scripts can be used as light weight os configuration management strategy.

#### Note

> When adding scripts, do not embed secrets configuration into cloud-init. In cloud environments like AWS, aws any user with ec2 describe instances can view this in the ec2 instance userdata instance attribute.
> Instead, pass configuration to drive secrets configuration. i.e. url to fetch a secret.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| base64\_encode | base64 encode the cloud-init config | string | `"true"` | no |
| efs\_filesystem\_id | the efs filesystem id. (required when install_efs is enabled) | string | `""` | no |
| efs\_mount\_path | the efs filesystem id. (required when install_efs is enabled) | string | `""` | no |
| gzip | gzip the cloud-init config | string | `"true"` | no |
| install\_ansible | instal ansible | string | `"0"` | no |
| install\_docker | install docker | string | `"1"` | no |
| install\_docker\_compose | install docker compose | string | `"1"` | no |
| install\_docker\_version | the docker version to install | string | `"18.06.3"` | no |
| install\_efs | install efs | string | `"0"` | no |
| install\_rancher\_server | install single node rancher server? | string | `"0"` | no |
| install\_rancher\_version | the rancher server version | string | `"stable"` | no |

## Outputs

| Name | Description |
|------|-------------|
| cloudinit\_userdata |  |


## Usage

```
module "userdata" {
  source = "github.com/garyellis/tf_module_cloud_init"

  efs_filesystem_id      = ""
  efs_mount_path         = ""
  install_efs            = "0"
  install_docker         = "1"
  install_docker_compose = "1"
  install_ansible        = "0"
  install_rancher        = "0"
}

module "worker_node" {
  source = "github.com/garyellis/tf_module_aws_instance"

  count_instances             = "1"
  ami_name                    = "ami-12345"
  associate_public_ip_address = "false"
  instance_type               = "t2.nano"
  iam_instance_profile        = ""
  key_name                    = "my-key"
  name                        = "my-instance"
  security_group_attachments  = ["sg-123456", "sg-654321"]
  source_dest_check           = "false"
  subnet_ids                  = ["subnet-123456"]

  tags = {
    environment_stage = "dev"

    environment_name = "my-env"
  }

  user_data_base64 = "${module.userdata.cloudinit_userdata}"
}
```

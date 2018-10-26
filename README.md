# tf_module_cloud_init
Centrally manage cloud-init scripts to stop hard coding scriptlets into otherwise generic terraform hcl. This module supports the following usages:

* toggle on/off various shell scripts
* optionally create multi-part cloud-init gzip+base64 encoded scripts
* Use cloud-init output as input to aws_instance or launch_configuration user_data_base64 parameter

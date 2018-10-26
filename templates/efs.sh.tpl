#!/bin/bash


function install_efs_utils(){
    efs_utils_repo=https://github.com/aws/efs-utils
    local tmpdir=/tmp/$(basename $efs_utils_repo)
    apt-get update && \
    apt-get install -y \
        binutils \
        nfs-common \
        stunnel4

    # clone efs-utils repo, build and install package
    rm -fr $tmpdir; git clone $efs_utils_repo $tmpdir && \
    (cd $tmpdir && ./build-deb.sh && \
     apt-get install -y ./build/amazon-efs-utils-1.4-1.deb)
}


# install the aws efs utils
install_efs_utils

# mount the efs nfs
mkdir -p ${efs_mount_path}

echo "${efs_filesystem_id}:/ ${efs_mount_path} efs tls,_netdev" >> /etc/fstab
mount -a -t efs defaults

# mount -t efs ${efs_filesystem_id}:/ ${efs_mount_path}

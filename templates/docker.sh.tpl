#!/bin/bash

# A very basic docker binary install that can be expanded upon

DOCKER_VERSION=${docker_version}

function install_docker_ubuntu(){

    # install depepdencies
    apt-get update && \
        apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository -y -u \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"

    apt-get install -y docker-ce=$DOCKER_VERSION
}

function install_docker_centos(){
    yum -y install \
        yum-utils \
        device-mapper-persistent-data \
        lvm2


    cat > /etc/yum.repos.d/docker-ce.repo <<-'EOF'
	[docker-ce-stable]
	name=Docker CE Stable - $basearch
	baseurl=https://download.docker.com/linux/centos/7/$basearch/stable
	enabled=1
	gpgcheck=1
	gpgkey=https://download.docker.com/linux/centos/gpg
	EOF


    docker_version=$(yum list docker-ce --showduplicates|grep $DOCKER_VERSION|sort -r|tail -1|awk '{print $2}')

    yum install -y \
        --setopt=obsoletes=0 \
        docker-ce-$docker_version

    systemctl enable docker && systemctl start docker
}

type docker >/dev/null || install_docker_centos

#!/bin/bash -x

DOCKER_DNS=192.168.0.1
#DOCKER_DNS=127.0.0.1

WEBMIN_PASSWORD=password

DNS_IP=`ip route get 1|awk '{print$NF;exit;}'`

#   --publish=${DNS_IP}:53:53/udp --publish=${DNS_IP}:10000:10000 \

#imageTag=sameersbn/bind
imageTag=openkbs/docker-bind

## -- if CentOS or RedHat, to work with SeLinux,
## -- you need to run these two commands

BIND_HOST_VOLUME=$HOME/data-docker/docker-bind
mkdir -p ${BIND_HOST_VOLUME}
#BIND_HOST_VOLUME=/srv/docker/bind
#sudo mkdir -p ${BIND_HOST_VOLUME}
#sudo chmod -R 0777 ${BIND_HOST_VOLUME}

OS_VER=`which yum`
if [ "$OS_VER" == "" ]; then
    # Ubuntu
    sudo apt-get install jq curl git -y
else
    # CentOS/RHEL
    sudo yum install jq curl git -y
    chcon -Rt svirt_sandbox_file_t ${BIN_HOST_VOLUME}
fi

docker run -d --name=$(basename $imageTag) --dns=${DOCKER_DNS} \
  --publish=53:53/udp --publish=10000:10000 \
  --volume=${BIND_HOST_VOLUME}:/data \
  --env='ROOT_PASSWORD=${WEBMIN_PASSWORD}' \
  ${imageTag}:latest

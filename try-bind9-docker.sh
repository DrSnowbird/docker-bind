#!/bin/bash -x

UPPER_DNS=192.168.0.1
LOCAL_DNS=127.0.0.1
DNS_IP=`ip route get 1|awk '{print$NF;exit;}'`

#   --publish=${DNS_IP}:53:53/udp --publish=${DNS_IP}:10000:10000 \


## -- if CentOS or RedHat, to work with SeLinux,
## -- you need to run these two commands

mkdir -p /srv/docker/bind
chcon -Rt svirt_sandbox_file_t /srv/docker/bind

docker run -d --name=bind --dns=${UPPER_DNS} \
  --publish=53:53/udp --publish=10000:10000 \
  --volume=/srv/docker/bind:/data \
  --env='ROOT_PASSWORD=password123' \
  sameersbn/bind:latest

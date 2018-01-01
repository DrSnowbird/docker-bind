#!/bin/bash -x

UPPER_DNS=127.0.0.1
DNS_IP=`ip route get 1|awk '{print$NF;exit;}'`

docker run -d --name=bind --dns=${DNS_IP} \
  --publish=${DNS_IP}:53:53/udp --publish=${DNS_IP}:10000:10000 \
  --volume=/srv/docker/bind:/data \
  --env='ROOT_PASSWORD=password123' \
  sameersbn/bind:latest

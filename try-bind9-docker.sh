#!/bin/bash -x

DNS_IP=192.168.0.11

docker run -d --name=bind --dns=127.0.0.1 \
  --publish=${DNS_IP}:53:53/udp --publish=${DNS_IP}:10000:10000 \
  --volume=/srv/docker/bind:/data \
  --env='ROOT_PASSWORD=password123' \
  sameersbn/bind:latest

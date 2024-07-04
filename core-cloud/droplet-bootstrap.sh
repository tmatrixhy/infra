#!/bin/bash
echo 'Hello, World!' > /root/hello.txt
export DEBIAN_FRONTEND=noninteractive
apt-get update
sleep 15
apt-get upgrade -y

#!/bin/bash
echo 'Hello, World!' > /root/hello.txt
apt-get update
sleep 15
apt-get upgrade -y

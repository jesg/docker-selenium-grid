#!/bin/bash

export DOCKER_HOST_IP=$(netstat -nr | grep '^0\.0\.0\.0' | awk '{print $2}')
export CONTAINER_IP=$(ip addr show dev eth0 | grep "inet " | awk '{print $2}' | cut -d '/' -f 1)

vncserver :10

java -jar /opt/selenium-server-standalone.jar \
-role node \
-hub http://${DOCKER_HOST_IP}:4444/grid/register \
-remoteHost http://${CONTAINER_IP}:5555 \
-browser browserName=firefox,maxInstances=1,platform=LINUX

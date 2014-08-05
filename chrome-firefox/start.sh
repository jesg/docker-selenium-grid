#!/bin/bash

Xvfb :10 -screen 5 1024x768x8 -ac &
export DISPLAY=:10.5

java -Djava.security.egd=file:/dev/random \
-jar /opt/selenium-server-standalone-2.42.2.jar \
-role node \
-hub http://${SELENIUM_HUB_ADDR}/grid/register \
-remoteHost http://${SELENIUM_NODE_ADDR} \
-browser browserName=firefox,maxInstances=5,platform=LINUX \
-browser browserName=chrome,maxInstances=5,platform=LINUX \
-debug
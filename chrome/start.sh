#!/bin/bash

Xvfb :10 -screen 5 1024x768x8 -ac &
export DISPLAY=:10.5

java -Djava.security.egd=file:/dev/urandom \
-jar /opt/selenium-server-standalone.jar \
-role node \
-hub http://${SELENIUM_HUB_ADDR}/grid/register \
-remoteHost http://${SELENIUM_NODE_ADDR} \
-browser browserName=chrome,maxInstances=1,platform=LINUX
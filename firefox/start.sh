#!/bin/bash

Xvfb :10 -screen 5 1024x768x8 -ac &
export DISPLAY=:10.5

java -jar /opt/selenium-server-standalone.jar \
-role node \
-browser browserName=firefox,maxInstances=1,platform=LINUX

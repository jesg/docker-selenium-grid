#!/bin/bash

/usr/bin/phantomjs --webdriver=5555 &

SELENIUM_HUB_IP=$(echo $SELENIUM_HUB_ADDR | cut -d : -f 1)
SELENIUM_HUB_PORT=$(echo $SELENIUM_HUB_ADDR | cut -d : -f 1)

SELENIUM_NODE_IP=$(echo $SELENIUM_NODE_ADDR | cut -d : -f 1)
SELENIUM_NODE_PORT=$(echo $SELENIUM_NODE_ADDR | cut -d : -f 1)

curl -H "Content-Type: application/json" -d "{\"configuration\": {\"registerCycle\": 5000, \"hub\": \"http://${SELENIUM_HUB_ADDR}\", \"host\": \"${SELENIUM_NODE_IP}\", \"proxy\": \"org.openqa.grid.selenium.proxy.DefaultRemoteProxy\", \"maxSession\": 1, \"port\": ${SELENIUM_NODE_PORT}, \"hubPort\": ${SELENIUM_HUB_PORT}, \"hubHost\": \"${SELENIUM_HUB_IP}\", \"url\": \"http://${SELENIUM_NODE_ADDR}\", \"remoteHost\": \"http://${SELENIUM_NODE_ADDR}\", \"register\": true, \"role\": \"wd\"}, \"capabilities\": [{\"seleniumProtocol\": \"WebDriver\", \"platform\": \"LINUX\", \"browserName\": \"phantomjs\", \"version\": \"1.9.7\", \"maxInstances\": 1}]}" http://$SELENIUM_HUB_ADDR/grid/register

wait $!


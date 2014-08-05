#!/bin/bash

CONTAINER_IP=$(ip addr show dev eth0 | grep "inet " | awk '{print $2}' | cut -d '/' -f 1)

/usr/bin/phantomjs --webdriver=${CONTAINER_IP}:5555 --webdriver-selenium-grid-hub=http://${SELENIUM_HUB_ADDR}
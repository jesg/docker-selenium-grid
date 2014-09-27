#!/bin/sh

vncserver :10

DISPLAY=:10 java -jar /opt/selenium-server-standalone.jar


#!/bin/bash

Xvfb :10 -screen 5 1024x768x8 -ac &
export DISPLAY=:10.5

/usr/bin/chromedriver --verbose
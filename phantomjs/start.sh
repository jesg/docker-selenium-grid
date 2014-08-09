#!/bin/bash

/opt/selenium-registration-proxy -hub http://$SELENIUM_HUB_ADDR -node http://$SELENIUM_NODE_ADDR -port 4444 &
/usr/bin/phantomjs --webdriver=5555 --webdriver-selenium-grid-hub=http://localhost:4444

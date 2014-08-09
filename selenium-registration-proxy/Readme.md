Small proxy used to overcome the fact that phantomJS does not have a way to register to a Selenium HUB giving an host that is not the one it detects. In the docker scenario, it means phantomJS will register using the container's internal IP and the port it is bound to in the container, not the public port.

This proxy will take care of this, if launched with

    selenium-registration-proxy -hub http://localhost:4444 -node http://localhost:5555 -port 4444

Parameters
 * port: port on which the proxy will listen for registration requests
 * node: public url to target the node
 * hub: hub where registration requests should be send

phantomJS should be launched using this kind of command

    ./phantomjs --webdriver 5550 --webdriver-selenium-grid-hub=http://localhost:4443

the hub should point to the proxy so that it triggers connection to the central hub.
# PhantomJS

FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y wget fontconfig curl

ENV PHANTOMJS_VERSION 1.9.7
RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN tar xjf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs
RUN wget https://github.com/wuzuf/docker-selenium-grid/releases/download/v0.1/selenium-registration-proxy
RUN mv selenium-registration-proxy /opt
RUN chmod a+x /opt/selenium-registration-proxy

ADD start.sh /opt/start.sh

CMD ["/bin/bash", "/opt/start.sh"]
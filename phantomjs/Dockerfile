# PhantomJS

FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y wget fontconfig curl

ENV PHANTOMJS_VERSION 1.9.7
RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2
RUN tar xjf phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /opt
RUN ln -s /opt/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

ADD start.sh /opt/start.sh

CMD ["/bin/bash", "/opt/start.sh"]
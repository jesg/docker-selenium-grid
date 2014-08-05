FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y software-properties-common python curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install oracle-java7-installer -y

RUN wget -P /opt http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update

RUN apt-get install -y google-chrome-stable xvfb

RUN mv /dev/random /dev/random.real && ln -s /dev/urandom /dev/random

ADD start.sh /opt/start.sh

EXPOSE 5555

CMD ["/bin/bash", "/opt/start.sh"]

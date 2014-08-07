FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y software-properties-common python curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install oracle-java7-installer -y

RUN wget -P /opt http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar
RUN mv selenium-server-standalone-2.41.0.jar selenium-server-standalone.jar 

RUN apt-get install -y firefox xvfb

ADD start.sh /opt/start.sh

EXPOSE 5555

CMD ["/bin/bash", "/opt/start.sh"]
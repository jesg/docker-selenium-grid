# Selenium Hub

FROM ubuntu:latest

RUN dpkg-divert --local --rename --add /sbin/initctl 
RUN rm -f /sbin/initctl && ln -s /bin/true /sbin/initctl

RUN apt-get update
RUN apt-get install -y software-properties-common python curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install oracle-java7-installer -y

RUN wget -P /opt http://selenium-release.storage.googleapis.com/2.42/selenium-server-standalone-2.42.2.jar

EXPOSE 4444

CMD ["java", "-jar", "/opt/selenium-server-standalone-2.42.2.jar", "-role", "hub"]
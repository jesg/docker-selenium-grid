FROM centos:centos6

MAINTAINER Jason Gowan <gowanjason@gmail.com>

RUN yum -y update; yum clean all

RUN yum -y install java-1.7.0-openjdk firefox xvfb; yum clean all

ADD http://selenium-release.storage.googleapis.com/2.43/selenium-server-standalone-2.43.1.jar /opt/selenium-server-standalone.jar

ADD start.sh /usr/local/bin/selenium-node

EXPOSE 5555

CMD ["selenium-node"]

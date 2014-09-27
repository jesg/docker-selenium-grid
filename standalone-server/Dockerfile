FROM centos:centos6

MAINTAINER Jason Gowan <gowanjason@gmail.com>

RUN yum -y update; yum clean all
RUN yum -y install epel-release; yum clean all
RUN yum -y install x11vnc java-1.7.0-openjdk org-x11-server-Xvfb xorg-x11-twm tigervnc-server firefox xterm xorg-x11-font dejavu-sans-fonts dejavu-serif-fonts xdotool; yum clean all

RUN yum -y install wget
RUN wget -P /opt http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar
RUN mv /opt/selenium-server-standalone-2.41.0.jar /opt/selenium-server-standalone.jar

# Add the xstartup file into the image
ADD ./xstartup /
RUN mkdir /root/.vnc
RUN x11vnc -storepasswd 123456 /root/.vnc/passwd
RUN \cp -f ./xstartup /root/.vnc/.
RUN chmod -v +x /root/.vnc/xstartup

ENV DISPLAY 10

EXPOSE 4444 5910

ADD ./start.sh /start.sh

CMD ./start.sh


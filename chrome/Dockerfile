FROM ubuntu:latest

RUN apt-get update

RUN apt-get install -y software-properties-common python curl
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update

RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections
RUN apt-get install oracle-java7-installer -y

RUN wget -P /opt http://selenium-release.storage.googleapis.com/2.41/selenium-server-standalone-2.41.0.jar
RUN mv /opt/selenium-server-standalone-2.41.0.jar /opt/selenium-server-standalone.jar 

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update

RUN apt-get install -y google-chrome-stable xvfb

RUN wget https://chromedriver.googlecode.com/files/chromedriver_linux64_2.3.zip
RUN unzip chromedriver_linux64_2.3.zip && rm chromedriver_linux64_2.3.zip && mv chromedriver /usr/bin && chmod 755 /usr/bin/chromedriver

ADD start.sh /opt/start.sh

EXPOSE 5555

CMD ["/bin/bash", "/opt/start.sh"]

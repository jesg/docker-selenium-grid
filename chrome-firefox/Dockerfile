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

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update

RUN apt-get install -y firefox google-chrome-stable xvfb
RUN apt-get install -y unzip

RUN wget http://chromedriver.storage.googleapis.com/2.10/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip && rm chromedriver_linux64.zip && mv chromedriver /usr/bin && chmod 755 /usr/bin/chromedriver

RUN mv /usr/bin/google-chrome /usr/bin/google-chrome-sandbox
RUN echo '#!/bin/bash\n/usr/bin/google-chrome-sandbox --no-sandbox --disable-setuid-sandbox $@' > /usr/bin/google-chrome
RUN chmod a+x /usr/bin/google-chrome

ADD start.sh /opt/start.sh
ADD chromedriver.sh /opt/chromedriver.sh

EXPOSE 5555

CMD ["/bin/bash", "/opt/start.sh"]
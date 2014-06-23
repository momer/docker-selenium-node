FROM ubuntu
MAINTAINER Lewis Zhang "lewiszhang@gmail.com"

# Forked by Mo Omer; added supervisord, config options

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jre-headless firefox xvfb supervisor

# Create supervisor log folder
RUN mkdir -p /var/log/supervisor/selenium
RUN mkdir -p /var/lib/selenium
# Add supervisor conf files
ADD supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD ./install /
ADD http://selenium.googlecode.com/files/selenium-server-standalone-2.35.0.jar /var/lib/selenium/

RUN chmod +x /var/lib/selenium/selenium-server-standalone-2.35.0.jar
RUN chmod +x /usr/local/bin/start_selenium.sh
RUN chmod +x /etc/init.d/xvfb

EXPOSE 4444

CMD ["/usr/bin/supervisord", "-n"]

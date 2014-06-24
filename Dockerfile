FROM momer/maestro-base-oracle-jdk:0.0.2

MAINTAINER Lewis Zhang "lewiszhang@gmail.com"

# Forked by Mo Omer; added supervisord, config options
RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -q -y openjdk-7-jre-headless firefox xvfb supervisor cron

# Create supervisor log folder
RUN mkdir -p /var/log/supervisor/selenium_node
RUN mkdir -p /var/lib/selenium
RUN mkdir -p /var/lib/.docker

# Add supervisor conf files
ADD supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run/run.py /var/lib/.docker/run.py

ADD ./install /

RUN chmod +x /var/lib/selenium/selenium-server-standalone-2.42.2.jar
RUN chmod +x /var/lib/.docker/run.py
# RUN chmod +x /var/lib/.docker/selenium_node_cron.conf
RUN chmod +x /usr/local/bin/start_selenium.sh
RUN chmod +x /etc/init.d/xvfb

# RUN /bin/bash -c "/usr/bin/crontab /var/lib/.docker/selenium_node_cron.conf"

EXPOSE 5555

VOLUME /var/log/supervisor

CMD ["python", "/var/lib/.docker/run.py"]

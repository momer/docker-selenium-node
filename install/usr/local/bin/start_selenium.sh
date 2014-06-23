#!/bin/bash

USAGE="Usage: start_selenium <PORT> <TIMEOUT> <MAXSESSION> <BROWSER>"

PORT="$1"
TIMEOUT="$2"
MAXSESSION="$3"
BROWSER="$4"

if [ "$PORT" = "" ]; then
  PORT=4444
fi

if [ "$TIMEOUT" = "" ]; then
  TIMEOUT=30
fi

if [ "$MAXSESSION" = "" ]; then
  MAXSESSION=5
fi

if [ "$BROWSER" = "" ]; then
  BROWSER="browserName=firefox,maxInstances=15"
fi

export DISPLAY=:99
/etc/init.d/xvfb start

java -jar /var/lib/selenium/selenium-server-standalone-2.35.0.jar \
-role hub -port $PORT -timeout $TIMEOUT -maxSession $MAXSESSION \
-browser $BROWSER

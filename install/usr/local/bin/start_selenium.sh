#!/bin/bash

USAGE="Usage: start_selenium <nodeConfig>"

NODE_CONFIG="$1"

if [ "$NODE_CONFIG" = "" ]; then
  echo "ERROR: Missing MAX_ITER." $USAGE
  exit -1;
fi

export DISPLAY=:99

/etc/init.d/xvfb start
java -jar /var/lib/selenium/selenium-server-standalone-2.35.0.jar \
-role node -nodeConfig $NODE_CONFIG

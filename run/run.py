#!/usr/bin/env python

# Start script for Apache Mahout and Hadoop.
import os
import subprocess
import string
import json

from maestro.guestutils import *
from maestro.extensions.logging.logstash import run_service

NODE_CONFIG = '/var/lib/selenium/nodeConfig.json'

with open(NODE_CONFIG, 'r') as f:
    data = json.load(f)
    f.close()

data["configuration"]["host"] = get_container_internal_address()
data["configuration"]["port"] = os.environ.get('SELENIUM_HUB_PORT', 5555)
data["configuration"]["hubHost"] = os.environ.get('SELENIUM_HUB_HOST', get_container_host_address())
data["configuration"]["hubPort"] = os.environ.get('SELENIUM_HUB_PORT', 4444)

with open(NODE_CONFIG, 'w+') as f:
    f.write(json.dumps(data))
    f.close()

# Start Supervisord in the foreground.
run_service(['/usr/bin/supervisord', '-n'])
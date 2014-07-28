## Docker image for Selenium Node

* [selenium](http://docs.seleniumhq.org/)
* Forked from https://github.com/lzhang/docker-selenium

## Install

Either git pull and build this docker image yourself, or pull down the version you need from the docker index.

```sh
$ sudo docker pull momer/docker-selenium-node:`version`
```

## Starting the container

This was designed to work with [MaestroNG](https://github.com/signalfuse/maestro-ng). 

```
  seleniumnode:
    image: momer/docker-selenium-node:1.0.0
    requires: [ seleniumhub ]
    env:
      SELENIUM_HUB_HOST: server1.my-host.com
    instances:
      ca2-selenium-node:
        ship: ca2
        ports: {seleniumnode: 5555}
        volumes:
          /var/log/supervisor/selenium_node: /opt/docker_volumes/selenium_node/log/supervisor
        limits:
          memory: 8g
        lifecycle:
          running: [{type: tcp, port: selenium}]
      ca3-selenium-node:
        ship: ca3
        ports: {seleniumnode: 5555}
        volumes:
          /var/log/supervisor/selenium_node: /opt/docker_volumes/selenium_node/log/supervisor
        limits:
          memory: 8g
        lifecycle:
          running: [{type: tcp, port: selenium}]
```

Selenium node is now available on port 5555 at the host and container.

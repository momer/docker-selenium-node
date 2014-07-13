#!/bin/bash
ps aux | grep -ie firefox | awk {'print $2'} | xargs kill -9
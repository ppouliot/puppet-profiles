#! /bin/bash
docker ps -a | awk '{print $1}' | xargs --no-run-if-empty docker rm -f

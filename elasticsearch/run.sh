#!/bin/bash

# fial fast
set -euo pipefail

container="es"
image="tdeheurles/elasticsearch"

docker build -t ${image} .
docker kill ${container} 2&> /dev/null || True 
docker rm  ${container} 2&> /dev/null || True
docker run -d --name ${container} ${image} #bash -c "${command}"
docker exec -ti ${container} bash

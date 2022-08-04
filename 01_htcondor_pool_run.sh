#!/usr/bin/env bash
HTCONDOR_NET="mynet"
EXISTS=$(docker network ls | awk '{print $2}' | grep ${HTCONDOR_NET})
if [ "${EXISTS}" == "" ]; then
  echo "Creating network ${HTCONDOR_NET}"
  docker network create ${HTCONDOR_NET}
fi
docker container run -d --rm -it --name cm --net ${HTCONDOR_NET} --hostname cm.demo.org josanabr/htcondor-central-manager:9.9.0
docker container run -d --rm -it -v //$(pwd)/Tarea-HTCondor-Bash-Dag:/Tarea-HTCondor-Bash-Dag --name access --net ${HTCONDOR_NET} --hostname access.demo.org josanabr/htcondor-submit:9.9.3
docker container run -d --rm -it --name exe01 --net ${HTCONDOR_NET} --hostname exe01.demo.org josanabr/htcondor-execute:9.9.0


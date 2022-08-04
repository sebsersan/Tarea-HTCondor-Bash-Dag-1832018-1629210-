#!/usr/bin/env bash
HTCONDOR_NET="mynet"
for i in exe01 access cm; do
  docker stop "${i}"
done
docker network rm ${HTCONDOR_NET}

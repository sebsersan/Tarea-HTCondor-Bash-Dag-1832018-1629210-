#!/usr/bin/env bash
#
for i in cm access exe01; do
  echo -n "Iniciando servicio de HTCondor en \"${i}\"... "
  docker container exec "${i}" sh -c condor_master
  echo " Done!"
done

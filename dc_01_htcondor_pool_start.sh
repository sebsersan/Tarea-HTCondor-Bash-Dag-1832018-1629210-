#!/usr/bin/env bash
#
for i in htcondor_cm_1 htcondor_access_1 htcondor_exe01_1; do
  echo -n "Iniciando servicio de HTCondor en \"${i}\"... "
  docker container exec "${i}" sh -c condor_master
  echo " Done!"
done

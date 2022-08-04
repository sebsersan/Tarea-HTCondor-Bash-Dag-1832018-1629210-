#!/usr/bin/env bash


registros_totales=$(wc -l $1 | awk '{print $1}')
descripcion_rt="Numero de registros totales: "
rt=$descripcion_rt$registros_totales

registros_incompletos=$(grep "?" $1 | wc -l)
descripcion_ri="Numero de registros incompletos: "
ri=$descripcion_ri$registros_incompletos

echo "$rt" >> estadistica.txt
echo "$ri" >> estadistica.txt

sed -i 's/?//g' $1

#!/usr/bin/env bash

cut -d ',' -f 1,9,10,15 $1 >> filtro.csv

awk '$2=="Black," && $4==">50K"' filtro.csv > tempb50.csv

awk '$3=="Female," && $4==">50K"' filtro.csv > tempf50.csv

black_50=$(wc -l tempb50.csv | awk '{print $1}')
female_50=$(wc -l tempf50.csv | awk '{print $1}')

echo "Cantidad de personas Black que tienen un Income superior a 50k: "$black_50 > reporte_2.txt
echo "Cantidad de personas Female que tienen un Income superior a 50k: "$female_50 >> reporte_2.txt

rm filtro.csv
rm tempb50.csv
rm tempf50.csv

 

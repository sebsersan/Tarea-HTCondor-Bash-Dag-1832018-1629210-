#!/usr/bin/env bash

awk '$1<="17,"' $1 > temp.csv

menor_edad=$(wc -l temp.csv | awk '{print $1}')

echo "Cantidad de personas menor de edad: "$menor_edad > reporte_3.txt
rm temp.csv

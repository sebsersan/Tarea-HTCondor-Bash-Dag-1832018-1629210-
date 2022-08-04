#!/usr/bin/env bash

echo "age,type_employer,fnlwgt,education,education-num,marital,occupation,relationship,race,sex,capital-gain,capital-loss,hr_per_week,country,income" > header.csv
cat header.csv $1 > tmp && mv tmp $1



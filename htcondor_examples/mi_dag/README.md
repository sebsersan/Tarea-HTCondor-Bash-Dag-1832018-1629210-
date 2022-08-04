# Mi primer DAG

Para llevar a cabo la ejecución de este DAG es **necesario** copiar en este directorio los siguientes archivos:

* `readf`, 
* `readf.condor`
* `storef`
* `storef.condor`

Estos archivos se encuentran en la carpeta [`../mi_binario`](../mi_binario). 
**NOTA** Para generar los archivos `readf` y `storef` debe ejecutar el comando `make` en el directorio `../mi_binario`.

Una vez se cuente con esos archivos entonces se puede proceder a ejecutar el comando:

```
condor_submit_dag midag.condor_dag
```

## Lleve a cabo la siguiente actividad

En [este documento](https://docs.google.com/document/d/13HNq1DPmo8mZNl5hKNEJCGqGy7jdAlKQYeZe3Bm8xgE/edit?usp=sharing) se presenta un ejemplo con fines formativos de como llevar a cabo el cálculo de una identidad trigonómetrica usando HTCondor y los DAGs.

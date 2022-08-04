# Comandos básicos de Unix ejecutados con HTCondor

En este directorio encontrará dos ejemplos que muestran como invocar la ejecución de comandos de Unix usando la plataforma HTCondor.

## `submit_ls.condor`

Este archivo muestra la ejecución del comando `ls -l` usando HTCondor.
La forma como se hace la ejecución es de la siguiente manera:

```
condor_submit submit_ls.condor
```

## `submit_wc.condor`

Este archivo muestra la ejecucióon del comando `wc -l` con un archivo descargado de Internet.
De manera análoga como se hizo en el ejemplo anterior, ejecutar este comando.

## Haga lo usted

* Cree una tarea en HTCondor que imprima el famoso mensaje "Hola mundo".

* Haga un script que lleve a cabo la invocación de dos comandos de Unix. 

## Referencias

* [HTCondor 101](https://docs.google.com/document/d/13VWbjESPB_CH7_KEmrkAtcO6PakHFdGfqWGyypOgPhs/edit?usp=sharing)

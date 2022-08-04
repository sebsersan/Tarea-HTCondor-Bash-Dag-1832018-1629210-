# HTCondor y binarios propios

En esta carpeta se encontrarán un par de ejemplos que muestran como llevar a cabo la ejecución de tus propios programas en la plataforma HTCondor.

Se han desarrollado dos ejemplos:

* `storef.c` este es un programa en C que recibe como argumento un número y lo almacena en un archivo.
* `readf.c` este programa en C lee de un archivo plano un número real e imprime por pantalla el número leido del archivo.

Estos programas se compilarán y posteriormente se ejecutarán en un cluster de HTCondor.

## Compilación de los programas a través del comando `make` 

La forma como se compilarán los programas es haciendo uso del comando `make`.
Existen cuatro formas de llamar al comando `make` __en este directorio__:

* `make all` de esta manera se crean los binarios `storef` y `readf` que resultan de compilar `storef.c` y `readf.c`, respectivamente.

* `make storef` se encarga de crear el binario `storef`.

* `make readf` se encarga de crear el binario `readf`.

* `make clean` lleva a cabo el borrado de `storef` y `readf`, entre otros archivos. 

## Envío de tareas a través de HTCondor

Para enviar la ejecución de los comandos `storef`  y `readf` a una plataforma de HTCondor se ejecuta lo siguiente:

* `condor_submit storef.condor` para ejecutar el comando `storef`.

* `condor_submit readf.condor` para ejecutar el comando `readf`.

**IMPORTANTE**
Para que la ejecución de estos comandos funcione adecuadamente se deben ejecutar los comandos en el orden indicado en los ítems anteriores.
La razón es que `readf.condor` requiere, para su correcta ejecución, de un archivo generado tras la ejecución del comando `condor_submit storef.condor`.

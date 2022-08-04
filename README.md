# HTCondor en contenedores

## Quickstart

Para hacer el despliegue de HTCondor ejecute los siguientes comandos:

```
./01_htcondor_pool_run.sh  
./02_htcondor_pool_start.sh  
```

Estos scripts permiten el levantar los contenedores necesarios para crear un *pool* de HTCondor.
Una vez estos contenedores estén arriba se procede a ingresar al nodo que le permitirá el uso del *pool*.

```
./03_htcondor_pool_get_access.sh
```

Una vez dentro del contenedor, ingresar a la carpetar `htcondor_examples` y revisar estos ejemplos en este orden:

* `command_line` 
* `mi_binario` 
* `mi_dag` 


## La forma extensa de desplegar el cluster de HTCondor

Este repositorio contiene scripts y archivos de HTCondor donde se ejemplifica su uso. 

---

* [HTCondor en Contenedores](https://www.youtube.com/watch?v=5CwOu97GjJ4&t=184s)

---

Crear una red para el ambiente de HTCondor

```
docker network create htcondornet
```

Se ejecuta el gestor central de HTCondor

```
docker container run --rm -it --net htcondornet --hostname cm.demo.org centos:7
```

`cm` por `C-entral M-anager`.

Se ejecuta un nodo de procesamiento (`execute node`)

```
docker container run --rm -it --net htcondornet --hostname exe01.demo.org centos:7
```

Un nodo para acceder al ambiente de HTCondor (`submit`)

```
docker container run --rm -it --net htcondornet --hostname submit.demo.org centos:7
```

Ya se tienen tres contenedores corriendo y se necesita tener tres perfiles de HTCondor corriendo en estos tres contenedores.

En [este enlace](https://htcondor.readthedocs.io/en/latest/getting-htcondor/admin-quick-start.html) se muestra como instalar el `central manager`, el nodo `submit` y el nodo `execute`.

El comando para instalar el `central manager` será:

```
curl -fsSL https://get.htcondor.org | GET_HTCONDOR_PASSWORD="htcondor_password" /bin/bash -s -- --no-dry-run --central-manager cm.demo.org
```

El comando para instalar el `submit` será:

```
curl -fsSL https://get.htcondor.org | GET_HTCONDOR_PASSWORD="htcondor_password" /bin/bash -s -- --no-dry-run --submit cm.demo.org
```

El comando para instalar el `execute` será:

```
curl -fsSL https://get.htcondor.org | GET_HTCONDOR_PASSWORD="htcondor_password" /bin/bash -s -- --no-dry-run --execute cm.demo.org
```

Para validar que todo está bien ejecutar los siguientes comandos:

* En el `central manager` 

```
condor_status
```

* En el `submit` 

```
condor_q
```

---

Para descargar imágenes de HTCondor y ejecutarlas realice lo siguiente. 
**Asegúrese que tiene una red llamada `mynet`**:

* Central Manager

```
docker container run --rm -it --net mynet --hostname cm.demo.org josanabr/htcondor-central-manager:9.9.0
sh -c condor_master
```

* Submit

```
docker container run --rm -it --net mynet --hostname access.demo.org josanabr/htcondor-submit:9.9.3
sh -c condor_master
```

* Execute 

```
docker container run --rm -it --net mynet --hostname exe01.demo.org josanabr/htcondor-execute:9.9.0
sh -c condor_master
```

El password del pool de HTCondor es `GET_HTCONDOR_PASSWORD="htcondor_password"`.


---

Una [guía para usar HTCondor](https://agenda.hep.wisc.edu/event/1733/contributions/25486/attachments/8279/9532/2022-HTCondor-User-Tutorial.pdf) [Video](https://www.youtube.com/watch?v=8jadQkAdU1k&list=PLO7gMRGDPNukAR1ljzfW7fJwt1cdDLygo)

---

Una forma de lanzar el *pool* de HTCondor es a través del siguiente script:

```

#!/usr/bin/env bash
HTCONDOR_NET="mynet"
EXISTS=$(docker network ls | awk '{print $2}' | grep ${HTCONDOR_NET})
if [ "${EXISTS}" == "" ]; then
  echo "Creating network ${HTCONDOR_NET}"
  docker network create ${HTCONDOR_NET}
fi
docker container run -d --rm -it --name cm --net ${HTCONDOR_NET} --hostname cm.demo.org josanabr/htcondor-central-manager:9.9.0
docker container run -d --rm -it -v $(pwd)/htcondor_examples:/htcondor_examples --name access --net ${HTCONDOR_NET} --hostname access.demo.org josanabr/htcondor-submit:9.9.3
docker container run -d --rm -it --name exe01 --net ${HTCONDOR_NET} --hostname exe01.demo.org josanabr/htcondor-execute:9.9.0
```

Este script crea tres nodos llamados: `cm`, `access` y `exe01`. 
Los tres nodos están corriendo en modo `detach`.

### Creación de usuario en `access` node

Para usar el *pool* de HTCondor es necesario usarlo con un usuario diferente al `root`.
Cada vez que nos conectamos a alguno de los contenedores que hemos lanzado anteriormente, nos conectamos como `root`.
Nos conectaremos ahora con un usuario diferente.

Nos conectamos al contenedor `access` y creamos un usuario llamado `user`.

```
docker container exec -it access /bin/bash
adduser user
exit # para salir del contenedor 'access'
```

Ahora, nos conectamos como usuario `user` al contenedor `access` y validamos que tenemos acceso al *pool* de HTCondor.

```
docker container exec -it --user user access /bin/bash
condor_q
```

### `josanabr/htcondor-submit:9.9.3` 

En esta nueva versión de esta imagen ya se tiene el usuario `user`.

Se lanza su ejecución entonces de la siguiente manera:

```
export HTCONDOR_NET="mynet"
docker container run -d --rm -it -v $(pwd)/htcondor_examples:/htcondor_examples --name access --net ${HTCONDOR_NET} --hostname access.demo.org josanabr/htcondor-submit:9.9.3
docker container exec -it access /bin/bash
sh -c condor_master
exit
```

Y se conecta al contenedor a través del usuario de la manera indicada anteriormente.

```
docker container exec -it --user user access /bin/bash
condor_q
```

---

## Referencias

* <https://htcondor.readthedocs.io/en/latest/users-manual/submitting-a-job.html>

* Guía propia para enseñar HTCondor <https://docs.google.com/document/d/1r1wr05Eh9LOGMccUhBRva-hrZafLUN1dRW3J_hydpm0/edit?usp=sharing>

* Usando Bash para procesar archivos CSV <https://docs.google.com/presentation/d/1l0WVWwXJE4K2kDnH-3q1e819doAnW8sneF40s7k78yo/edit?usp=sharing>

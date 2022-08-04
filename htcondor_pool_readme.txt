Se presentan los scripts en orden de uso:

01_htcondor_pool_run.sh --> este script ejecuta todos los contenedores que conformaran nuestro pool de HTCondor
02_htcondor_pool_start.sh --> este script visita cada uno de los contenedores y permitir al usuario el lanzar la ejecucion del daemon de HTCondor ('sh -c condor_master')
03_htcondor_pool_get_access.sh --> este script permite el ingreso al nodo 'submit' desde el cual se pueden lanzar tareas a HTCondor. El directorio '/htcondor_examples' tiene varios ejemplos respecto al uso de HTCondor
04_htcondor_pool_stop.sh --> este script detiene la ejecucion de todos los contenedores

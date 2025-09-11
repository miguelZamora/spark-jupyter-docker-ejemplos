Para una aplicacion de spark en windows sobre Docker "docker-compose "



el archivo docker-compose.yml o yaml tambien puede ser no da la 
instalacion para probar los notebooks de jupyter y ver los tiempos de respuestas 
la dbs que desea analizar y entre otros.  

en resumidas cuentas es un docker compose up --build -d y el docker-compose down tienen las versiones de los entornosc como un txt que como nombre es la version de spark 


Arquitectura general
Red compartida: spark-network conecta todos los contenedores.

Persistencia: Volúmenes locales para Jupyter (./work) y Spark (./jars).

Servicios:

Jupyter Notebook con PySpark

PostgreSQL como base de datos

Spark Master + 3 Spark Workers


Descripción por servicio
1. Jupyter Notebook
yaml
image: jupyter/pyspark-notebook
ports: "8888:8888"
volumes: ./work:/home/jovyan/work
environment:
  - GRANT_SUDO=yes
  - JUPYTER_ENABLE_LAB=yes

Entorno interactivo para desarrollo en PySpark. 
Expone el puerto 8888 para acceso web. 
Monta el directorio ./work como espacio de trabajo persistente. 
Habilita JupyterLab y permisos sudo para el usuario jovyan.



2. PostgreSQL
yaml
image: postgres:latest
container_name: postgresdb_cachoza
environment:
  POSTGRES_USER: cachoza_user
  POSTGRES_PASSWORD: cachoza_password
  POSTGRES_DB: psqldbSpark
ports: "5432:5432"


Base de datos relacional para persistencia o análisis.
Usuario inicial: cachoza_user, base de datos: psqldbSpark. 
Expone el puerto 5432 para conexión desde Spark o Jupyter.

3. Spark Master
yaml
image: bitnami/spark:3.5.0
container_name: spark-master
command: ["/opt/bitnami/scripts/spark/run.sh"]
environment:
  - SPARK_MODE=master
ports: "7077", "8080"
volumes: ./jars:/opt/spark/jars


Nodo central del clúster Spark. 
Puerto 7077: comunicación con workers.
Puerto 8080: interfaz web del master.
Monta ./jars para bibliotecas compartidas. los drivers de mysql o postgresql  

4. Spark Workers (1, 2 y 3)
Cada uno tiene:

yaml
SPARK_MODE=worker
SPARK_MASTER_URL=spark://spark-master:7077
SPARK_WORKER_MEMORY=2g
SPARK_WORKER_CORES=2

Se conectan al master vía spark://spark-master:7077. 
Cada worker tiene 2 GB de RAM y 2 núcleos asignados. 
Comparten el volumen ./jars para acceso a dependencias.

Secuencia de arranque recomendada
Red spark-network se crea automáticamente.

PostgreSQL se inicia primero para asegurar disponibilidad de la base de datos.

Spark Master se levanta y espera conexiones.

Spark Workers se conectan al master.

Jupyter Notebook se inicia al final, ya que puede depender de Spark y PostgreSQL para ejecutar notebooks con acceso a datos y clúster.







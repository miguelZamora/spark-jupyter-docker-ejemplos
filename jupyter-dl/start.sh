#!/bin/bash
# start.sh

# Configurar variables de entorno para Spark
export SPARK_MASTER=spark://spark-master:7077
export PYSPARK_SUBMIT_ARGS="--master spark://spark-master:7077 pyspark-shell"

# Iniciar JupyterHub
exec jupyterhub -f /srv/jupyterhub/jupyterhub_config.py --ip=0.0.0.0 --port=8000
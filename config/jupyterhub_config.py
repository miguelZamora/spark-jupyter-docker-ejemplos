# jupyterhub_config.py
import os

c.JupyterHub.spawner_class = 'jupyterhub.spawner.LocalProcessSpawner'
c.JupyterHub.ip = '0.0.0.0'
c.JupyterHub.port = 8000

# Autenticación simple (sin contraseña para desarrollo)
#c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'
#c.Authenticator.allow_all = True


#c.JupyterHub.authenticator_class = 'dummy'
#c.Authenticator.allowed_users = {"jovyan","miguel"}
#c.DummyAuthenticator.password = "123456"


c.JupyterHub.authenticator_class = 'jupyterhub.auth.PAMAuthenticator'
c.Spawner.default_url = '/lab'



# Configuración de los notebooks
c.Spawner.default_url = '/lab'
c.Spawner.notebook_dir = '/home/jovyan/work'

# Variables de entorno para los usuarios
c.Spawner.env_keep = ['SPARK_MASTER', 'PYSPARK_SUBMIT_ARGS']
c.Spawner.environment = {
    'SPARK_MASTER': 'spark://spark-master:7077',
    'PYSPARK_SUBMIT_ARGS': '--master spark://spark-master:7077 pyspark-shell'
}





# Recursos para cada usuario
c.Spawner.mem_limit = '2G'
c.Spawner.cpu_limit = 2.0

# Persistencia
c.JupyterHub.db_url = 'sqlite:///jupyterhub.sqlite'

# Logging
c.JupyterHub.log_level = 'DEBUG'
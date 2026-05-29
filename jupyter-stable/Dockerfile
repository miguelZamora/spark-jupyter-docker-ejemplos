FROM jupyter/pyspark-notebook:python-3.11

USER root

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    python3-dev \
    libpq-dev \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar librerías Python adicionales
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip setuptools wheel && \
    pip install --no-cache-dir -r /tmp/requirements.txt


 

# Configurar variables de entorno
ENV JUPYTER_ENABLE_LAB=yes \
    GRANT_SUDO=yes

# Crear directorios de trabajo
RUN mkdir -p /home/jovyan/work /home/jovyan/data

# Volver al usuario jovyan
USER jovyan

# Comando para iniciar JupyterHub
CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8000", "--no-browser"]

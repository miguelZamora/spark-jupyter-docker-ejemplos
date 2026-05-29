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


RUN pip install --upgrade pip setuptools wheel 
RUN pip install --no-cache-dir -r /tmp/requirements.txt && \
    pip install keras==2.15.0 tensorflow==2.15.1


# Cambiar contraseña de jovyan (ya existe en la imagen base)
RUN echo "jovyan:abcde" | chpasswd

# Crear usuario miguel con clave fija
RUN useradd -m miguel && echo "miguel:123456" | chpasswd

# Configurar variables de entorno
ENV JUPYTER_ENABLE_LAB=yes \
    GRANT_SUDO=yes

# Crear directorios de trabajo
RUN mkdir -p /home/jovyan/work /home/jovyan/data

# Volver al usuario jovyan para ejecutar JupyterHub
USER jovyan

CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8000"]

FROM eclipse-temurin:17-jre-jammy

# Instalar wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Configurar versión de Spark
ENV SPARK_VERSION=3.5.4
ENV HADOOP_VERSION=3
ENV SPARK_HOME=/opt/spark

# Usar mirror de Apache (más confiable que dlcdn)
RUN wget -q --no-check-certificate https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    tar -xzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
    mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME} && \
    rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

ENV PATH=$PATH:${SPARK_HOME}/bin:${SPARK_HOME}/sbin

WORKDIR ${SPARK_HOME}/work-dir

ENTRYPOINT ["/opt/spark/bin/spark-class"]
CMD ["org.apache.spark.deploy.master.Master"]
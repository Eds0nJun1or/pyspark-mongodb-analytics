FROM jupyter/pyspark-notebook:latest

# Instalar pymongo para conectar com MongoDB
RUN pip install pymongo[srv]

# Definir variáveis de ambiente necessárias
ENV MONGO_URI=mongodb+srv://edjr040702:gdCyfGkgU6QsrgIs@sparkglp.zbnicwb.mongodb.net/

# Copiar o notebook para o container
COPY df_mongo.ipynb /home/jovyan/work/

WORKDIR /home/jovyan/work/
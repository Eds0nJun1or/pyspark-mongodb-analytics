### README.md

# Análise de Dados com PySpark e MongoDB

Este projeto realiza a análise de dados de preços de Combustíveis e de GLP automotivos utilizando PySpark e MongoDB. Os dados são carregados a partir de um arquivo CSV, processados e armazenados no MongoDB. A análise inclui estatísticas descritivas, identificação de outliers e visualizações.

## Estrutura do Projeto

```
├── .ipynb_checkpoints/
│   ├── df_mongo-checkpoint.ipynb
│   └── df_spark-checkpoint.ipynb
├── DOCKER-COMPOSE/
│   └── docker-compose.yaml
├── src/
│   ├── Preços semestrais - AUTOMOTIVOS_2023.02.csv
├── df_mongo.ipynb
├── df_spark.ipynb
├── dockerfile
├── README.md
└── requirements.txt
```

## Pré-requisitos

- Docker
- Conta no MongoDB Atlas

## Instalação

### Clonar o Repositório

```bash
git clone [https://github.com/eds0njun1or/pyspark-mongodb-analytics/repo.git](https://github.com/Eds0nJun1or/pyspark-mongodb-analytics.git)
cd repo
```

### Configurar MongoDB Atlas

1. Crie uma conta no [MongoDB Atlas](https://www.mongodb.com/cloud/atlas).
2. Configure um cluster e obtenha a URI de conexão.

### Construir a Imagem Docker

Navegue até o diretório do projeto, exemplo:

```bash
cd C:\Users\Biboy\Desktop\big-spark
```

Construa a imagem Docker:

```bash
docker build -t pyspark-mongo .
```

### Rodar o Container Docker

Execute o comando abaixo para rodar o container Docker:

```bash
docker run -p 8888:8888 -e MONGO_URI=mongodb+srv://username:<password>@clustername.mongodb.net/test?retryWrites=true&w=majority -v %cd%:/home/jovyan/work pyspark-mongo
```

### Acessar o Jupyter Notebook

Após executar o container, acesse o Jupyter Notebook na porta 8888 do localhost:

```bash
http://localhost:8888
```

Insira o token fornecido no terminal para acessar o ambiente do Jupyter Notebook.

## Uso

Os notebooks `df_spark.ipynb` e `df_mongo.ipynb` realizam as seguintes operações:

1. Carregamento dos dados do CSV.
2. Processamento e análise dos dados usando PySpark.
3. Armazenamento dos dados no MongoDB (`df_mongo.ipynb`).
4. Geração de estatísticas e visualizações.

### Configuração da Sessão Spark

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Integracao PySpark MongoDB") \
    .getOrCreate()
```

### Carregar Dados do CSV

```python
df = spark.read.option('delimiter', ';').option('header', 'true').option('inferSchema', 'true').option('encoding', 'ISO-8859-1').csv('./src/Preços semestrais - AUTOMOTIVOS_2023.02.csv')
df.printSchema()
```

### Armazenar Dados no MongoDB

```python
from pymongo import MongoClient
import os

mongo_uri = os.getenv("MONGO_URI")
client = MongoClient(mongo_uri)
db = client.get_database('test')
collection = db.get_collection('your_collection_name')

# Salvar dados no MongoDB
df.write.format("com.mongodb.spark.sql.DefaultSource").option("uri", mongo_uri).mode("append").save()
```

## Sobre a pasta '.ipynb_checkpoints'

A pasta é gerada após o usuário fazer alguma alteração dentro do localhost:8888 e automaticamente todo o projeto é atualizado.

### Análises Estatísticas e Visualizações

Os notebooks realizam diversas análises estatísticas, incluindo:

- Verificação de valores nulos
- Estatísticas de preços por estado e produto
- Identificação de outliers
- Visualizações utilizando matplotlib e seaborn

## Dependências

As dependências do projeto estão listadas no arquivo `requirements.txt`.

### Instalar Dependências

```bash
pip install -r requirements.txt
```

## Licença

Este projeto está licenciado sob os termos da licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## Contexto dos Dados

### Série Histórica de Preços de Combustíveis e de GLP

Em cumprimento às determinações da Lei do Petróleo (Lei nº 9478/1997, artigo 8º), a ANP acompanha os preços praticados por revendedores de combustíveis automotivos e de gás liquefeito de petróleo envasilhado em botijões de 13 quilos (GLP P13), por meio de uma pesquisa semanal de preços realizada por empresa contratada.

Os dados analisados fazem parte da Série Histórica de Preços de Combustíveis, que são publicados semanalmente e agrupados por semestre. Este projeto utiliza dados do 2° semestre de 2023 para combustíveis automotivos.

---

### requirements.txt

```txt
pyspark==3.3.0
pandas==1.3.3
matplotlib==3.4.3
seaborn==0.11.2
numpy==1.21.2
pymongo==3.12.0
prophet==1.0
```

Este README fornece uma visão geral do projeto, explicando como configurar e executar o ambiente Docker, além de detalhar as análises realizadas e as dependências necessárias. O arquivo `requirements.txt` lista todas as bibliotecas Python necessárias para a execução do projeto.

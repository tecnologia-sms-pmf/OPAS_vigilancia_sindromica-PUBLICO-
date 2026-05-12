# Usa uma imagem oficial e leve do Python
FROM python:3.11-slim

# Instala as dependências do sistema operativo necessárias para compilar os conectores
RUN apt-get update && apt-get install -y \
    gcc \
    libmariadb-dev \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Define a pasta de trabalho dentro do contentor
WORKDIR /app

# Copia as dependências e instala-as. 
# Adicionamos o 'nbconvert' aqui para que o Docker consiga converter o notebook.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt nbconvert

# Copia o notebook original e o ficheiro de configuração para dentro do contentor
COPY vig_sindro_opas.ipynb .
COPY config.toml .

# Executa a conversão do ficheiro .ipynb para .py durante o "build" da imagem
RUN jupyter nbconvert --to python vig_sindro_opas.ipynb

# O comando acima vai gerar um ficheiro chamado "vig_sindro_opas.py".
# O CMD agora executa esse novo ficheiro gerado. A flag "-u" garante logs em tempo real.
CMD ["python", "-u", "vig_sindro_opas.py"]
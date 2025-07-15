# Usa imagem oficial baseada em Debian com Python 3.11.9
FROM python:3.11.9-slim

# Define variáveis para não precisar confirmar nada no apt
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Atualiza e instala dependências do sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gcc \
    curl \
    git \
    libffi-dev \
    libssl-dev \
    libpq-dev \
    libuv1-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Cria diretório de trabalho
WORKDIR /app

# Copia arquivos de dependência
COPY requirements.txt* /app/

# Instala dependências
# Caso use poetry:
# RUN pip install poetry && poetry config virtualenvs.create false && poetry install --no-root

# Caso use pip:
RUN pip install --upgrade pip && \
    if [ -f "requirements.txt" ]; then pip install -r requirements.txt; fi

# Copia o restante do código da aplicação
COPY . .

# Expõe a porta padrão (ajuste conforme necessário)
EXPOSE 8000

# Comando padrão (ajuste conforme o framework, ex: uvicorn, gunicorn, etc)
CMD ["python", "main.py"]

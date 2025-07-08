FROM python:3.10-slim

# sistem deps untuk faiss/reportlab
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential gcc libjpeg62-turbo-dev && \
    rm -rf /var/lib/apt/lists/*

ENV PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

COPY . .

EXPOSE 8501
ENTRYPOINT ["streamlit", "run", "main.py", "--server.port=8501", "--server.enableCORS=false", "--server.headless=true"]
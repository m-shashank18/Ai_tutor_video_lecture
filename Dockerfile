FROM python:3.11-slim

WORKDIR /app

# Install dependencies first for layer caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source
COPY . .

# PYTHONPATH ensures config/ and src/ are importable without install
ENV PYTHONPATH=/app
ENV LOG_LEVEL=INFO

CMD ["python", "tests/test_week1_pipeline.py"]

# Use a slim Python base
FROM python:3.11-slim

# Install Postgres client libraries (required to build psycopg2)
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Set working dir inside container
WORKDIR /app

# Copy requirements first for dependency install (if you have a requirements.txt)
COPY ../requirements.txt ./requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Default command (override in docker compose run)
CMD ["python"]

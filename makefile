# Makefile for Repo A

ENV_FILE=.env

# Default target (help message)
help:
	@echo "Available targets: init, up, down, logs, psql, load-sample, test, lint, format"

# 1. Initialize .env from template if it doesn’t exist
init:
	@if [ ! -f $(ENV_FILE) ]; then \
		cp .env.template $(ENV_FILE); \
		echo ".env created from template"; \
	else \
		echo ".env already exists"; \
	fi

# 2. Start services with docker compose
up:
	docker compose -f infra/docker-compose.yml up -d

# 3. Stop services
down:
	docker compose -f infra/docker-compose.yml down

# 4. Show container logs
logs:
	docker compose -f infra/docker-compose.yml logs -f

# 5. Open a psql shell inside the Postgres container
psql:
	docker exec -it postgres_db psql -U $$DB_USER -d $$DB_NAME

# 6. Load sample data (assuming you have a loader script)
load-sample:
	docker compose run --rm loader python scripts/load_sample.py

# 7. Run tests inside the loader (Python testing)
test:
	docker compose run --rm loader pytest

# 8. Run linter (flake8)
lint:
	docker compose run --rm loader flake8 .

# 9. Auto-format code with Black
format:
	docker compose run --rm loader black .


load-sample:
	# Run schema creation scripts
	docker exec -i postgres_db psql -U $$DB_USER -d $$DB_NAME < sql/raw/01_create_raw_schema.sql
	docker exec -i postgres_db psql -U $$DB_USER -d $$DB_NAME < sql/staging/01_create_staging_schema.sql
	docker exec -i postgres_db psql -U $$DB_USER -d $$DB_NAME < sql/mart/01_create_mart_schema.sql
	# Run Python seed to load CSVs into raw schema
	docker compose run --rm loader python src/seed.py

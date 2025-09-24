# Makefile for Repo A

ENV_FILE=.env                     # Path to .env file used by Compose/DB

# Default target: help
help:                             # Run `make help` to see target list
	@echo "Available targets: init, up, down, logs, psql, load-sample, test, lint, format"

# 1. Initialize .env from template if not present
init:                             # Copies .env.template -> .env if missing
	@if [ ! -f $(ENV_FILE) ]; then \
		cp .env.template $(ENV_FILE); \
		echo ".env created from template"; \
	else \
		echo ".env already exists"; \
	fi

# 2. Start services with docker compose (Postgres + Adminer)
up:                               # Start stack in detached mode
	docker compose -f infra/docker-compose.yml up -d

# 3. Stop services and remove containers
down:                             # Stop containers (keeps volume data)
	docker compose -f infra/docker-compose.yml down

# 4. Show logs from containers
logs:                             # Tail docker-compose logs
	docker compose -f infra/docker-compose.yml logs -f

# 5. Open psql shell inside the Postgres container
psql:                             # Open DB shell
	docker exec -it postgres_db psql -U $$POSTGRES_USER -d $$POSTGRES_DB

# 6. Load sample data (schemas + seed CSVs)
load-sample:                      
	# Create schemas
	docker exec -i postgres_db psql -U $$POSTGRES_USER -d $$POSTGRES_DB < sql/raw/01_create_raw_schema.sql
	docker exec -i postgres_db psql -U $$POSTGRES_USER -d $$POSTGRES_DB < sql/staging/01_create_staging_schema.sql
	docker exec -i postgres_db psql -U $$POSTGRES_USER -d $$POSTGRES_DB < sql/mart/01_create_mart_schema.sql
	# Run Python seed
	docker compose run --rm loader python src/seed.py

# 7. Run smoke tests with pytest
test:
	# Local dev: connect via localhost
	POSTGRES_HOST=localhost docker compose run --rm loader pytest -q
	# In CI (GitHub Actions): override with POSTGRES_HOST=postgres

# 8. Run linter with flake8
lint:
	docker compose run --rm loader flake8 .

# 9. Auto-format Python code with Black
format:
	docker compose run --rm loader black .

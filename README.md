![CI](https://github.com/giannis93/de-warehouse-starter/actions/workflows/ci.yml/badge.svg)

## Local Database Setup with Docker Compose   <!-- docker-Compose -->

### Start containers
From the `infra` folder, run:

### docker compose up -d # Launch services in detached mode (background)


### Access Adminer UI
1. Open [http://localhost:8080](http://localhost:8080) in your browser.   <!-- Adminer runs on port 8080 -->
2. Login with:
   - **System:** PostgreSQL        <!-- Adminer login dropdown choice -->
   - **Server:** postgres          <!-- Container hostname (same as service name) -->
   - **Username:** `POSTGRES_USER` from `.env`
   - **Password:** `POSTGRES_PASSWORD` from `.env`
   - **Database:** `POSTGRES_DB` from `.env`

### Stop containers

### docker compose down # Stop and remove containers, but keep volume data text

Data is persisted in the `postgres_data` named volume.  <!-- DB data survives restarts -->


## Makefile Shortcuts

Instead of long docker commands, use these shortcuts:

- `make init` → Create `.env` from `.env.template`  
- `make up` → Start containers in background  
- `make down` → Stop containers  
- `make logs` → Follow container logs  
- `make psql` → Connect to Postgres with psql  
- `make load-sample` → Load sample datasets into the DB  
- `make test` → Run Python tests  
- `make lint` → Lint Python code  
- `make format` → Auto-format code with Black

import os
import psycopg2
from psycopg2 import sql

def _connect():
    # DATABASE_URL wins if present (one string var form)
    url = os.getenv("DATABASE_URL")
    if url:
        return psycopg2.connect(url, connect_timeout=5)

    # Resolve Postgres envs
    host = os.getenv("POSTGRES_HOST", "localhost")
    port = int(os.getenv("POSTGRES_PORT", "5432"))
    user = os.getenv("POSTGRES_USER", "postgres")
    password = os.getenv("POSTGRES_PASSWORD", "postgres")
    dbname = os.getenv("POSTGRES_DB", "postgres")

    return psycopg2.connect(
        host=host, port=port, user=user, password=password, dbname=dbname, connect_timeout=5
    )

def test_smoke_min_rows_after_sample_load():
    table = os.getenv("SMOKE_TABLE", "public.sample")
    min_rows = int(os.getenv("SMOKE_MIN_ROWS", "1"))

    if "." in table:
        schema, name = table.split(".", 1)
    else:
        schema, name = "public", table

    with _connect() as conn:
        with conn.cursor() as cur:
            query = sql.SQL("SELECT COUNT(*) FROM {}.{}").format(
                sql.Identifier(schema), sql.Identifier(name)
            )
            cur.execute(query)
            (count,) = cur.fetchone()

    assert count >= min_rows, f"Expected at least {min_rows} rows in {schema}.{name}, found {count}"

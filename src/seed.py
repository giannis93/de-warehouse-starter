# This Python script loads CSVs into the raw schema.
import os
import psycopg2
import pandas as pd

def get_conn():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "localhost"),
        port=os.getenv("DB_PORT", "5432"),
        user=os.getenv("DB_USER", "de_user"),
        password=os.getenv("DB_PASSWORD", "de_pass"),
        dbname=os.getenv("DB_NAME", "de_warehouse"),
    )
    return conn

def load_csv_to_table(conn, csv_path, table_name):
    df = pd.read_csv(csv_path)
    with conn.cursor() as cur:
        for _, row in df.iterrows():
            cols = ",".join(df.columns)
            placeholders = ",".join(["%s"] * len(df.columns))
            query = f"INSERT INTO raw.{table_name} ({cols}) VALUES ({placeholders}) ON CONFLICT DO NOTHING"
            cur.execute(query, tuple(row))
    conn.commit()
    print(f"Loaded {len(df)} rows into raw.{table_name}")

if __name__ == "__main__":
    conn = get_conn()
    load_csv_to_table(conn, "datasets/employees.csv", "employees")
    load_csv_to_table(conn, "datasets/departments.csv", "departments")
    load_csv_to_table(conn, "datasets/jobs.csv", "jobs")
    conn.close()

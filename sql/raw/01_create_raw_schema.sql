CREATE SCHEMA IF NOT EXISTS raw;

-- Example table in raw schema
CREATE TABLE IF NOT EXISTS raw.employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    department_id INT
);

CREATE SCHEMA IF NOT EXISTS raw;

-- Employees table
CREATE TABLE IF NOT EXISTS raw.employees (
    emp_id INT PRIMARY KEY,
    name TEXT,
    department_id INT
);

-- Departments table
CREATE TABLE IF NOT EXISTS raw.departments (
    department_id INT PRIMARY KEY,
    department_name TEXT
);

-- Jobs table
CREATE TABLE IF NOT EXISTS raw.jobs (
    job_id INT PRIMARY KEY,
    job_title TEXT,
    min_salary INT,
    max_salary INT
);

--****************************************************************************************************************************************--
--PostgreSQL FULL OUTER JOIN
--The FULL OUTER JOIN combine data from two tables and returns all rows from both tables, including matching and non-matching rows from both sides.
--the FULL OUTER JOIN combines the results of both the left join and the right join.
--****************************************************************************************************************************************--
--creating a sample table to illustrate full outer join

CREATE TABLE departments (
  department_id serial PRIMARY KEY,
  department_name VARCHAR (255) NOT NULL
);
CREATE TABLE employees (
  employee_id serial PRIMARY KEY,
  employee_name VARCHAR (255),
  department_id INTEGER
);
INSERT INTO departments (department_name)
VALUES
  ('Sales'),
  ('Marketing'),
  ('HR'),
  ('IT'),
  ('Production');
INSERT INTO employees (employee_name, department_id)
VALUES
  ('Bette Nicholson', 1),
  ('Christian Gable', 1),
  ('Joe Swank', 2),
  ('Fred Costner', 3),
  ('Sandra Kilmer', 4),
  ('Julia Mcqueen', NULL);
  
--1) Basic FULL OUTER JOIN example
--The FULL OUTER JOIN to query data from both employees and departments tables:
--The query retrieves a complete list of all employees and all departments
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id;
--2) Using FULL OUTER JOIN with WHERE clause example
--This query is designed to identify departments that have no employees assigned to them
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id
WHERE
  employee_name IS NULL;  
--The following example use the FULL OUTER JOIN cluase with a WHERE clause to find employees who do not belong to any department
SELECT
  employee_name,
  department_name
FROM
  employees e
FULL OUTER JOIN departments d
  ON d.department_id = e.department_id
WHERE
  department_name IS NULL;
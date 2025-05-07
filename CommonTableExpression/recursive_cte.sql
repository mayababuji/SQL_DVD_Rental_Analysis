--*********************************************************************************************************************--
--PostgreSQL Recursive CTE
--A recursive CTE allows you to perform recursion within a query using the WITH RECURSIVE syntax.
--Recursive queries in PostgreSQL allow you to process hierarchical or graph-based data by repeatedly executing a query and combining the results. 
--They're implemented using Common Table Expressions (CTEs) with the WITH RECURSIVE syntax.
--*********************************************************************************************************************--
--1) Setting up a sample table
CREATE TABLE employees_recursive_practice (
  employee_id SERIAL PRIMARY KEY,
  full_name VARCHAR NOT NULL,
  manager_id INT
);

INSERT INTO employees_recursive_practice (employee_id, full_name, manager_id)
VALUES
  (1, 'Michael North', NULL),
  (2, 'Megan Berry', 1),
  (3, 'Sarah Berry', 1),
  (4, 'Zoe Black', 1),
  (5, 'Tim James', 1),
  (6, 'Bella Tucker', 2),
  (7, 'Ryan Metcalfe', 2),
  (8, 'Max Mills', 2),
  (9, 'Benjamin Glover', 2),
  (10, 'Carolyn Henderson', 3),
  (11, 'Nicola Kelly', 3),
  (12, 'Alexandra Climo', 3),
  (13, 'Dominic King', 3),
  (14, 'Leonard Gray', 4),
  (15, 'Eric Rampling', 4),
  (16, 'Piers Paige', 7),
  (17, 'Ryan Henderson', 7),
  (18, 'Frank Tucker', 8),
  (19, 'Nathan Ferguson', 8),
  (20, 'Kevin Rampling', 8);

  ---2) Basic PostgreSQL recursive query example
--The following statement uses a recursive CTE to find all subordinates of the manager with the id 2.
  WITH RECURSIVE subordinates AS (
    ---- Base case (non-recursive term) The starting point that provides initial rows
  SELECT
    employee_id,
    manager_id,
    full_name
  FROM
    employees_recursive_practice
  WHERE
    employee_id = 2
  UNION
  -- Recursive case (recursive term) References the CTE itself to build upon previous results
  SELECT
    e.employee_id,
    e.manager_id,
    e.full_name
  FROM
    employees_recursive_practice e
    INNER JOIN subordinates s ON s.employee_id = e.manager_id
)
SELECT * FROM subordinates;
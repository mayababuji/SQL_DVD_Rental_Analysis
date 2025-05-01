--****************************************************************************************************************************************--
--PostgreSQL Self-Join
--A self-join is a regular join that joins a table to itself. 
--ISelf-joins are very useful for querying hierarchical data or comparing rows within the same table.
--****************************************************************************************************************************************--

--1) Querying hierarchical data example

CREATE TABLE employee (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR (255) NOT NULL,
  last_name VARCHAR (255) NOT NULL,
  manager_id INT,
  FOREIGN KEY (manager_id) REFERENCES employee (employee_id) ON DELETE CASCADE
);
INSERT INTO employee (employee_id, first_name, last_name, manager_id)
VALUES
  (1, 'Windy', 'Hays', NULL),
  (2, 'Ava', 'Christensen', 1),
  (3, 'Hassan', 'Conner', 1),
  (4, 'Anna', 'Reeves', 2),
  (5, 'Sau', 'Norman', 2),
  (6, 'Kelsie', 'Hays', 3),
  (7, 'Tory', 'Goff', 3),
  (8, 'Salley', 'Lester', 3);

SELECT * FROM employee;

--The query shows each employee paired with their direct manager, including employees who don't have a manager (like the CEO).

SELECT
  e.first_name || ' ' || e.last_name employee,
  m.first_name || ' ' || m.last_name manager
FROM
  employee e
  LEFT JOIN employee m ON m.employee_id = e.manager_id
ORDER BY
  manager;

--2) Comparing the rows with the same table
--The following query finds all pairs of films that have the same length

SELECT
  f1.title,
  f2.title,
  f1.length
FROM
  film f1
  INNER JOIN film f2 ON f1.film_id > f2.film_id
  AND f1.length = f2.length;

--3) Self-Join with INNER JOIN Example
--INNER JOIN only returns:Employees who HAVE a manager Excludes Top-level employees with no manager (CEO, etc.)

  SELECT 
    emp.first_name || ' ' || emp.last_name AS employee,
    mgr.first_name || ' ' || mgr.last_name AS manager
FROM 
    employee emp
INNER JOIN 
    employee mgr ON emp.manager_id = mgr.employee_id
ORDER BY 
    manager, employee;
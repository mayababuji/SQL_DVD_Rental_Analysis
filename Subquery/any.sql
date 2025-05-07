--*********************************************************************************************************************--
--PostgreSQL ANY 
--The PostgreSQL ANY operator compares a value with a set of values returned by a subquery.
-- Returns TRUE if at least one comparison is true

-- Returns FALSE if the subquery returns no rows

-- Works with both subqueries and arrays
-- Synonym: SOME (functionally identical to ANY)
-- | Clause   | Checks If Value...               | Example Use Case           | Comparable To   |
-- | -------- | -------------------------------- | -------------------------- | --------------- |
-- | `IN`     | Is equal to any in a list        | department\_id IN (1,2,3)  | = ANY(...)      |
-- | `ANY`    | Satisfies   condition with any   | salary > ANY(subquery)     | More flexible   |
-- | `EXISTS` | Subquery    returns any row      | EXISTS (SELECT 1 FROM ...) | Existence check |
-- | `ALL`    | Satisfies condition for   all    | salary > ALL(subquery)     | Universal test  |

--*********************************************************************************************************************--
--Setting up a sample table

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

CREATE TABLE managers(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL
);

INSERT INTO employees (first_name, last_name, salary)
VALUES
('Bob', 'Williams', 45000.00),
('Charlie', 'Davis', 55000.00),
('David', 'Jones', 50000.00),
('Emma', 'Brown', 48000.00),
('Frank', 'Miller', 52000.00),
('Grace', 'Wilson', 49000.00),
('Harry', 'Taylor', 53000.00),
('Ivy', 'Moore', 47000.00),
('Jack', 'Anderson', 56000.00),
('Kate', 'Hill',  44000.00),
('Liam', 'Clark', 59000.00),
('Mia', 'Parker', 42000.00);

INSERT INTO managers(first_name, last_name, salary)
VALUES
('John', 'Doe',  60000.00),
('Jane', 'Smith', 55000.00),
('Alice', 'Johnson',  58000.00);
--1) Using ANY operator with the = operator example

SELECT
  *
FROM
  employees
WHERE
  salary = ANY (
    SELECT
      salary
    FROM
      managers
  );

--2) Using ANY operator with > operator example
SELECT
  *
FROM
  employees
WHERE
  salary > ANY (
    SELECT
      salary
    FROM
      managers
  );
--3) Using ANY operator with < operator example

SELECT
  *
FROM
  employees
WHERE
  salary < ANY (
    SELECT
      salary
    FROM
      managers
  );

--*********************************************************************************************************************--
--PostgreSQL ALL operator
--The ALL operator in PostgreSQL is a comparison operator that allows you to compare a value to every value in a list or subquery result. 
--It returns TRUE only if the comparison is true for ALL values in the set.
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
('Bob', 'Williams', 75000.00),
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
--1) Using the ALL operator with the greater than operator (>) example
SELECT
  *
FROM
  employees
WHERE
  salary > ALL(
    select
      salary
    from
      managers
  );
--2) Using the ALL operator with the less than operator (<) example
SELECT
  *
FROM
  employees
WHERE
  salary < ALL(
    select
      salary
    from
      managers
  )
ORDER BY salary DESC;
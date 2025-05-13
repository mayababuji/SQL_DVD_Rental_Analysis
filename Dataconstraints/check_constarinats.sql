--*********************************************************************************************************************--
--PostgreSQL CHECK Constraints
--*********************************************************************************************************************--

--1) Defining PostgreSQL CHECK constraint for a new table
--In this statement, the employees table has one CHECK constraint that enforces the values in the salary column greater than zero.
CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (50) NOT NULL,
  last_name VARCHAR (50) NOT NULL,
  birth_date DATE NOT NULL,
  joined_date DATE NOT NULL,
  salary numeric CHECK(salary > 0)
);

--The below insert statment will fail the employees table has one CHECK constraint that enforces the values in the salary column greater than zero.
--ERROR:  new row for relation "employees" violates check constraint "employees_salary_check"
-- Failing row contains (1, John, Doe, 1972-01-01, 2015-07-01, -100000). 
-- Detail: Failing row contains (1, John, Doe, 1972-01-01, 2015-07-01, -100000).
INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Doe', '1972-01-01', '2015-07-01', -100000);
--2) Adding PostgreSQL CHECK constraints for existing tables

ALTER TABLE employees
ADD CONSTRAINT joined_date_check
CHECK ( joined_date >  birth_date );

--attempt to insert a new row into the employees table with the joined date is earlier than the birth date
-- ERROR:  new row for relation "employees" violates check constraint "joined_date_check"
-- Failing row contains (2, John, Doe, 1990-01-01, 1989-01-01, 100000). 
-- Detail: Failing row contains (2, John, Doe, 1990-01-01, 1989-01-01, 100000).

INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Doe', '1990-01-01', '1989-01-01', 100000);

--3) Using functions in CHECK constraints

--The following example adds a CHECK constraint to ensure that the first name has at least 3 characters:
ALTER TABLE employees
ADD CONSTRAINT first_name_check
CHECK ( LENGTH(TRIM(first_name)) >= 3);

--The following statement will fail because it attempts to insert a row into the employees table with the first name that has 2 characters
-- ERROR:  new row for relation "employees" violates check constraint "first_name_check"
-- Failing row contains (3, Ab, Doe, 1990-01-01, 2008-01-01, 100000). 
-- Detail: Failing row contains (3, Ab, Doe, 1990-01-01, 2008-01-01, 100000).

INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary)
VALUES ('Ab', 'Doe', '1990-01-01', '2008-01-01', 100000);

---4) Removing a CHECK constraint example
--The following statement removes the CHECK constraint joined_date_check from the employees table
ALTER TABLE employees
DROP CONSTRAINT joined_date_check;
--Since the constraint is removed the following insert statement will work

INSERT INTO employees (first_name, last_name, birth_date, joined_date, salary)
VALUES ('John', 'Doe', '1990-01-01', '1989-01-01', 100000);
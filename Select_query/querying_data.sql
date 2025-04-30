---*********************************************************************************************************************************---
--PPostgreSQL SELECT examples
---*********************************************************************************************************************************---
--1) Using PostgreSQL SELECT statement to query data from one column example
SELECT first_name FROM customer;
--2) Using PostgreSQL SELECT statement to query data from multiple columns example
SELECT first_name,last_name, email FROM customer;
--3) Using PostgreSQL SELECT statement to query data from all columns of a table example
SELECT * FROM customer;
--4) Using PostgreSQL SELECT statement with expressions example.
--Here expression || concatenates the first name, space, and last name of every customer. 
--The first column of the output doesn't have a name but ?column?. to resolve that us alias as in Step 5
SELECT first_name || ' ' || last_name, email FROM customer;
--5) Using PostgreSQL SELECT statement with expressions example using The AS keyword is optional so both the queries below yields the same result
SELECT first_name || ' ' || last_name AS full_name,email FROM customer;
SELECT first_name || ' ' || last_name full_name,email FROM customer;
--6) Using PostgreSQL SELECT statement without a FROM clause which is optional 
--NOW() It'll return the current date and time of the PostgreSQL server.
--PostgreSQL evaluates the FROM clause before the SELECT clause
--In PostgreSQL, the FROM clause is optional.
SELECT NOW();
---*********************************************************************************************************************************---
---PostgreSQL column alias examples---
---*********************************************************************************************************************************---
--1) Assigning a column alias to a column example
--Method 1
SELECT 
    first_name AS forename,
    last_name AS surname
FROM 
    customer;
--Method 2
SELECT 
    first_name forename,
    last_name surname
FROM 
    customer;
--2) Assigning a column alias to an expression example
-- concantenate first name space and lastname and alias it as column name fullname
SELECT
    first_name || ' ' || last_name fullname
FROM
   customer;
--3) Column aliases that contain spaces

SELECT
   first_name || ' ' || last_name "full name"
FROM
   customer;
---*********************************************************************************************************************************---
--PostgreSQL ORDER BY examples
--PostgreSQL evaluates the clauses in the SELECT statement in the following order: FROM, SELECT, and ORDER BY:
--Due to the order of evaluation, if you have a column alias in the SELECT clause, 
--you can use it in the ORDER BY clause.
---*********************************************************************************************************************************---
--1) Using PostgreSQL ORDER BY clause to sort rows by one column in ASC (optional)
--Method 1
SELECT
  first_name forename,
  last_name surname
FROM
  customer
ORDER BY
  first_name ASC;
--Method 2
SELECT
  first_name forename,
  last_name surname
FROM
  customer
ORDER BY
  first_name;
--2) Using PostgreSQL ORDER BY clause to sort rows by one column in descending order
SELECT
  first_name forename,
  last_name surname
FROM
  customer
ORDER BY
  last_name DESC;
--3) Using PostgreSQL ORDER BY clause to sort rows by multiple columns
--the ORDER BY clause sorts rows by values in the first name column first. 
--Then it sorts the sorted rows by values in the last name column.
SELECT
  first_name,
  last_name
FROM
  customer
ORDER BY
  first_name ASC,
  last_name DESC;
--4) Using PostgreSQL ORDER BY clause to sort rows by expressions
--The LENGTH() function accepts a string and returns the length of that string.
--Because the ORDER BY clause is evaluated after the SELECT clause, 
--the column alias len is available and can be used in the ORDER BY clause

SELECT
  email,
  LENGTH(email) len
FROM
  customer
ORDER BY
  len DESC;
--5) PostgreSQL ORDER BY clause and NULL
CREATE TABLE sort_demo(num INT);

INSERT INTO sort_demo(num)
VALUES
  (1),
  (2),
  (3),
  (null);
--To place NULL before other non-null values, you use the NULLS FIRST option:
  SELECT
  num
FROM
  sort_demo
ORDER BY
  num NULLS FIRST;
--sorts values in the num column of the sort_demo table in descending order null being the first value
  SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC;
--sorts values in the num column of the sort_demo table in descending order null being the last value
  SELECT
  num
FROM
  sort_demo
ORDER BY
  num DESC NULLS LAST;
--****************************************************************************************************************************************************************-
--PostgreSQL SELECT DISTINCT clause (emoves duplicate rows from a result set)
--***************************************************************************************************************************************************************--

CREATE TABLE colors(
  id SERIAL PRIMARY KEY,
  bcolor VARCHAR,
  fcolor VARCHAR
);

INSERT INTO
  colors (bcolor, fcolor)
VALUES
  ('red', 'red'),
  ('red', 'red'),
  ('red', NULL),
  (NULL, 'red'),
  (NULL, NULL),
  ('green', 'green'),
  ('blue', 'blue'),
  ('blue', 'blue');
 -- 1) PostgreSQL SELECT DISTINCT one column example
--selects unique values from the bcolor column of the t1 table and sorts the result set in alphabetical order by using the ORDER BY clause
  SELECT
  DISTINCT bcolor
FROM
  colors
ORDER BY
  bcolor;
  --2) SELECT DISTINCT on multiple columns
--statement applies the SELECT DISTINCT clause to both bcolor and fcolor columns:
  SELECT
  DISTINCT bcolor, fcolor
FROM
  colors
ORDER BY
  bcolor,
  fcolor;
 --3) Using the SELECT DISTINCT clause in practice example how many rental rates for films from the film table:
 SELECT DISTINCT
  rental_rate
FROM
  film
ORDER BY
  rental_rate;

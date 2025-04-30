--****************************************************************************************************************************************************************-
-- PostgreSQL WHERE clause (PostgreSQL evaluates the WHERE clause after the FROM clause but before the SELECT and ORDER BY clause)
--If you use column aliases in the SELECT clause, you cannot use them in the WHERE clause
--****************************************************************************************************************************************************************-
--1)  Using WHERE clause with the equal (=) operator example
SELECT
  last_name,
  first_name forename
FROM
  customer
WHERE
  first_name = 'Jamie';

  --the below query will fail ERROR:  column "forename" does not exist WHERE clause is evaluated before the SELECT query

  SELECT
  last_name,
  first_name forename
FROM
  customer
WHERE
  forename = 'Jamie';

--2) Using the WHERE clause with the AND operator example
SELECT
  last_name surname,
  first_name forename
FROM
  customer
WHERE
  first_name = 'Jamie'
  AND last_name = 'Rice';
--3) Using the WHERE clause with the OR operator example
SELECT
  first_name forename,
  last_name surname
FROM
  customer
WHERE
  last_name = 'Rodriguez'
  OR first_name = 'Adam';
  --4) Using the WHERE clause with the IN operator example

  SELECT
  first_name forename,
  last_name surname
FROM
  customer
WHERE
  first_name IN ('Ann', 'Anne', 'Annie');
  --5) Using the WHERE clause with the LIKE operator example The 'Ann%' pattern matches any strings that start with 'Ann'.
  --'%Ann'pattern matches any strings that ends with 'Ann' .'%Ann%' pattern matches any strings  with 'Ann'
  SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Ann%';
  --6) Using the WHERE clause with the BETWEEN operator example
  --finds customers whose first names start with the letter A and contains 3 to 5 characters by using the BETWEEN operator.
  SELECT
  first_name,
  LENGTH(first_name) name_length
FROM
  customer
WHERE
  first_name LIKE 'A%'
  AND LENGTH(first_name) BETWEEN 3
  AND 5
ORDER BY
  name_length;
  --7) Using the WHERE clause with the not equal operator (<>) example
--finds customers whose first names start with Dan and last names are not Thomas:
  SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE 'Dan%'
  AND last_name <> 'Thomas';
---finds customers whose first names start with Dan and last names not starts with Dan:  
SELECT first_name, last_name
FROM customer
WHERE first_name LIKE 'Dan%'
AND last_name NOT LIKE 'Dan%'

ORDER BY last_name, first_name;

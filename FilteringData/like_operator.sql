--****************************************************************************************************************************************--
--PostgreSQL LIKE operator
--The LIKE operator returns true if the value matches the pattern
--The NOT LIKE operator returns true when the value does not match the pattern
--If the pattern does not contain any wildcard character, the LIKE operator behaves like the equal (=) operator.
--****************************************************************************************************************************************--
--1) Basic LIKE operator examples
--the LIKE operator with a pattern that doesn’t have any wildcard characters:
SELECT 'Apple' LIKE 'Apple' AS result;
--the LIKE operator to match any string that starts with the letter A:
SELECT 'Apple' LIKE 'A%' AS result;
--2) Using the LIKE operator with table data
--the LIKE operator to find customers whose first names contain the string er :
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '%er%'
ORDER BY
  first_name;
  --3) Using the LIKE operator a pattern that contains both wildcards
-- The pattern _her% matches any strings that satisfy the following conditions:

-- The first character can be anything.
-- The following characters must be 'her'.
-- There can be any number (including zero) of characters after 'her'.
  SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name LIKE '_her%'
ORDER BY
  first_name;

 --4) PostgreSQL NOT LIKE examples
 --the NOT LIKE operator to find customers whose first names do not begin with Jen:
 SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name NOT LIKE 'Jen%'
ORDER BY
  first_name; 
--PostgreSQL extensions of the LIKE operator
--PostgreSQL ILIKE operator, which is similar to the LIKE operator, but allows for case-insensitive matching.
--the BAR% pattern matches any string that begins with BAR, Bar, BaR, and so on.
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ILIKE 'BAR%';
--PostgreSQL also provides some operators that mirror the functionality of LIKE, NOT LIKE, ILIKE, NOT ILIKE
--   Operator	Equivalent
-- ~~	LIKE
-- ~~*	ILIKE
-- !~~	NOT LIKE
-- !~~*	NOT ILIKE

--the ~~ operator to find a customer whose first names start with the string Dar:
SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  first_name ~~ 'Dar%'
ORDER BY
  first_name;

  ---PostgreSQL LIKE operator with ESCAPE option

  CREATE TABLE t(
   message text
);
INSERT INTO t(message)
VALUES('The rents are now 10% higher than last month'),
      ('The new film will have _ in the title');
---LIKE operator with the ESCAPE option to treat the % followed by the number 10 as a regular character:
--In the pattern %10$%%, the first and last % are the wildcard characters whereas the % appears after the escape character $ is a regular character.      
SELECT * FROM t
WHERE message LIKE '%10$%%' ESCAPE '$';
--****************************************************************************************************************************************--
--PostgreSQL LIMIT clause
--LIMIT is an optional clause of the SELECT statement that constrains the number of rows returned by the query.
--If you want to skip a number of rows before returning the row_count rows, you can use OFFSET clause placed after the LIMIT clause:
--****************************************************************************************************************************************--
--1) Using PostgreSQL LIMIT to constrain the number of returned row
--get the first five films sorted by film_id
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT
  5;
--2) Using the LIMIT clause with the OFFSET clause example
--To retrieve 4 films starting from the fourth one ordered by film_id  
-- First, sort films by film id in ascending order.
-- Second, skip the first three rows using the OFFSET 3 clause.
-- Second, take the next four rows using the LIMIT 4 clause.
SELECT
  film_id,
  title,
  release_year
FROM
  film
ORDER BY
  film_id
LIMIT 4 OFFSET 3;
--3) Using LIMIT OFFSET to get top/bottom N rows
--LIMIT clause to retrieve the top 10 most expensive films by rental rate:
-- First, sort all the films by rental rates from high to low using the ORDER BY rental_rate DESC clause.
-- Second, take only 10 rows from the top using the LIMIT 10 clause.
SELECT
  film_id,
  title,
  rental_rate
FROM
  film
ORDER BY
  rental_rate DESC
LIMIT
  10;
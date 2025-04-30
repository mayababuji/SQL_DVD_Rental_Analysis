--****************************************************************************************************************************************--
--PostgreSQL OR operator
--****************************************************************************************************************************************--
--1) Basic PostgreSQL OR operator examples
--the OR operator to combine true with true, which returns true:
SELECT true OR true AS result;
--the OR operator to combine true with false, which returns true:
SELECT true OR false AS result;
--the OR operator to combine true with null, which returns true:
SELECT true OR null AS result;
--the OR operator to combine false with false, which returns false:
SELECT false OR false AS result;
-- the OR operator to combine false with null, which returns null:
SELECT false OR null AS result;
--the OR operator to combine null with null, which returns null:
SELECT null OR null AS result;
--2) Using the OR operator in the WHERE clause
--find the films that have a rental rate is 0.99 or 2.99:
SELECT
  title,
  rental_rate
FROM
  film
WHERE
  rental_rate = 0.99 OR
  rental_rate = 2.99;
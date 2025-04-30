--****************************************************************************************************************************************--
--PostgreSQL AND operator
--****************************************************************************************************************************************--
--1) Basic PostgreSQL AND operator examples
--the AND operator to combine two true values, which returns true:
SELECT true AND true AS result;
--the AND operator to combine true with false, which returns false:
SELECT true AND false AS result;
-- the AND operator to combine true with null, which returns null:
SELECT true AND null AS result;
--the AND operator to combine false with false, which returns false:
SELECT false AND false AS result;
--the AND operator to combine false with null, which returns false:
SELECT false AND null AS result;
--the AND operator to combine null with null, which returns null:
SELECT null AND null AS result;
--2) Using the AND operator in the WHERE clause
--find the films that have a length greater than 180 and a rental rate less than 1:
SELECT
  title,
  length,
  rental_rate
FROM
  film
WHERE
  length > 180
  AND rental_rate < 1;
--****************************************************************************************************************************************--
--PostgreSQL IN operator
--The IN operator allows you to check whether a value matches any value in a list of values.
--****************************************************************************************************************************************--
--1) Using the PostgreSQL IN operator with a list of numbers
--IN operator to retrieve information about the film with id 10, 2, and 3:
SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id in (10, 2, 3);
  --equivalent query 
  SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id = 1
  OR film_id = 2
  OR film_id = 3;
  --2) Using the PostgreSQL IN operator with a list of strings
  -- find the actors who have the last name in the list 'Allen', 'Chase', and 'Davis':
  SELECT
  first_name,
  last_name
FROM
  actor
WHERE
  last_name IN ('Allen', 'Chase', 'Davis')
ORDER BY
  last_name;
  --3) Using the PostgreSQL IN operator with a list of dates
  --find payments whose payment dates are in a list of dates: 2007-02-15 and 2007-02-16:
--   To match the values in the payment_date column with a list of dates, you need to cast them to date values that have the date part only.
-- To do that you use the :: cast operator:
  SELECT
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date::date IN ('2007-02-15', '2007-02-16');
  --4 PostgreSQL NOT IN operator example
  --retrieve films whose id is not 1, 2, or 3:
  SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id NOT IN (1, 2, 3)
ORDER BY
  film_id;
  -- equivalnet query
  SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id <> 1
  AND film_id <> 2
  AND film_id <> 3
ORDER BY
  film_id;
--****************************************************************************************************************************************--
--PostgreSQL RIGHT JOIN
--****************************************************************************************************************************************--
--1) Basic PostgreSQL RIGHT JOIN examples
SELECT
  film.film_id,
  film.title,
  inventory.inventory_id
FROM
  inventory
RIGHT JOIN film
  ON film.film_id = inventory.film_id
ORDER BY
  film.title;
--equivalent query using alias
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f
  ON f.film_id = i.film_id
ORDER BY
  f.title;
--Since the film and inventory table has the film_id column, you can use the USING syntax:

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f
  USING(film_id)
ORDER BY
  f.title;
--2) PostgreSQL RIGHT JOIN with a WHERE clause
--This query identifies films that have no physical inventory items in your database
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  inventory i
RIGHT JOIN film f USING(film_id)
WHERE i.inventory_id IS NULL
ORDER BY
  f.title;
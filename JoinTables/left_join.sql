--****************************************************************************************************************************************--
--PostgreSQL create a new table and insert values into it
--****************************************************************************************************************************************--
--LEFT JOIN is also referred to as LEFT OUTER JOIN.
--1) Basic PostgreSQL LEFT JOIN examples
--The query shows all films in the database along with their physical inventory items (like DVD copies), 
--including films that currently have no inventory available.
SELECT
  film.film_id,
  film.title,
  inventory.inventory_id
FROM
  film
  LEFT JOIN inventory ON inventory.film_id = film.film_id
ORDER BY
  film.title;
-- equivalent query with alias

SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i ON i.film_id = f.film_id
ORDER BY
  i.inventory_id;

--Because the film and inventory tables share the same film_id column, you can use the USING syntax:
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING(film_id)
ORDER BY
  i.inventory_id;
--2) Using PostgreSQL LEFT JOIN with WHERE clause
--the LEFT JOIN clause to join the inventory and film tables. 
--It includes a WHERE clause that identifies the films that are not present in the inventory
SELECT
  f.film_id,
  f.title,
  i.inventory_id
FROM
  film f
  LEFT JOIN inventory i USING (film_id)
WHERE
  i.film_id IS NULL
ORDER BY
  f.title;

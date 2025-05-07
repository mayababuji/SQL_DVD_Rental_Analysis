--*********************************************************************************************************************--
--PostgreSQL subquery 
--*********************************************************************************************************************--
---1) Basic PostgreSQL subquery example
SELECT
  city
FROM
  city
WHERE
  country_id = (
    SELECT
      country_id
    FROM
      country
    WHERE
      country = 'United States' --- returns one value
  )
ORDER BY--Retrieves all city names from the city table
  city;

  --2) Using a subquery with the IN opera

  SELECT
  film_id,
  title
FROM
  film
WHERE
  film_id IN (
    SELECT
      film_id
    FROM
      film_category
      INNER JOIN category USING(category_id)
    WHERE
      name = 'Action'---Returns a list of film_id values for all Action movies
  )
ORDER BY--Only includes films whose IDs are in the Action movies list
  film_id;
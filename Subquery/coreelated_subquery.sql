--*********************************************************************************************************************--
--PostgreSQL Correlated Subquery
--*********************************************************************************************************************--
--This query uses a correlated subquery to find films that are longer than the average length for their specific rating
-- Outer Query: Processes each row in the film table (aliased as f)

-- Inner Query: For each film, calculates the average length of films with:

-- The same rating as the current film (f.rating)

-- Comparison: Includes the film only if its length exceeds this calculated average
SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);
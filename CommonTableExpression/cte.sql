--*********************************************************************************************************************--
--PostgreSQL CTE
-- Why Use CTEs?
-- Makes complex queries easier to read.

-- Lets you reuse results of subqueries.

-- Can be chained or recursive (for advanced use).
--syntax  WITH starts the CTE
-- WITH cte_name AS (
--CTE query
--   SELECT column1, column2
--   FROM some_table
--   WHERE condition
-- )
---- Main query using the CTE
-- SELECT *
-- FROM cte_name
-- WHERE column2 > 100;

--*********************************************************************************************************************--

--1) Basic PostgreSQL common table expression example
--This PostgreSQL query uses a Common Table Expression (CTE) to find all action movies and their lengths from a DVD rental database.
--WITH action_films AS (...)Creates a temporary "view" called action_films that exists only for this query
WITH action_films AS (
  SELECT
    f.title,
    f.length
  FROM
    film f
    INNER JOIN film_category fc USING (film_id) -- Links films to categories
    INNER JOIN category c USING(category_id)  -- Gets category names
  WHERE
    c.name = 'Action' -- Filters for Action only
)
SELECT * FROM action_films; -- Shows all columns from our temporary results

--2) Join a CTE with a table example
--The following example join a CTE with a table to find the staff and rental count for each.This PostgreSQL query uses a Common Table Expression (CTE) to analyze DVD rental activity by staff members

WITH cte_rental AS (
  SELECT
    staff_id,
    COUNT(rental_id) rental_count
  FROM
    rental
  GROUP BY
    staff_id
)
SELECT
  s.staff_id,
  first_name,
  last_name,
  rental_count
FROM
  staff s
  INNER JOIN cte_rental USING (staff_id);
  --3) Multiple CTEs example
-- It generates a single-row report showing key metrics about:
--Financial Reporting: Track total revenue and customer base size
-- Film characteristics (rental rates and lengths)
--Inventory Management: Understand film characteristics (average rental price, length range)
-- Customer base (total customers and payments)

  WITH film_stats AS (
    -- CTE 1: Calculate film statistics
    SELECT
        AVG(rental_rate) AS avg_rental_rate,
        MAX(length) AS max_length,
        MIN(length) AS min_length
    FROM film
),
customer_stats AS (
    -- CTE 2: Calculate customer statistics
    SELECT
        COUNT(DISTINCT customer_id) AS total_customers,
        SUM(amount) AS total_payments
    FROM payment
)
-- Main query using the CTEs
SELECT
    ROUND((SELECT avg_rental_rate FROM film_stats), 2) AS avg_film_rental_rate,
    (SELECT max_length FROM film_stats) AS max_film_length,
    (SELECT min_length FROM film_stats) AS min_film_length,
    (SELECT total_customers FROM customer_stats) AS total_customers,
    (SELECT total_payments FROM customer_stats) AS total_payments;
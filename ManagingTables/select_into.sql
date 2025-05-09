--*********************************************************************************************************************--
--PostgreSQL SELECT INTO
--The PostgreSQL SELECT INTO statement creates a new table and inserts data returned from a query into the table.
-- SELECT INTO vs. CREATE TABLE
-- Feature	            SELECT INTO	                                CREATE TABLE (+ INSERT)
-- Use Case	            Quick table creation from query results	    Explicit table definition with full control
-- Schema Definition	Inferred from query results	                Explicitly defined by you
-- Constraints/Indexes	Not carried over (unless in query)	        Fully customizable
-- Ownership	        Created in current schema	                You specify schema
-- Best For	            One-off temp tables, quick analysis	        Permanent tables, production schemas

--*********************************************************************************************************************--

--1) Basic PostgreSQL SELECT INTO statement example
--The following statement uses the SELECT INTO statement to create a new table called film_r that contains films with the rating R and rental duration 5 days from the film table

SELECT
    film_id,
    title,
    rental_rate
INTO TABLE film_r
FROM
    film
WHERE
    rating = 'R'
AND rental_duration = 5
ORDER BY
    title;

--2) Using the SELECT INTO statement to create a new temporary table
--The following example uses the SELECT INTO statement to create a temporary table named short_film that contains films whose lengths are under 60 minutes.

SELECT
    film_id,
    title,
    length
INTO TEMP TABLE short_film
FROM
    film
WHERE
    length < 60
ORDER BY
    title;
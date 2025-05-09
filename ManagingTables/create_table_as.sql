
--*********************************************************************************************************************--
--PostgreSQL CREATE TABLE AS
--The CREATE TABLE AS statement creates a new table and fills it with the data returned by a query
--*********************************************************************************************************************--
--PostgreSQL CREATE TABLE AS statement examples
--The following example uses the CREATE TABLE AS statement to create a new table that contains the films whose category is 1:
--the names and data types of the action_film table are derived from the columns of the SELECT clause.
CREATE TABLE action_film
AS
SELECT
    film_id,
    title,
    release_year,
    length,
    rating
FROM
    film
INNER JOIN film_category USING (film_id)
WHERE
    category_id = 1;
--If the SELECT clause contains expressions, it is a good practice to override the columns
--This example statement created a new table film_rating and filled it with the summary data from the film table. 
--It explicitly specified the column names for the new table instead of using the column names from the SELECT clause.

CREATE TABLE IF NOT EXISTS film_rating (rating, film_count)
AS
SELECT
    rating,
    COUNT (film_id)
FROM
    film
GROUP BY
    rating;
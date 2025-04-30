--****************************************************************************************************************************************--
--PostgreSQL FETCH clause
--To conform with the SQL standard, PostgreSQL supports the FETCH clause to skip a certain number of rows and then fetch a specific number of rows.FETCH is used intead of LIMIT
--The FETCH clause is functionally equivalent to the LIMIT clause. If you plan to make your application compatible with other database systems, 
--you should use the FETCH clause because it follows the standard SQL.
--****************************************************************************************************************************************--

--select the first film sorted by titles in ascending order:
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST ROW ONLY;
-- select the first five films sorted by titles:
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
FETCH FIRST 5 ROW ONLY;
---skip a certain number of rows and retrieve a specific number of rows from a query.
SELECT
    film_id,
    title
FROM
    film
ORDER BY
    title
OFFSET 20 FETCH FIRST 10 ROWS ONLY;
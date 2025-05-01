--****************************************************************************************************************************************--
--PostgreSQL Table Aliases
--A table alias is a feature in SQL that allows you to assign a temporary name to a table during the execution of a query.
--****************************************************************************************************************************************--
--1) Basic PostgreSQL table alias example
SELECT f.title
FROM film AS f
ORDER BY f.title
LIMIT 5;
--AS is optional

SELECT f.title
FROM film f
ORDER BY f.title
LIMIT 5;
--2) Using table aliases in join clauses
--if alias is not used will face 
--1. Column Ambiguity Errors(If tables have columns with the same names, you'll get errors)
--2. Verbose, Hard-to-Read Queries (Without aliases, queries become longer and harder to maintain)
--3. Performance Impact(The database must:Resolve full table names for every column reference, Maintain longer identifiers in memory during execution)

SELECT
  c.customer_id,
  c.first_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p ON p.customer_id = c.customer_id
ORDER BY
  p.payment_date DESC;

--3) Using table aliases in self-join
--When you join a table to itself (a.k.a self-join), you need to use table aliases. This is because referencing the same table multiple times within a query will result in an error.
--find the title of the films which nas same length if the alias is not specified you will get ERROR:  table name "film" specified more than once 
SELECT
    f1.title,
    f2.title,
    f1.length
FROM
    film f1
INNER JOIN film f2
    ON f1.film_id <> f2.film_id AND
       f1.length = f2.length;
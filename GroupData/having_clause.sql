--****************************************************************************************************************************************--
--PostgreSQL HAVING
--The HAVING clause in PostgreSQL is used to filter groups of rows after the GROUP BY aggregation has been performed, similar to how WHERE filters rows before aggregation.
--PostgreSQL evaluates the HAVING clause after the FROM, WHERE, GROUP BY, and before the DISTINCT, SELECT, ORDER BY and LIMIT clauses.Because PostgreSQL evaluates the HAVING clause before the SELECT clause, you cannot use the column aliases in the HAVING clause.
-- Key Differences: HAVING vs WHERE
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Feature	    WHERE Clause	                   HAVING Clause  | 
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~       
-- Timing	    Filters before aggregation	        Filters after aggregation
-- Usage	     With or without GROUP BY	        Only with GROUP BY
-- Functions    Can't use aggregate functions	    Can use aggregate functions
-- Usage        Applied to rows                     Applied to group of rows

--****************************************************************************************************************************************--

--1) Using PostgreSQL HAVING clause with SUM function example
--This query identifies customers who have spent more than $200 in total, ranked from highest to lowest spenders
--HAVING SUM(amount) > 200 excludes all customers below this threshol
SELECT
  customer_id,
  SUM (amount) amount
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  amount DESC;
  --2) PostgreSQL HAVING clause with COUNT exam
  --The following statement adds the HAVING clause to select a store that has more than 300 customers
  SELECT
  store_id,
  COUNT (customer_id)
FROM
  customer
GROUP BY
  store_id
HAVING
  COUNT (customer_id) > 300;
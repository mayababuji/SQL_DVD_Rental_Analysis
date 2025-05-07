--*********************************************************************************************************************--
--PostgreSQL EXISTS operator
--It returns TRUE if the subquery returns at least one row, and FALSE if no rows are returned.
-- Returns TRUE if the subquery returns at least one row
-- Returns FALSE if the subquery returns no rows
-- Subquery content doesn't matter - Only checks for row existence (typically uses SELECT 1)
-- Often used with correlated subqueries (references outer query columns)
-- Stops evaluation after finding the first matching row (efficient)
--*********************************************************************************************************************--
--1) Basic EXISTS operator example
--The following example uses the EXISTS operator to check if the payment value is zero exists in the payment table:
SELECT

  EXISTS(
    SELECT
      1
    FROM
      payment
    WHERE
      amount = 0
  );

  --2) Using the EXISTS operator to check the existence of a row
  --or each customer in the customer table, the subquery checks the payment table to find if that customer made at least one payment (p.customer_id = c.customer_id) 
  --and the amount is greater than 11 ( amount > 11)

  SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;

  --2) NOT EXISTS example
  --The following example uses the NOT EXISTS operator to find customers who have not made any payment more than 11.

  SELECT
  first_name,
  last_name
FROM
  customer c
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      payment p
    WHERE
      p.customer_id = c.customer_id
      AND amount > 11
  )
ORDER BY
  first_name,
  last_name;

  --3) EXISTS and NULL example
  --The following example returns all rows from the customers table because the subquery in the EXISTS operator returns NULL:
  SELECT
  first_name,
  last_name
FROM
  customer
WHERE
  EXISTS(
    SELECT NULL
  )
ORDER BY
  first_name,
  last_name;
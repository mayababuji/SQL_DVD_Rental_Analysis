--****************************************************************************************************************************************--
--PostgreSQL BETWEEN operator
--****************************************************************************************************************************************--
--1) Using the PostgreSQL BETWEEN operator with numbers
--retrieve payments with payment_id is between 17503 and 17505:
SELECT
  payment_id,
  amount
FROM
  payment
WHERE
  payment_id BETWEEN 17503 AND 17505
ORDER BY
  payment_id;
--2) Using the PostgreSQL NOT BETWEEN example
--find payments with the payment_id not between 17503 and 17505:
SELECT
  payment_id,
  amount
FROM
  payment
WHERE
  payment_id NOT BETWEEN 17503 AND 17505
ORDER BY
  payment_id;
  --3) Using the PostgreSQL BETWEEN with a date range 
  --find payments whose payment dates are between 2007-02-15 and 2007-02-20 and amount more than 10:
  SELECT
  customer_id,
  payment_id,
  amount,
  payment_date
FROM
  payment
WHERE
  payment_date BETWEEN '2007-02-15' AND '2007-02-20'
  AND amount > 10
ORDER BY
  payment_date; 
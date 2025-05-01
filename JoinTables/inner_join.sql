--****************************************************************************************************************************************--
--PostgreSQL Inner Joins
--****************************************************************************************************************************************--
--1) Using PostgreSQL INNER JOIN to join two tables
-- find all the payment date and amount for a customer with customer_id.While each customer may have zero or many payments, 
--each payment belongs to one and only one customer.
SELECT
  customer.customer_id,
  customer.first_name,
  customer.last_name,
  payment.amount,
  payment.payment_date
FROM
  customer
  INNER JOIN payment ON payment.customer_id = customer.customer_id
ORDER BY
 customer.customer_id,
  payment.payment_date;
--To make the query shorter, you can use the table aliases:
SELECT
  c.customer_id,
  c.first_name,
  c.last_name,
  p.amount,
  p.payment_date
FROM
  customer c
  INNER JOIN payment p ON p.customer_id = c.customer_id
ORDER BY
  c.customer_id,
  p.payment_date;

--Since both tables have the same customer_id column, you can use the USING syntax
SELECT
  customer_id,
  first_name,
  last_name,
  amount,
  payment_date
FROM
  customer 
  INNER JOIN payment  USING(customer_id)
ORDER BY
  customer_id,
  payment_date;

--2) Using PostgreSQL INNER JOIN to join three tables
--Each staff member can handle zero or multiple payments, with each payment being processed by one and only one staff member.
--Similarly, each customer can make zero or multiple payments, and each payment is associated with a single customer
--query retrieves payment information along with related customer and staff details from a database 
--The query shows who paid, how much they paid, when they paid, and which staff member processed the payment.
SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name customer_name,
  s.first_name || ' ' || s.last_name staff_name,
  p.amount,
  p.payment_date
FROM
  payment p
  INNER JOIN customer c USING (customer_id)
  INNER JOIN staff s using(staff_id)
ORDER BY
  payment_date;
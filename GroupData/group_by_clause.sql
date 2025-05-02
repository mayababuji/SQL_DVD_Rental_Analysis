--****************************************************************************************************************************************--
--PostgreSQL GroupBY
-- The GROUP BY clause in PostgreSQL is used to group rows that have the same values in specified columns into aggregated data. 
-- It's typically used with aggregate functions (COUNT, SUM, AVG, MAX, MIN, etc.) to perform calculations on each group of rows.
--PostgreSQL evaluates the GROUP BY clause after the FROM and WHERE clauses and before the HAVING SELECT, DISTINCT, ORDER BY and LIMIT clauses
--****************************************************************************************************************************************--
--1) Using PostgreSQL GROUP BY without an aggregate function example
--Returns only unique customer_id values with group by .without groupby returns all rows from the payment table
-- we use group by when we need unique When you need distinct values
-- In this example, the GROUP BY clause works like the DISTINCT operator.

SELECT
  customer_id
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  customer_id;
--2) Using PostgreSQL GROUP BY with SUM() function example
--The following query uses the GROUP BY clause to retrieve the total payment paid by each customer.To analyze total spending per customer.
--GROUP BY  : Groups all rows with the same customer_id together.Ensures that calculations (like SUM(amount)) are done per customer
--SUM(amount)Adds up all amount values for each customer.
SELECT
  customer_id,
  SUM (amount)
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  customer_id;
--The following statement uses the ORDER BY clause with GROUP BY clause to sort the groups by total payments .Identifying Top-Spending Customers
  SELECT
  customer_id,
  SUM (amount)
FROM
  payment
GROUP BY
  customer_id
ORDER BY
  SUM (amount);

--3) Using PostgreSQL GROUP BY clause with the JOIN clause
--This query helps identify your best customers by total spending
--INNER JOIN customer USING (customer_id) :Links payment records to customer details USING syntax is used when join columns have identical names
SELECT
  first_name || ' ' || last_name full_name,
  SUM (amount) amount
FROM
  payment
  INNER JOIN customer USING (customer_id)
GROUP BY
  full_name
ORDER BY
  amount DESC;

--4) Using PostgreSQL GROUP BY with COUNT() function example
 --the GROUP BY clause divides the rows in the payment table into groups and groups them by value in the staff_id column. For each group, it counts the number of rows using the COUNT() function.
--This query analyzes payment processing activity by staff members.Performance Evaluation,Workload Distribution
--COUNT(payment_id): Counts the number of payments each staff member handled
--GROUP BY staff_id Aggregates results by each unique staff member.Creates one row per staff member with their total count
SELECT
	staff_id,
	COUNT (payment_id)
FROM
	payment
GROUP BY
	staff_id;
--5) Using PostgreSQL GROUP BY with multiple columns
--This query provides a detailed breakdown of payment transactions by customer-staff combinations.Identify which staff members regularly serve specific customers.Detect potential customer-staff relationship patterns
--Measure which staff generate the most revenue from each customer
--customer_id, staff_id Creates unique combinations of customers and staff who served them
--SUM(amount) Calculates the total transaction amount for each customer-staff pair
--GROUP BY staff_id, customer_id Aggregates results by each unique customer-staff combination
SELECT
  customer_id,
  staff_id,
  SUM(amount)
FROM
  payment
GROUP BY
  staff_id,
  customer_id
ORDER BY
  customer_id;
  ---Enhanced Query with Customer Names
  SELECT
  c.customer_id,
  c.first_name || ' ' || c.last_name AS customer_name,
  p.staff_id,
  s.first_name || ' ' || s.last_name AS staff_name,
  SUM(p.amount) AS total_amount
FROM
  payment p
  JOIN customer c ON p.customer_id = c.customer_id
  JOIN staff s ON p.staff_id = s.staff_id
GROUP BY
  c.customer_id,
  customer_name,
  p.staff_id,
  staff_name
ORDER BY
  c.customer_id;

 --6) Using PostgreSQL GROUP BY clause with a date column
 --This query provides a daily breakdown of payment amounts, showing the total revenue collected each day
 --payment_date::date Converts timestamp to just date (removes time component).Ensures all payments on the same day are grouped together
 --SUM(amount) Calculates the total payments for each day

 SELECT
  payment_date::date payment_date,
  SUM(amount) sum
FROM
  payment
GROUP BY
  payment_date::date
ORDER BY
  payment_date DESC; 
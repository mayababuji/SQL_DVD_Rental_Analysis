--1) Using PostgreSQL SELECT statement to query data from one column example
SELECT first_name FROM customer;
--2) Using PostgreSQL SELECT statement to query data from multiple columns example
SELECT first_name,last_name, email FROM customer;
--3) Using PostgreSQL SELECT statement to query data from all columns of a table example
SELECT * FROM customer;
--4) Using PostgreSQL SELECT statement with expressions example.
--Here expression || concatenates the first name, space, and last name of every customer. 
--The first column of the output doesn't have a name but ?column?. to resolve that us alias as in Step 5
SELECT first_name || ' ' || last_name, email FROM customer;
--5) Using PostgreSQL SELECT statement with expressions example using The AS keyword is optional so both the queries below yields the same result
SELECT first_name || ' ' || last_name AS full_name,email FROM customer;
SELECT first_name || ' ' || last_name full_name,email FROM customer;
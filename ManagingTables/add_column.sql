--*********************************************************************************************************************--
--PostgreSQL ADD A COLUMN
--To add a new column to an existing table, use the ALTER TABLE ADD COLUMN statement
--*********************************************************************************************************************--
--Creating a sample table
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL
);
--1) Adding a new column to a table
ALTER TABLE customers
ADD COLUMN phone VARCHAR(25);
--2) Adding multiple columns to a table
ALTER TABLE customers
ADD COLUMN fax VARCHAR (25),
ADD COLUMN email VARCHAR (400);
--3) Adding a column with a NOT NULL constraint to a table that already has data
--first insert data to table
INSERT INTO
   customers (customer_name)
VALUES
   ('Apple'),
   ('Samsung'),
   ('Sony')
RETURNING *;
--Second, attempt to add the contact_name column to the customers table:
--ERROR:  column "contact_name" of relation "customers" contains null values
--When PostgreSQL added the column, this new column received NULL, which violates the NOT NULL constraint.
ALTER TABLE customers
ADD COLUMN contact_name VARCHAR(255) NOT NULL;
--To address this issue, you can follow these steps:
--First, add the contact_name column without the NOT NULL constraint:
ALTER TABLE customers
ADD COLUMN contact_name VARCHAR(255);
--Second, update the values in the contact_name column.
UPDATE customers
SET contact_name = 'John Doe'
WHERE id = 1;

UPDATE customers
SET contact_name = 'Mary Doe'
WHERE id = 2;

UPDATE customers
SET contact_name = 'Lily Bush'
WHERE id = 3;
--Third, modify the contact_name column to add the NOT NULL constraint:

ALTER TABLE customers
ALTER COLUMN contact_name
SET NOT NULL;
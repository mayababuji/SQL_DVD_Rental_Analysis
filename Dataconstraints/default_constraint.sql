--*********************************************************************************************************************--
--PostgreSQL DEFAULT Value
-- assign a default value to a column using the PostgreSQL DEFAULT constraint.
--*********************************************************************************************************************--
--1) Basic PostgreSQL default value examples

CREATE TABLE products(
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(19,2) NOT NULL DEFAULT 0
);
--we don’t specify a value for the price column in the INSERT statement; therefore, PostgreSQL uses the default value 0.00 for the price column

INSERT INTO products(name)
VALUES('Laptop')
RETURNING *;
--we use the DEFAULT keyword as the value for the price column in the INSERT statement, PostgreSQL uses the default value as 0.00 for the column.
INSERT INTO products(name, price)
VALUES
   ('Tablet', 699.99)
RETURNING *;

--2) Using DEFAULT constraint with TIMESTAMP columns
--The created_at column uses the current timestamp returned by the CURRENT_TIMESTAMP function as the default value.
CREATE TABLE logs(
   id SERIAL PRIMARY KEY,
   message TEXT NOT NULL,
   created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--In the INSERT statement, we don’t specify the value for the created_at column, PostgreSQL uses the current timestamp for the insertion.
INSERT INTO logs(message)
VALUES('Started the server')
RETURNING *;

--3) Using DEFAULT constraint with JSONB type
--The configuration column has the JSONB type with the default value as an empty JSON object.
CREATE TABLE settings(
   id SERIAL PRIMARY KEY,
   name VARCHAR(50) NOT NULL,
   configuration JSONB DEFAULT '{}'
);

--Since we don’t specify a value for the configuration column, PostgreSQL uses the empty JSON object {} for the insertion.
INSERT INTO settings(name)
VALUES('global')
RETURNING *;
--To remove the default JSONB value from the configuration column of the settings table, you can use the following ALTER TABLE statement:
ALTER TABLE settings
ALTER COLUMN configuration
DROP DEFAULT;

--*********************************************************************************************************************--
--PostgreSQL NOT NULL Constraint
---PostgreSQL not-null constraints to ensure the values of a column are not null.
--To check if a value is NULL or not, you use the IS NULL operator. The IS NOT NULL negates the result of the IS NULL.
--Never use equal operator = to compare a value with NULL because it always returns NULL.
--*********************************************************************************************************************--

--Declaring NOT NULL columns

CREATE TABLE invoices(
  id SERIAL PRIMARY KEY,
  product_id INT NOT NULL,
  qty numeric NOT NULL CHECK(qty > 0),
  net_price numeric CHECK(net_price > 0)
);

--Adding NOT NULL Constraints to existing columns
--setting sample
CREATE TABLE production_orders (
	id SERIAL PRIMARY KEY,
	description VARCHAR (40) NOT NULL,
	material_id VARCHAR (16),
	qty NUMERIC,
	start_date DATE,
	finish_date DATE
);

INSERT INTO production_orders (description)
VALUES('Make for Infosys inc.');

--Then, to make sure that the qty field is not null, you can add the not-null constraint to the qty column. However, the column already contains data. 
--If you try to add the not-null constraint, PostgreSQL will issue an error.
--To add the NOT NULL constraint to a column that already contains NULL, you need to update NULL to non-NULL first, like this:

UPDATE production_orders
SET qty = 1;
--The values in the qty column is updated to one. Now, you can add the NOT NULL constraint to the qty column
ALTER TABLE production_orders
ALTER COLUMN qty
SET NOT NULL;
--After that, you can update the not-null constraints for material_id, start_date, and finish_date columns:

UPDATE production_orders
SET material_id = 'ABC',
    start_date = '2015-09-01',
    finish_date = '2015-09-01';

    --Add not-null constraints to multiple columns:
    ALTER TABLE production_orders
ALTER COLUMN material_id SET NOT NULL,
ALTER COLUMN start_date SET NOT NULL,
ALTER COLUMN finish_date SET NOT NULL;

--The special case of NOT NULL constraint
--use a CHECK constraint to force a column to accept not NULL values.
-- username or email column of the user tables is not null or empty.
CREATE TABLE users (
  id serial PRIMARY KEY,
  username VARCHAR (50),
  password VARCHAR (50),
  email VARCHAR (50),
  CONSTRAINT username_email_notnull CHECK (
    NOT (
      (
        username IS NULL
        OR username = ''
      )
      AND (
        email IS NULL
        OR email = ''
      )
    )
  )
);

INSERT INTO users (username, email)
VALUES
	('user1', NULL),
	(NULL, 'user2@example.com'),
	('user2', 'user2@example.com'),
	('user3', '');

-- ERROR:  new row for relation "users" violates check constraint "username_email_notnull"
-- Failing row contains (5, null, null, null). 
-- Detail: Failing row contains (5, null, null, null).
INSERT INTO users (username, email)
VALUES
	(NULL, NULL),
	(NULL, ''),
	('', NULL),
	('', '');
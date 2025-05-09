
--*********************************************************************************************************************--
--PostgreSQL Primary Key
-- A primary key is a column or a group of columns used to uniquely identify a row in a table. The column that participates in the primary key is known as the primary key column.

-- A table can have zero or one primary key. It cannot have more than one primary key.

-- It is a good practice to add a primary key to every table. When you add a primary key to a table, PostgreSQL creates a unique B-tree index on the column or a group of columns used to define the primary key.

-- Technically, a primary key constraint is the combination of a not-null constraint and a UNIQUE constraint.
--*********************************************************************************************************************--

--1) Creating a table with a primary key that consists of one column
CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY,
  customer_id VARCHAR(255) NOT NULL,
  order_date DATE NOT NULL
);

--2) Creating a table with a primary key that consists of two columns
--primary key that consists of two columns order_id and item_no:
CREATE TABLE order_items(
  order_id INT,
  item_no SERIAL,
  item_description VARCHAR NOT NULL,
  quantity INTEGER NOT NULL,
  price DEC(10, 2),
  PRIMARY KEY (order_id, item_no)
);

--3) Adding a primary key to an existing table
--create a table called products without defining any primary key
CREATE TABLE products (
  product_id INT,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DEC(10, 2) NOT NULL
);
--Second, add a primary key constraint to the products table using the ALTER TABLE ... ADD PRIMARY KEY statement

ALTER TABLE products
ADD PRIMARY KEY (product_id);

--4) Adding an auto-incremented primary key to an existing table
--First, create a new table called vendors that does not have a primary key:


CREATE TABLE vendors (
  name VARCHAR(255)
);

--Second, insert some rows into the vendors table:
INSERT INTO vendors (name)
VALUES
  ('Microsoft'),
  ('IBM'),
  ('Apple'),
  ('Samsung')
RETURNING *;
--Third, add a primary key named vendor_id into the vendors table with the type SERIAL:

ALTER TABLE vendors
ADD COLUMN vendor_id SERIAL PRIMARY KEY;

---Drop a primary key


dvdrental=# \d vendors
                                         Table "public.vendors"
  Column   |          Type          | Collation | Nullable |                  Default                   
-----------+------------------------+-----------+----------+--------------------------------------------
 name      | character varying(255) |           |          | 
 vendor_id | integer                |           | not null | nextval('vendors_vendor_id_seq'::regclass)
Indexes:
    "vendors_pkey1" PRIMARY KEY, btree (vendor_id)
--drop primary key command is 
--The statement removes only the primary key constraint but does not remove the vendor_id column
    ALTER TABLE vendors
DROP CONSTRAINT vendors_pkey1;
--*********************************************************************************************************************--
--PostgreSQL TRUNCATE TABLE
--TRUNCATE TABLE statement  quickly delete all data from large tables.
--*********************************************************************************************************************--
--1) Basic PostgreSQL TRUNCATE TABLE statement example
--setting up sample

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL DEFAULT 0
);
INSERT INTO products (name, price)
VALUES
    ('A', 19.99),
    ('B', 29.99),
    ('C', 39.99),
    ('D', 49.99)
RETURNING *;
--delete all data from the products table using the TRUNCATE TABLE statement:
TRUNCATE TABLE products;
--2) Using PostgreSQL TRUNCATE TABLE statement to delete all data from multiple tables
--create a table called customers and insert data into it:
CREATE TABLE customers(
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   phone VARCHAR(25) NOT NULL
);

INSERT INTO customers (name, phone) VALUES
    ('John Doe', '123-456-7890'),
    ('Jane Smith', '987-654-3210'),
    ('Robert Johnson', '555-123-4567')

RETURNING *;
--create a table called vendors and insert data into it:

CREATE TABLE vendors(
   id SERIAL PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   phone VARCHAR(25) NOT NULL
);

INSERT INTO vendors (name, phone) VALUES
    ('ABC Electronics', '555-123-4567'),
    ('XYZ Supplies', '999-888-7777'),
    ('Tech Solutions Inc.', '111-222-3333')

RETURNING *;

--delete data from the customers and vendors tables using the TRUNCATE TABLE statement:
TRUNCATE TABLE customers, vendors;

--3) Using PostgreSQL TRUNCATE TABLE statement to delete data from a table referenced by a foreign key
--setting up sample
CREATE TABLE orders(
  order_id SERIAL PRIMARY KEY,
  customer_name VARCHAR(255) NOT NULL,
  ordered_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL
);

CREATE TABLE order_items (
  order_id INT NOT NULL,
  item_id INT NOT NULL,
  product_name VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  FOREIGN KEY (order_id)
     REFERENCES orders(order_id) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (order_id, item_id)
);

INSERT INTO orders (customer_name, ordered_date, status)
VALUES
  ('John Doe', '2024-01-25', 'Processing'),
  ('Jane Smith', '2024-01-26', 'Shipped'),
  ('Bob Johnson', '2024-01-27', 'Delivered');

INSERT INTO order_items (order_id, item_id, product_name, quantity)
VALUES
  (1, 1, 'A', 2),
  (1, 2, 'B', 1),
  (2, 1, 'C', 3),
  (3, 1, 'D', 5),
  (3, 2, 'E', 2);

-- ERROR:  cannot truncate a table referenced in a foreign key constraint
-- Table "order_items" references "orders". 
-- Detail: Table "order_items" references "orders".
-- Hint: Truncate table "order_items" at the same time, or use TRUNCATE ... CASCADE.
  TRUNCATE TABLE orders;

  --to overcome the above issue use CASCADE
  TRUNCATE TABLE orders CASCADE;

  ---Restarting sequence
  --Besides removing data, you may want to reset the values of the identity column by using the RESTART IDENTITY option like this
  --By default, the  TRUNCATE TABLE statement uses the CONTINUE IDENTITY option. This option does not restart the value in the sequence associated with the column in the table
  --if RESTART IDENTITY  is not provided while truncating next time insert the ID will be taking the next sequence number like 5,6,7 instead of 1,2,3

  TRUNCATE TABLE products
RESTART IDENTITY;

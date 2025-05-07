
--*********************************************************************************************************************--
--PostgreSQL UPSERT
--Upsert is a combination of update and insert. The upsert allows you to update an existing row or insert a new one if it doesn’t exist.
--PostgreSQL does not have the UPSERT statement but it supports the upsert operation via the INSERT...ON CONFLICT statement.
--If you use PostgreSQL 15 or later, you can use the MERGE statement which is equivalent to the UPSERT statement.
--Updating existing products. If a product already exists in the inventory table, you want to update its price and quantity with the new information.
--Insert new products. If a product is not in the inventory table, you want to insert it into the table.
--********************************************************************************************************************--
--setting up table
CREATE TABLE inventory_upsert(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL,
   price DECIMAL(10,2) NOT NULL,
   quantity INT NOT NULL
);



INSERT INTO inventory_upsert(id, name, price, quantity)
VALUES
	(1, 'A', 15.99, 100),
	(2, 'B', 25.49, 50),
	(3, 'C', 19.95, 75)
RETURNING *;
--1) Basic PostgreSQL INSERT … ON CONFLICT statement example
INSERT INTO inventory_upsert (id, name, price, quantity)
VALUES (1, 'A', 16.99, 120)
ON CONFLICT(id)
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity
  RETURNING *;

---2) Inserting data example
  INSERT INTO inventory_upsert (id, name, price, quantity)
VALUES (4, 'D', 29.99, 20)
ON CONFLICT(id)
DO UPDATE SET
  price = EXCLUDED.price,
  quantity = EXCLUDED.quantity
    RETURNING *;
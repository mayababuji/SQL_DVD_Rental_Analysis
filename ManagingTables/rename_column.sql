--*********************************************************************************************************************--
--PostgreSQL RENAME COLUMN
--*********************************************************************************************************************--

--setting up sample
CREATE TABLE customer_groups (
  id serial PRIMARY KEY,
  name VARCHAR NOT NULL
);
CREATE TABLE customers (
  id serial PRIMARY KEY,
  name VARCHAR NOT NULL,
  phone VARCHAR NOT NULL,
  email VARCHAR,
  group_id INT,
  FOREIGN KEY (group_id) REFERENCES customer_groups (id)
);
--Then, create a new view named customer_data based on the customers and customer_groups tables
CREATE VIEW customer_data AS
SELECT
  c.id,
  c.name,
  g.name customer_group
FROM
  customers c
  INNER JOIN customer_groups g ON g.id = c.group_id;

  --1) Renaming one column example
  ALTER TABLE customers
RENAME COLUMN email TO contact_email;

--2) Renaming a column that has dependent objects example .The name column has been changed to group_name in the view customer_data as well
ALTER TABLE customer_groups
RENAME COLUMN name TO group_name;
--3) Using multiple RENAME COLUMN statements to rename multiple columns example
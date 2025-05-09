--*********************************************************************************************************************--
--PostgreSQL Rename Table
--specify the name of the table which you want to rename after the ALTER TABLE clause.
--assign the new table name after the RENAME TO clause.
--*********************************************************************************************************************--
--1) Basic PostgreSQL rename table statement example
--create a sample table
CREATE TABLE vendors (
    id serial PRIMARY KEY,
    name VARCHAR NOT NULL
);
ALTER TABLE vendors
RENAME TO suppliers;

--describe the vendors table using the \d command in psql

dvdrental=# \d suppliers 
                                Table "public.suppliers"
 Column |       Type        | Collation | Nullable |               Default               
--------+-------------------+-----------+----------+-------------------------------------
 id     | integer           |           | not null | nextval('vendors_id_seq'::regclass)
 name   | character varying |           | not null | 
Indexes:
    "vendors_pkey" PRIMARY KEY, btree (id)

---2) Renaming a table that has dependent objects
--first create a table
CREATE TABLE customer_groups(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL
);

CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    group_id INT NOT NULL,
    FOREIGN KEY (group_id) REFERENCES customer_groups(id)
       ON DELETE CASCADE
       ON UPDATE CASCADE
);
--Second, create a view based on the customers and customer_groups tables
CREATE VIEW customer_data
AS SELECT
    c.id,
    c.name,
    g.name customer_group
FROM
    customers c
INNER JOIN customer_groups g ON g.id = c.group_id;
--When you rename a table, PostgreSQL will automatically update its dependent objects such as foreign key constraints, views, and indexes.
--Third, rename the customer_groups table to groups
ALTER TABLE customer_groups
RENAME TO groups;
---\d customers
Table "public.customers"
  Column  |          Type          | Collation | Nullable |                Default
----------+------------------------+-----------+----------+---------------------------------------
 id       | integer                |           | not null | nextval('customers_id_seq'::regclass)
 name     | character varying(255) |           | not null |
 group_id | integer                |           | not null |
Indexes:
    "customers_pkey" PRIMARY KEY, btree (id)
Foreign-key constraints:
    "customers_group_id_fkey" FOREIGN KEY (group_id) REFERENCES groups(id) ON UPDATE CASCADE ON DELETE CASCADE
---\d+ customer_data

View "public.customer_data"
     Column     |          Type          | Collation | Nullable | Default | Storage  | Description
----------------+------------------------+-----------+----------+---------+----------+-------------
 id             | integer                |           |          |         | plain    |
 name           | character varying(255) |           |          |         | extended |
 customer_group | character varying      |           |          |         | extended |
View definition:
 SELECT c.id,
    c.name,
    g.name AS customer_group
   FROM customers c
     JOIN groups g ON g.id = c.group_id;

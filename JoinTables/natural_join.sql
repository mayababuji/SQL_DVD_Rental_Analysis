--****************************************************************************************************************************************--
--PostgreSQL  NATURAL JOIN
--A NATURAL JOIN is like a smart automatic join that connects tables by matching columns with the same names automatically - 
--it's PostgreSQL's way of guessing how tables should be linked together.
--Automatic Matching: Joins tables on all columns that share the same name
--****************************************************************************************************************************************--
--Setting up sample tables
CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
  product_id serial PRIMARY KEY,
  product_name VARCHAR (255) NOT NULL,
  category_id INT NOT NULL,
  FOREIGN KEY (category_id) REFERENCES categories (category_id)
);

INSERT INTO categories (category_name)
VALUES
  ('Smartphone'),
  ('Laptop'),
  ('Tablet'),
  ('VR')
RETURNING *;

INSERT INTO products (product_name, category_id)
VALUES
  ('iPhone', 1),
  ('Samsung Galaxy', 1),
  ('HP Elite', 2),
  ('Lenovo Thinkpad', 2),
  ('iPad', 3),
  ('Kindle Fire', 3);

  --1) Basic PostgreSQL NATURAL JOIN example
--The following statement uses the NATURAL JOIN clause 
--to join the products table with the categories table both table have same column name "category_id"
  SELECT *
FROM products
NATURAL JOIN categories;

--equivalent inner join query for the above natural join
SELECT	*
FROM products
INNER JOIN categories USING (category_id);

--2) Using PostgreSQL NATURAL JOIN to perform a LEFT JOIN
--The following example uses the NATURAL JOIN clause to perform a LEFT JOIN without specifying the matching column:
SELECT *
FROM categories
NATURAL LEFT JOIN products;

--3) Example of using NATURAL JOIN that causes an unexpected result
--In practice, you should avoid using the NATURAL JOIN whenever possible because sometimes it may cause an unexpected result.
--The query returns an empty result set.
--The reason is that both tables have another common column called last_update. 
--When the NATURAL JOIN clause uses the last_update column, it does not find any matches.
SELECT *
FROM city
NATURAL JOIN country;
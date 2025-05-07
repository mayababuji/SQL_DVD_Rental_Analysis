--*********************************************************************************************************************--
--PostgreSQL UPDATE
--*********************************************************************************************************************--
--Setting up a sample table
CREATE TABLE courses(
  course_id serial PRIMARY KEY,
  course_name VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  description VARCHAR(500),
  published_date date
);


INSERT INTO courses( course_name, price, description, published_date)
VALUES
('PostgreSQL for Developers', 299.99, 'A complete PostgreSQL for Developers', '2020-07-13'),
('PostgreSQL Admininstration', 349.99, 'A PostgreSQL Guide for DBA', NULL),
('PostgreSQL High Performance', 549.99, NULL, NULL),
('PostgreSQL Bootcamp', 777.99, 'Learn PostgreSQL via Bootcamp', '2013-07-11'),
('Mastering PostgreSQL', 999.98, 'Mastering PostgreSQL in 21 Days', '2012-06-30');

SELECT * FROM courses;
--1) Basic PostgreSQL UPDATE example
UPDATE courses
SET published_date = '2020-08-01'
WHERE course_id = 3;

--2) Updating a row and returning the updated row
UPDATE courses
SET published_date = '2020-07-01'
WHERE course_id = 2
RETURNING *;

--3) Updating a column with an expression
--Because we don’t use a WHERE clause, the UPDATE statement updates all the rows in the courses table
UPDATE courses
SET price = price * 2;

--*********************************************************************************************************************--
--PostgreSQL UPDATE JOINS
--*********************************************************************************************************************--
CREATE TABLE product_segment (
    id SERIAL PRIMARY KEY,
    segment VARCHAR NOT NULL,
    discount NUMERIC (4, 2)
);


INSERT INTO
    product_segment (segment, discount)
VALUES
    ('Grand Luxury', 0.05),
    ('Luxury', 0.06),
    ('Mass', 0.1);
--create another table named product that stores the product data. The product table has the foreign key column segment_id that links to the id of the segment table
CREATE TABLE product(
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    price NUMERIC(10,2),
    net_price NUMERIC(10,2),
    segment_id INT NOT NULL,
    FOREIGN KEY(segment_id) REFERENCES product_segment(id)
);


INSERT INTO
    product (name, price, segment_id)
VALUES
    ('diam', 804.89, 1),
    ('vestibulum aliquet', 228.55, 3),
    ('lacinia erat', 366.45, 2),
    ('scelerisque quam turpis', 145.33, 3),
    ('justo lacinia', 551.77, 2),
    ('ultrices mattis odio', 261.58, 3),
    ('hendrerit', 519.62, 2),
    ('in hac habitasse', 843.31, 1),
    ('orci eget orci', 254.18, 3),
    ('pellentesque', 427.78, 2),
    ('sit amet nunc', 936.29, 1),
    ('sed vestibulum', 910.34, 1),
    ('turpis eget', 208.33, 3),
    ('cursus vestibulum', 985.45, 1),
    ('orci nullam', 841.26, 1),
    ('est quam pharetra', 896.38, 1),
    ('posuere', 575.74, 2),
    ('ligula', 530.64, 2),
    ('convallis', 892.43, 1),
    ('nulla elit ac', 161.71, 3);

--calculate the net price of every product based on the discount of the product segment
--If there is a match in both tables, it gets a discount from the product_segment table, calculates the net price based on the following formula, and updates the net_price column.
    UPDATE product
SET net_price = price - price * discount
FROM product_segment
WHERE product.segment_id = product_segment.id;
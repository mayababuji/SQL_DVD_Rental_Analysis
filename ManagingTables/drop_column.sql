--*********************************************************************************************************************--
--PostgreSQL DROP COLUMN
--*********************************************************************************************************************--
--first create sample tables

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(255) NOT NULL,
    published_date DATE NOT NULL,
    description VARCHAR,
    category_id INT NOT NULL,
    publisher_id INT NOT NULL,
    FOREIGN KEY (publisher_id)
       REFERENCES publishers (publisher_id),
    FOREIGN KEY (category_id)
       REFERENCES categories (category_id)
);

--Additionally, create a view based on the books and publishers tables as follows:
CREATE VIEW book_info
AS SELECT
    book_id,
    title,
    isbn,
    published_date,
    name
FROM
    books b
INNER JOIN publishers
    USING(publisher_id)
ORDER BY title;
--1) Drop a column example
--the statement removes both the category_id column and the foreign key constraint that involves the category_id column.
ALTER TABLE books
DROP COLUMN category_id;
--2) Drop a column that is referenced by a constrain
-- ERROR:  cannot drop table books column publisher_id because other objects depend on it
-- DETAIL:  view book_info depends on table books column publisher_id
-- HINT:  Use DROP ... CASCADE to drop the dependent objects too.

ALTER TABLE books
DROP COLUMN publisher_id;
--so we use the cascade drop command

ALTER TABLE books
DROP COLUMN publisher_id CASCADE;

--3) Drop multiple columns example

ALTER TABLE books
  DROP COLUMN isbn,
  DROP COLUMN description;


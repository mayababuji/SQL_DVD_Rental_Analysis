--*********************************************************************************************************************--
--PostgreSQL INSERT
--*********************************************************************************************************************--
--PostgreSQL INSERT statement examples
CREATE TABLE links (
  id SERIAL PRIMARY KEY,
  url VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description VARCHAR (255),
  last_update DATE
);
--1) Basic PostgreSQL INSERT statement example
--The INSERT statement has an optional RETURNING clause that returns the information of the inserted row.
--The INSERT statement returns a command tag with the following form without a RETURNING clause INSERT oid count
-- The OID is an object identifier. PostgreSQL used the OID internally as a primary key for its system tables. Typically, the INSERT statement returns OID with a value of 0.
-- The count is the number of rows that the INSERT statement inserted successfully
INSERT INTO links (url, name)
VALUES('https://neon.tech/postgresql','PostgreSQL Tutorial')
RETURNING *;
--2) Inserting character string that contains a single quote
--If you want to insert a string that contains a single quote (') such as O'Reilly Media, you have to use an additional single quote (') to escape it.
INSERT INTO links (url, name)
VALUES('http://www.oreilly.com','O''Reilly Media');
--3) Inserting a date value
INSERT INTO links (url, name, last_update)
VALUES('https://www.google.com','Google','2013-06-01');
--4) Getting the last inserted ID
INSERT INTO links (url, name)
VALUES('https://www.postgresql.org','PostgreSQL')
RETURNING id;

--*********************************************************************************************************************--
--PostgreSQL INSERT Multiple Rows
--*********************************************************************************************************************--
--Setting up a sample table
CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(384) NOT NULL UNIQUE
);
--1) Basic inserting multiple rows example

INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('John', 'Doe', 'john.doe@example.com'),
    ('Jane', 'Smith', 'jane.smith@example.com'),
    ('Bob', 'Johnson', 'bob.johnson@example.com');
--2) Inserting multiple rows and returning inserted rows

INSERT INTO contacts (first_name, last_name, email)
VALUES
    ('Alice', 'Johnson', 'alice.johnson@example.com'),
    ('Charlie', 'Brown', 'charlie.brown@example.com')
RETURNING *;

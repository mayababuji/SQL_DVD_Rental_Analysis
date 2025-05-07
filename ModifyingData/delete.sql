--*********************************************************************************************************************--
--PostgreSQL DELETE
--The PostgreSQL DELETE statement allows you to delete one or more rows from a table.
--*********************************************************************************************************************--
--Setting up a sample table
CREATE TABLE todos (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT false
);

INSERT INTO todos (title, completed) VALUES
    ('Learn basic SQL syntax', true),
    ('Practice writing SELECT queries', false),
    ('Study PostgreSQL data types', true),
    ('Create and modify tables', false),
    ('Explore advanced SQL concepts', true),
    ('Understand indexes and optimization', false),
    ('Backup and restore databases', true),
    ('Implement transactions', false),
    ('Master PostgreSQL security features', true),
    ('Build a sample application with PostgreSQL', false);

SELECT * FROM todos;

--1) Using PostgreSQL DELETE to delete one row from the table
DELETE FROM todos
WHERE id = 1;

--2) Using PostgreSQL DELETE to delete a row and return the deleted row
--The following statement uses the DELETE statement to delete the row with id 2 and return the deleted row to the client:
DELETE FROM todos
WHERE id = 2
RETURNING *;

--3) Using PostgreSQL DELETE to delete multiple rows from the table
--The following statement uses the DELETE statement to delete all rows from the todos table with the value in the value in the completed column true and return deleted rows
DELETE from todos
WHERE todos.completed = true
RETURNING *;
--4) Using PostgreSQL DELETE to delete all rows from the table
--The following statement uses the DELETE statement without a WHERE clause to delete all rows from the todos table:
DELETE FROM todos;

--*********************************************************************************************************************--
--PostgreSQL DELETE JOINS
--TPostgreSQL does not support the DELETE JOIN statement like MySQL. Instead, it offers the USING clause in the DELETE statement that provides similar functionality to the DELETE JOIN.
--*********************************************************************************************************************--

--Setting up sample tables

CREATE TABLE member(
   id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   phone VARCHAR(15) NOT NULL
);


CREATE TABLE denylist(
    phone VARCHAR(15) PRIMARY KEY
);


INSERT INTO member(first_name, last_name, phone)
VALUES ('John','Doe','(408)-523-9874'),
       ('Jane','Doe','(408)-511-9876'),
       ('Lily','Bush','(408)-124-9221');


INSERT INTO denylist(phone)
VALUES ('(408)-523-9874'),
       ('(408)-511-9876');

SELECT * FROM member;

SELECT * FROM denylist;

--1) Basic PostgreSQL delete join example
--The following statement deletes rows in the members table with the phone number exists in the denylist table
DELETE FROM member
USING denylist
WHERE member.phone = denylist.phone
RETURNING *;
--2) Delete join using a subquery example
--The USING clause is not a part of the SQL standard, meaning that it may not be available in other database systems.
--If you intend to ensure compatibility with various database products, you should avoid using the USING clause in the DELETE statement. Instead, you may consider using a subquery.
DELETE FROM member
WHERE phone IN (
    SELECT
      phone
    FROM
      denylist
)
RETURNING *;
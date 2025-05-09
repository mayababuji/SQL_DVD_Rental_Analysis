--*********************************************************************************************************************--
--PostgreSQL Sequences

--In PostgreSQL, a sequence is a database object that allows you to generate a sequence of unique integers.
--General Syntax
-- CREATE SEQUENCE [ IF NOT EXISTS ] sequence_name
--     [ AS { SMALLINT | INT | BIGINT } ]
--     [ INCREMENT [ BY ] increment ]
--     [ MINVALUE minvalue | NO MINVALUE ]
--     [ MAXVALUE maxvalue | NO MAXVALUE ]
--     [ START [ WITH ] start ]
--     [ CACHE cache ]
--     [ [ NO ] CYCLE ]
--     [ OWNED BY { table_name.column_name | NONE } ]
--*********************************************************************************************************************--
--1) Creating an ascending sequence example
--This statement uses the CREATE SEQUENCE statement to create a new ascending sequence starting from 100 with an increment of 5:
--To get the next value from the sequence, you use the nextval() function:
CREATE SEQUENCE mysequence
INCREMENT 5
START 100;

select nextval('mysequence')

--2) Creating a descending sequence example
--The following statement creates a descending sequence from 3 to 1 with the cycle option:

CREATE SEQUENCE three
INCREMENT -1    -- Decreases by 1 each time
MINVALUE 1      -- Smallest value it can generate
MAXVALUE 3      -- Largest value it can generate
START 3         -- Begins counting from 3
CYCLE;          -- Restarts from MAXVALUE after MINVALUE Without CYCLE, the sequence would stop at 1 and throw an error when exhausted
select nextval('three')

--3) Creating a sequence associated with a table column
--First, create a new table named order_details:
CREATE TABLE order_details(
    order_id SERIAL,
    item_id INT NOT NULL,
    item_text VARCHAR NOT NULL,
    price DEC(10,2) NOT NULL,
    PRIMARY KEY(order_id, item_id)
);
--Second, create a new sequence associated with the item_id column of the order_details table:
CREATE SEQUENCE order_item_id
START 10
INCREMENT 10
MINVALUE 10
OWNED BY order_details.item_id;
--Third, insert three order line items into the order_details table:
--In this statement, we used the nextval() function to fetch the item id value from the order_item_id sequence.

INSERT INTO
    order_details(order_id, item_id, item_text, price)
VALUES
    (100, nextval('order_item_id'),'DVD Player',100),
    (100, nextval('order_item_id'),'Android TV',550),
    (100, nextval('order_item_id'),'Speaker',250);

---Listing all sequences in a database

SELECT
    relname sequence_name
FROM
    pg_class
WHERE
    relkind = 'S';

--Deleting sequence
DROP SEQUENCE order_item_id

--This statement drops the table order_details. Since the sequence order_item_id associates with the item_id of the order_details, it is also dropped automatically:


DROP TABLE order_details;
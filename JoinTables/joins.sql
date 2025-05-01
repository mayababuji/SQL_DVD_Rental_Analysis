--****************************************************************************************************************************************--
--PostgreSQL create a new table and insert values into it
--****************************************************************************************************************************************--
--two tables called basket_a and basket_b that store fruits
CREATE TABLE basket_a (a INT PRIMARY KEY,
fruit_a VARCHAR(100) NOT NULL);

CREATE TABLE basket_b(b INT PRIMARY KEY,
fruit_b VARCHAR(100) NOT NULL);

-- Insert valies into basket_a and basket_b

INSERT into basket_a(a,fruit_a)
VALUES
(1, 'APPLE'),
(2, 'ORANGE'),
(3,'BANANA'),
(4,'CUCUMBER');

INSERT into basket_b(b,fruit_b)
VALUES
(1,'ORANGE'),
(2,'APPLE'),
(3,'WATERMELON'),
(4,'PEAR');
--****************************************************************************************************************************************--
--PostgreSQL inner join
--****************************************************************************************************************************************--
--The following statement joins the first table (basket_a) with the second table (basket_b) by matching the values in the fruit_a and fruit_b columns:
--The inner join examines each row in the first table (basket_a). It compares the value in the fruit_a column with the value in the fruit_b column of each row in the second table (basket_b). If these values are equal, 
--the inner join creates a new row that contains columns from both tables and adds this new row to the result set.
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
INNER JOIN basket_b
    ON fruit_a = fruit_b;
--Euivalent query

SELECT *
FROM
basket_a
INNER JOIN basket_b
    ON fruit_a = fruit_b;
--****************************************************************************************************************************************--
--PostgreSQL left join
--****************************************************************************************************************************************--
--In the left join context, the first table is called the left table and the second table is called the right table.
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
   ON fruit_a = fruit_b;
--To select rows from the left table that do not have matching rows in the right table, you use the left join with a WHERE clause.
--LEFT JOIN is the same as the LEFT OUTER JOIN so you can use them interchangeably.		
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
LEFT JOIN basket_b
    ON fruit_a = fruit_b
WHERE b IS NULL;   

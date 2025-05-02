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
-- Left Table: The table that appears immediately after FROM

-- Right Table: The table that appears after JOIN
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

---Left Anti-Join returns rows from the left table that do not have matching rows from the right table:
--Returns:SELECT basket_a.* Only columns from table basket_a (not from basket_b).If select * is used instead all columns from both tables basket_a and basket_b
SELECT
	basket_a.*
	FROM basket_a
LEFT JOIN basket_b
ON fruit_a = fruit_b
WHERE b is NULL

--****************************************************************************************************************************************--
--PostgreSQL right join
--****************************************************************************************************************************************--
--The RIGHT JOIN and RIGHT OUTER JOIN are the same therefore you can use them interchangeably
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b ON fruit_a = fruit_b;
--rows from the right table that do not have matching rows from the left table can be retrieved by added a WHERE clause 
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
RIGHT JOIN basket_b
   ON fruit_a = fruit_b
WHERE a IS NULL;
---Right Anti-Join: Returns records from right table with no match in left table
SELECT
	basket_b.*
	FROM basket_a
RIGHT JOIN basket_b
ON fruit_b = fruit_a
WHERE a is NULL

--****************************************************************************************************************************************--
--PostgreSQL full outer join
--****************************************************************************************************************************************--
--The full outer join or full join returns a result set that contains all rows from both left and right tables, with the matching rows from both sides if available. 
--In case there is no match, the columns of the table will be filled with NULL.

SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL OUTER JOIN basket_b
    ON fruit_a = fruit_b;

--To return rows in a table that do not have matching rows in the other, you use the full join with a WHERE clause like this
SELECT
    a,
    fruit_a,
    b,
    fruit_b
FROM
    basket_a
FULL JOIN basket_b
   ON fruit_a = fruit_b
WHERE a IS NULL OR b IS NULL;

---FULL OUTER Anti-Join: returns all rows from both tables that don't have matching rows in the other table.

SELECT 'A' AS source, a, fruit_a
FROM basket_a
LEFT JOIN basket_b ON fruit_a = fruit_b
WHERE basket_b.fruit_b IS NULL

UNION ALL

SELECT 'B' AS source, b, fruit_b
FROM basket_b
LEFT JOIN basket_a ON fruit_b = fruit_a
WHERE fruit_a IS NULL;
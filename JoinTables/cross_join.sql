--****************************************************************************************************************************************--
--PostgreSQL Cross Join
--A CROSS JOIN in PostgreSQL is like making every possible combination between two tables - 
--it pairs each row from the first table 
--with every single row from the second table, no matter what.
--No matching condition needed - Unlike other joins, there's no ON clause
--Multiplies rows - If Table A has 10 rows and Table B has 20, you get 200 rows (10×20)
--Sometimes called a Cartesian Product
--****************************************************************************************************************************************--

--create a table for illustrating this sample
DROP TABLE IF EXISTS T1;

CREATE TABLE
  T1 (LABEL CHAR(1) PRIMARY KEY);

DROP TABLE IF EXISTS T2;

CREATE TABLE
  T2 (score INT PRIMARY KEY);

INSERT INTO
  T1 (LABEL)
VALUES
  ('A'),
  ('B');

INSERT INTO
  T2 (score)
VALUES
  (1),
  (2),
  (3);

--*********************************************************************************************************************--
--PostgreSQL Temporary Table
--When you create a temporary table that shares the same name as a permanent table, you cannot access the permanent table until the temporary table is removed
--*********************************************************************************************************************--
--Creating a temporary table using CREATE TEMPORARY TABLE statement
--If you open a second database session and query data from the mytemp table, you’ll get an error
-- ERROR:  relation "mytemp" does not exist
-- LINE 1: SELECT * FROM mytemp;

CREATE TEMP TABLE mytemp(id INT);

INSERT INTO mytemp(id) VALUES(1), (2), (3)
RETURNING *;



CREATE TEMP TABLE customers(
    customer_id INT
);


dvdrental=# \dt+ pg_temp_9.*
                                         List of relations
  Schema   |   Name    | Type  |  Owner   | Persistence | Access method |    Size    | Description 
-----------+-----------+-------+----------+-------------+---------------+------------+-------------
 pg_temp_9 | actor     | table | postgres | temporary   | heap          | 0 bytes    | 
 pg_temp_9 | customers | table | postgres | temporary   | heap          | 0 bytes    | 
 pg_temp_9 | mytemp    | table | postgres | temporary   | heap          | 8192 bytes | 

 ---Removing a PostgreSQL temporary table
 DROP TABLE customers;
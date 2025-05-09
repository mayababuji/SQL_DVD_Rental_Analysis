--*********************************************************************************************************************--
--PostgreSQL CREATE TABLE
--Constraints
--*********************************************************************************************************************--

CREATE TABLE accounts (
  user_id SERIAL PRIMARY KEY,
  username VARCHAR (50) UNIQUE NOT NULL,
  password VARCHAR (50) NOT NULL,
  email VARCHAR (255) UNIQUE NOT NULL,
  created_at TIMESTAMP NOT NULL,
  last_login TIMESTAMP
);
---Command to find the constraints of a table
SELECT 
    conname AS constraint_name,  -- Name of the constraint
    contype AS type,            -- Type of constraint
    pg_get_constraintdef(oid) AS definition  -- Full constraint definition
FROM 
    pg_constraint               -- System catalog table storing constraints
WHERE 
    conrelid = 'accounts'::regclass;  -- Filters for the 'accounts' table ::regclass converts the table name to its internal OID (object identifier).

---psql command to find the table details and constraints
dvdrental=# \d accounts

--Create table if not exist 
-- use the IF NOT EXISTS option to create a new table only if it does not exist. When you use the IF NOT EXISTS option and the table already exists, PostgreSQL will issue a notice instead of an error.
--NOTICE:  relation "accounts_sample" already exists, skipping
CREATE TABLE IF NOT EXISTS accounts_sample (
   user_id SERIAL PRIMARY KEY,
   username  VARCHAR (50) UNIQUE NOT NULL,
   password VARCHAR (50) NOT NULL,
  email VARCHAR (255) UNIQUE NOT NULL,
  created_at TIMESTAMP NOT NULL,
  last_login TIMESTAMP
);
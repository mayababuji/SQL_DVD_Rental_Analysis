--*********************************************************************************************************************--
--PostgreSQL Generated Columns
-- In PostgreSQL, a generated column is a special type 
-- of column whose values are automatically calculated based on expressions or values from other columns.
--*********************************************************************************************************************--

--1) Concatenating columns
--first create a table

CREATE TABLE contacts(
   id SERIAL PRIMARY KEY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   full_name VARCHAR(101) GENERATED ALWAYS AS (first_name || ' ' || last_name) STORED,
   email VARCHAR(300) UNIQUE
);
--second insert values into -the table

INSERT INTO contacts(first_name, last_name, email)
VALUES
   ('John', 'Doe', 'john.doe@example.com'),
   ('Jane', 'Doe', 'jane.doe@example.com')
RETURNING *;

dvdrental-# \d contacts
                                                             Table "public.contacts"
   Column   |          Type          | Collation | Nullable |                                       Default                                       
------------+------------------------+-----------+----------+-------------------------------------------------------------------------------------
 id         | integer                |           | not null | nextval('contacts_id_seq'::regclass)
 first_name | character varying(50)  |           | not null | 
 last_name  | character varying(50)  |           | not null | 
 full_name  | character varying(101) |           |          | generated always as ((((first_name::text || ' '::text) || last_name::text))) stored
 email      | character varying(300) |           |          | 
Indexes:
    "contacts_pkey" PRIMARY KEY, btree (id)
    "contacts_email_key" UNIQUE CONSTRAINT, btree (email)

    
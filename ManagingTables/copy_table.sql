--*********************************************************************************************************************--
--PostgreSQL Copy Table
--*********************************************************************************************************************--
--First, create a new table named contacts for the demonstration:
CREATE TABLE contacts(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE
);
INSERT INTO contacts(first_name, last_name, email)
VALUES('John','Doe','john.doe@example.com'),
      ('David','William','david.william@example.com')
RETURNING *;

-- use create table backup_table_name as table original_table_name
--the structure of the contact_backup table is the same as the contacts table except for the indexes.

CREATE TABLE contact_backup
AS TABLE contacts;


dvdrental=# \d contacts
                                   Table "public.contacts"
   Column   |       Type        | Collation | Nullable |               Default                
------------+-------------------+-----------+----------+--------------------------------------
 id         | integer           |           | not null | nextval('contacts_id_seq'::regclass)
 first_name | character varying |           | not null | 
 last_name  | character varying |           | not null | 
 email      | character varying |           | not null | 
Indexes:
    "contacts_pkey" PRIMARY KEY, btree (id)
    "contacts_email_key" UNIQUE CONSTRAINT, btree (email)

dvdrental=# 
dvdrental=# 
dvdrental=# 
dvdrental=# 
dvdrental=# \d contact_backup 
                  Table "public.contact_backup"
   Column   |       Type        | Collation | Nullable | Default 
------------+-------------------+-----------+----------+---------
 id         | integer           |           |          | 
 first_name | character varying |           |          | 
 last_name  | character varying |           |          | 
 email      | character varying |           |          | 

dvdrental=# 
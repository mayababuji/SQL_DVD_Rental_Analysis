--*********************************************************************************************************************--
--PostgreSQL UNIQUE Constraints
--PostgreSQL UNIQUE constraint to make sure that values stored in a column or a group of columns are unique across rows in a table
--*********************************************************************************************************************--
----PostgreSQL UNIQUE constraint example
--Method 1
CREATE TABLE person (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (50),
  last_name VARCHAR (50),
  email VARCHAR (50) UNIQUE
);
--Method2
CREATE TABLE person (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR (50),
  last_name VARCHAR (50),
  email VARCHAR (50),
  UNIQUE(email)
);

--Second insert with a duplicate email will throw and errir
-- ERROR:  duplicate key value violates unique constraint "person_email_key"
-- Key (email)=(john.doe@example.com) already exists. 
-- Detail: Key (email)=(john.doe@example.com) already exists.

INSERT INTO person(first_name,last_name,email)
VALUES('john','doe','john.doe@example.com');
--Creating a UNIQUE constraint on multiple columns
CREATE TABLE countries (
  id SERIAL PRIMARY KEY,
  capital VARCHAR (50),
  city VARCHAR (50),
  UNIQUE (capital, city)
);
--Adding unique constraints using a unique index
--add a unique constraint to an existing column or group of columns.
--First, suppose you have a table named equipment

CREATE TABLE equipment (
  id SERIAL PRIMARY KEY,
  name VARCHAR (50) NOT NULL,
  equip_id VARCHAR (16) NOT NULL
);
--Second, create a unique index based on the equip_id column

CREATE UNIQUE INDEX CONCURRENTLY equipment_equip_id
ON equipment (equip_id);

dvdrental=# \d equipment
                                    Table "public.equipment"
  Column  |         Type          | Collation | Nullable |                Default                
----------+-----------------------+-----------+----------+---------------------------------------
 id       | integer               |           | not null | nextval('equipment_id_seq'::regclass)
 name     | character varying(50) |           | not null | 
 equip_id | character varying(16) |           | not null | 
Indexes:
    "equipment_pkey" PRIMARY KEY, btree (id)
    "equipment_equip_id" UNIQUE, btree (equip_id)

--Third, add a unique constraint to the equipment table using the equipment_equip_id index.

ALTER TABLE equipment
ADD CONSTRAINT unique_equip_id
UNIQUE USING INDEX equipment_equip_id;

dvdrental=# \d equipment
                                    Table "public.equipment"
  Column  |         Type          | Collation | Nullable |                Default                
----------+-----------------------+-----------+----------+---------------------------------------
 id       | integer               |           | not null | nextval('equipment_id_seq'::regclass)
 name     | character varying(50) |           | not null | 
 equip_id | character varying(16) |           | not null | 
Indexes:
    "equipment_pkey" PRIMARY KEY, btree (id)
    "unique_equip_id" UNIQUE CONSTRAINT, btree (equip_id)

    

--*********************************************************************************************************************--
--PostgreSQL FORIEGN KEY
--In PostgreSQL, a foreign key is a column or a group of columns in a table that uniquely identifies a row in another table.
--The table containing a foreign key is referred to as the referencing table or child table.
-- Conversely, the table referenced by a foreign key is known as the referenced table or parent table.
-- a foreign key prevents the insertion of values that do not have corresponding values in the referenced table.
--a foreign key maintains consistency by automatically updating or deleting related rows in the child table when changes occur in the parent table.
--*********************************************************************************************************************--
--Setting up Table
--Because the foreign key constraint does not have the ON DELETE and ON UPDATE action, they default to NO ACTION.
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS contacts;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer --creates a foreign key relationship
      FOREIGN KEY(customer_id)
        REFERENCES customers(customer_id)
);

--No Action

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');

INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@example.com'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@example.com'),
      (2,'David Wright','(408)-222-1234','david.wright@example.com');

--Delete from customers table will throw an error
--Because of the ON DELETE NO ACTION, PostgreSQL issues a constraint violation because the referencing rows of the customer id 1 still exist in the contacts table
-- ERROR:  update or delete on table "customers" violates foreign key constraint "fk_customer" on table "contacts"
-- Key (customer_id)=(1) is still referenced from table "contacts". 
-- Detail: Key (customer_id)=(1) is still referenced from table "contacts"
DELETE FROM customers
WHERE customer_id = 1;

---SET NULL
--The SET NULL automatically sets NULL to the foreign key columns in the referencing rows of the child table when the referenced rows in the parent table are deleted.
--Setting up Table

DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
	  ON DELETE SET NULL
);
--Second, insert data into the customers and contacts tables
INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');

INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@example.com'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@example.com'),
      (2,'David Wright','(408)-222-1234','david.wright@example.com');

---delete the customer with id 1 from the customers table
--Because of the ON DELETE SET NULL action, the referencing rows in the contacts table are set to NULL.

DELETE FROM customers
WHERE customer_id = 1;

---CASCADE
--The ON DELETE CASCADE automatically deletes all the referencing rows in the child table when the referenced rows in the parent table are deleted. In practice, the ON DELETE CASCADE is the most commonly used option
--Setting Table
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT,
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
	  ON DELETE CASCADE
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC');

INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@example.com'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@example.com'),
      (2,'David Wright','(408)-222-1234','david.wright@example.com');

--Delete
--Because of the ON DELETE CASCADE action, all the referencing rows in the contacts table are automatically deleted:
DELETE FROM customers
WHERE customer_id = 1;

--SET DEFAULT

--The ON DELETE SET DEFAULT sets the default value to the foreign key column of the referencing rows in the child table when the referenced rows from the parent table are deleted.

DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
   customer_id INT GENERATED ALWAYS AS IDENTITY,
   customer_name VARCHAR(255) NOT NULL,
   PRIMARY KEY(customer_id)
);

CREATE TABLE contacts(
   contact_id INT GENERATED ALWAYS AS IDENTITY,
   customer_id INT DEFAULT 3,  ---if the customer_id in cutmomers table is deleted then it will default to 3.Note the customer_id 3 should be present in the customers table
   contact_name VARCHAR(255) NOT NULL,
   phone VARCHAR(15),
   email VARCHAR(100),
   PRIMARY KEY(contact_id),
   CONSTRAINT fk_customer
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
	  ON DELETE SET DEFAULT
);

INSERT INTO customers(customer_name)
VALUES('BlueBird Inc'),
      ('Dolphin LLC'),
	  ('Purple Bay LLC');

INSERT INTO contacts(customer_id, contact_name, phone, email)
VALUES(1,'John Doe','(408)-111-1234','john.doe@example.com'),
      (1,'Jane Doe','(408)-111-1235','jane.doe@example.com'),
      (2,'David Wright','(408)-222-1234','david.wright@example.com');
---Delete will delete customer_id in customers table and the customer_id values in conatct will changes to 3 for John Doe and Jane Doe

DELETE FROM customers
WHERE customer_id = 1;

--Add a foreign key constraint to an existing table
--To add a foreign key constraint to the existing table, you use the following form of the ALTER TABLE statement
--When adding a foreign key constraint with ON DELETE CASCADE option to an existing table, you need to follow these steps:
--First, drop existing foreign key constraint:


ALTER TABLE contacts
DROP CONSTRAINT fk_customer;
--Second, add a new foreign key constraint with ON DELETE CASCADE action:
ALTER TABLE contacts
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE;
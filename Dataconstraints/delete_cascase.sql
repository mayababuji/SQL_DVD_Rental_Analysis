--*********************************************************************************************************************--
--PostgreSQL DELETE CASCADE
--Use the PostgreSQL DELETE CASCADE to delete related rows in child tables when a parent row is deleted from the parent table
--*********************************************************************************************************************--
--PostgreSQL DELETE CASCADE example

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY(department_id)
       REFERENCES departments(id)
       ON DELETE CASCADE
);
INSERT INTO departments (name)
VALUES
    ('Engineering'),
    ('Sales')
RETURNING *;

INSERT INTO employees (name, department_id)
VALUES
    ('John Doe', 1),
    ('Jane Smith', 1),
    ('Michael Johnson', 2)
RETURNING *;
--delete a department will delete  employees associated with the department:
DELETE FROM departments
WHERE id = 1;
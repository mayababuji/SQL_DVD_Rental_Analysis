--*********************************************************************************************************************--
--PostgreSQL Change Column Type
--*********************************************************************************************************************--
--setting up example
CREATE TABLE assets (
    id serial PRIMARY KEY,
    name TEXT NOT NULL,
    asset_no VARCHAR NOT NULL,
    description TEXT,
    location TEXT,
    acquired_date DATE NOT NULL
);

INSERT INTO assets(name,asset_no,location,acquired_date)
VALUES('Server','10001','Server room','2017-01-01'),
      ('UPS','10002','Server room','2017-01-01')
RETURNING *;
--1) Changing one column example

ALTER TABLE assets
ALTER COLUMN name TYPE VARCHAR(255);
--2) Changing multiple columns example
ALTER TABLE assets
    ALTER COLUMN location TYPE VARCHAR(255),
    ALTER COLUMN description TYPE VARCHAR(255);
--3) Changing a column from VARCHAR to INT example
--ERROR:  column "asset_no" cannot be cast automatically to type integer
--HINT:  You might need to specify "USING asset_no::integer".
ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT;

-- to solve the issue use USING clause
ALTER TABLE assets
ALTER COLUMN asset_no TYPE INT
USING asset_no::integer;
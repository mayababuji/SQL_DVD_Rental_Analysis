--*********************************************************************************************************************--
--PostgreSQL MERGE
-- Target Table: The table you want to modify
-- Source Table: The table containing your new or updated data
-- Match Condition: The rule that determines if records match between your tables
--Comparison with ON CONFLICT
-- MERGE is more flexible (can handle multiple match conditions and DELETE)

-- MERGE is standard SQL (portable to other databases)

-- ON CONFLICT is often simpler for basic upserts
-- Limitations
-- Requires PostgreSQL 15 or later

-- Cannot use WITH clauses directly in the USING part

-- All WHEN clauses must have different conditions
--*********************************************************************************************************************--

-- Create the main products table
CREATE TABLE products_merge (
    product_id SERIAL PRIMARY KEY,
    name TEXT UNIQUE,
    price DECIMAL(10,2),
    stock INTEGER,
    status TEXT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Insert some initial data
INSERT INTO products_merge (name, price, stock, status) VALUES
    ('Laptop', 999.99, 50, 'active'),
    ('Keyboard', 79.99, 100, 'active'),
    ('Mouse', 29.99, 200, 'active');

-- Create a table for our updates
CREATE TABLE product_updates (
    name TEXT,
    price DECIMAL(10,2),
    stock INTEGER,
    status TEXT
);

-- Insert mixed update data (new products, updates, and discontinuations)
INSERT INTO product_updates VALUES
    ('Laptop', 1099.99, 75, 'active'),      -- Update: price and stock change
    ('Monitor', 299.99, 30, 'active'),      -- Insert: new product
    ('Keyboard', NULL, 0, 'discontinued'),  -- Delete: mark as discontinued
    ('Headphones', 89.99, 50, 'active');    -- Insert: another new product

--Using MERGE with RETURNING
-- Merge commad doesn't work on Postgresql 14 works on POstgresql 15 .
--The MERGE command in PostgreSQL (introduced in version 15) doesn't include RETURNING functionality like INSERT, UPDATE, and DELETE statements do.
--PostgreSQL 17's enhanced MERGE command can handle all three operations (INSERT, UPDATE, DELETE) while providing detailed feedback through the RETURNING clause:
--The MERGE statement allows you to conditionally INSERT, UPDATE, or DELETE rows in a target table based on the presence of matching records in a source table.
-- This consolidates multiple operations into a single, efficient command.
    -- UPDATE: The Laptop's price and stock were updated
    -- DELETE: The Keyboard is deleted from the products table
    -- INSERT: New Monitor and Headphones products were added

    MERGE INTO products_merge p
USING product_updates u
ON p.name = u.name
WHEN MATCHED AND u.status = 'discontinued' THEN
    DELETE
WHEN MATCHED AND u.status = 'active' THEN
    UPDATE SET
        price = COALESCE(u.price, p.price),
        stock = u.stock,
        status = u.status,
        last_updated = CURRENT_TIMESTAMP
WHEN NOT MATCHED AND u.status = 'active' THEN
    INSERT (name, price, stock, status)
    VALUES (u.name, u.price, u.stock, u.status);
--Advanced Usage with Conditions

      MERGE INTO products_merge p
USING (
    SELECT
        name,
        price,
        stock,
        status,
        CASE
            WHEN price IS NULL AND status = 'discontinued' THEN 'DELETE'
            WHEN stock = 0 THEN 'OUT_OF_STOCK'
            ELSE status
        END as action_type
    FROM product_updates
) u
ON p.name = u.name
WHEN MATCHED AND u.action_type = 'DELETE' THEN
    DELETE
WHEN MATCHED AND u.action_type = 'OUT_OF_STOCK' THEN
    UPDATE SET
        status = 'inactive',
        stock = 0,
        last_updated = CURRENT_TIMESTAMP
WHEN MATCHED THEN
    UPDATE SET
        price = COALESCE(u.price, p.price),
        stock = u.stock,
        status = u.status,
        last_updated = CURRENT_TIMESTAMP
WHEN NOT MATCHED AND u.action_type != 'DELETE' THEN
    INSERT (name, price, stock, status)
    VALUES (u.name, u.price, u.stock, u.status)

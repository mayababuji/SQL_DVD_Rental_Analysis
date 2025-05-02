--****************************************************************************************************************************************--
--PostgreSQL GROUPING SETS
--PostgreSQL feature that lets you compute multiple group-by aggregations in a single query. They're essentially a shorthand for combining several GROUP BY clauses with UNION ALL.
--****************************************************************************************************************************************--

--Setup a sample table

DROP TABLE IF EXISTS sales;

CREATE TABLE sales (
    brand VARCHAR NOT NULL,
    segment VARCHAR NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (brand, segment)
);

INSERT INTO sales (brand, segment, quantity)
VALUES
    ('ABC', 'Premium', 100),
    ('ABC', 'Basic', 200),
    ('XYZ', 'Premium', 100),
    ('XYZ', 'Basic', 300)
RETURNING *;

--- This query generated a single result set with the aggregates for all grouping sets.
-- Even though the above query works as you expected, it has two main problems.

-- First, it is quite lengthy.
-- Second, it has a performance issue because PostgreSQL has to scan the sales table separately for each query
--To make it more efficient, PostgreSQL provides the GROUPING SETS clause which is the subclause of the GROUP BY clause.
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand,
    segment

UNION ALL

SELECT
    brand,
    NULL,
    SUM (quantity)
FROM
    sales
GROUP BY
    brand

UNION ALL

SELECT
    NULL,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    segment

UNION ALL

SELECT
    NULL,
    NULL,
    SUM (quantity)
FROM
    sales;

--To apply this syntax to the above example, you can use GROUPING SETS clause instead of the UNION ALL clause like this:
--This query is much shorter and more readable. In addition, PostgreSQL will optimize the number of times it scans the sales table and will not scan multiple times.
SELECT
    brand,
    segment,
    SUM (quantity)
FROM
    sales
GROUP BY
    GROUPING SETS (
        (brand, segment),
        (brand),
        (segment),
        ()
    );

---Grouping function
--The GROUPING() function accepts an argument which can be a column name or an expression:
--The GROUPING() function returns bit 0 if the argument is a member of the current grouping set and 1 otherwise.
--GROUPING(brand) returns 1 when brand is aggregated (part of the grouping set)
--GROUPING(segment) returns 1 when segment is aggregated
--Understanding the contribution of each brand and segment to overall sales
SELECT
	GROUPING(brand) grouping_brand,
	GROUPING(segment) grouping_segment,
	brand,
	segment,
	SUM (quantity)
FROM
	sales
GROUP BY
	GROUPING SETS (
		(brand),
		(segment),
		()
	)
ORDER BY
	brand,
	segment;
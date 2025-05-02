--*********************************************************************************************************************
--PostgreSQL UNION
--Use the UNION to combine result sets of two queries and return distinct rows.
--Use the UNION ALL to combine the result sets of two queries but retain the duplicate rows.
--PostgreSQL UNION operator to combine result sets of multiple queries into a single result set.
-- Feature       | UNION |                         UNION ALL
-- Duplicates    | Removed                            | Kept
-- Performance   | Slower (due to deduping)           | Faster
-- Use Case      | When you need unique rows         | When you want full data
--Sorting        |May implicitly sort results        |Preserves original row order
--*********************************************************************************************************************

--setting up sample table

CREATE TABLE top_rated_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

CREATE TABLE most_popular_films(
  title VARCHAR NOT NULL,
  release_year SMALLINT
);

INSERT INTO top_rated_films(title, release_year)
VALUES
   ('The Shawshank Redemption', 1994),
   ('The Godfather', 1972),
   ('The Dark Knight', 2008),
   ('12 Angry Men', 1957);

INSERT INTO most_popular_films(title, release_year)
VALUES
  ('An American Pickle', 2020),
  ('The Godfather', 1972),
  ('The Dark Knight', 2008),
  ('Greyhound', 2020);
  --1) Basic PostgreSQL UNION example
  --he UNION operator to combine data from the queries that retrieve data from the top_rated_films and most_popular_films
  --The result set includes six rows because the UNION operator removes two duplicate rows
  SELECT * FROM top_rated_films
UNION
SELECT * FROM most_popular_films;

--2) PostgreSQL UNION ALL example
--the UNION ALL operator to combine result sets from queries that retrieve data from top_rated_films and most_popular_films tables:
--The output indicates that the UNION ALL operator retains the duplicate rows.
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films;

--3) PostgreSQL UNION ALL with ORDER BY clause example
--To sort the result returned by the UNION operator, you place the ORDER BY clause after the second query:
SELECT * FROM top_rated_films
UNION ALL
SELECT * FROM most_popular_films
ORDER BY title;
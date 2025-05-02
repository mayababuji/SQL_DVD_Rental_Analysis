--*********************************************************************************************************************--
--PostgreSQL Intersect
-- Operator     | Purpose                                   | Duplicates Removed            | Direction Matters
-- UNION        | Combine both sets                         | ✅ Yes                        | 🚫 No
-- INTERSECT    | Keep only matching rows from both sets    | ✅ Yes                        | 🚫 No
-- EXCEPT | Keep rows from the first not in second          | ✅ Yes                        | ✅ Yes
--*********************************************************************************************************************--
--Setting up sample tables

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

--1) Basic INTERSECT operator example
--The result set returns one film that appears on both tables.
SELECT *
FROM most_popular_films
INTERSECT
SELECT *
FROM top_rated_films;
--2) Using the INTERSECT operator with ORDER BY clause example
--The following statement uses the INTERSECT operator to find the most popular films which are also the top-rated films and sort the films by release year:
SELECT *
FROM most_popular_films
INTERSECT
SELECT *
FROM top_rated_films
ORDER BY release_year;

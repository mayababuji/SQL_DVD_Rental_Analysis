--*********************************************************************************************************************--
--PostgreSQL Except
-- Operator     | Purpose                                   | Duplicates Removed            | Direction Matters
-- UNION        | Combine both sets                         | ✅ Yes                        | 🚫 No
-- INTERSECT    | Keep only matching rows from both sets    | ✅ Yes                        | 🚫 No
-- EXCEPT | Keep rows from the first not in second          | ✅ Yes                        | ✅ Yes
--*********************************************************************************************************************--

--1) Basic EXCEPT operator example
--The following statement uses the EXCEPT operator to find the top-rated films that are not popular:
SELECT * FROM top_rated_films
EXCEPT
SELECT * FROM most_popular_films
ORDER BY title;
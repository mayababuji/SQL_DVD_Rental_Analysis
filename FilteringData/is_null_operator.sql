--****************************************************************************************************************************************--
--PostgreSQL IS NULL
--The IS NULL operator returns true if a value is NULL or false otherwise
--Use the IS NOT NULL operator returns true if a value is not NULL or false otherwise.
--****************************************************************************************************************************************--
--1) Basic IS NULL operator example
--find the addresses from the address table that the address2 column contains NULL:
SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NULL;
  --2) Using the IS NOT NULL operator example
--retrieve the address that has the address2 not NULL:
  SELECT
  address,
  address2
FROM
  address
WHERE
  address2 IS NOT NULL;
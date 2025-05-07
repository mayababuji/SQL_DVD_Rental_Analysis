--*********************************************************************************************************************--
--Import a CSV file into a table using COPY statement
--*********************************************************************************************************************--
--ERROR:  could not open file "/Users/maya/Documents/DVDRENTALPOSTGRESQL/mygit/SQL_DVD_Rental_Analysis/Import_Export/persons.csv" for reading: Permission denied
--HINT:  COPY FROM instructs the PostgreSQL server process to read a file. You may want a client-side facility such as psql's \copy. 

SQL state: 42501
COPY persons(first_name, last_name, dob, email)
FROM '/Users/maya/Documents/DVDRENTALPOSTGRESQL/mygit/SQL_DVD_Rental_Analysis/Import_Export/persons.csv'
DELIMITER ','
CSV HEADER;
--Solution
dvdrental=# \copy persons(first_name, last_name, dob, email) FROM '/Users/maya/Documents/DVDRENTALPOSTGRESQL/mygit/SQL_DVD_Rental_Analysis/Import_Export/persons.csv' WITH CSV HEADER DELIMITER ','


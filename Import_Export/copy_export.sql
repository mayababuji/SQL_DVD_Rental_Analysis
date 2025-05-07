--*********************************************************************************************************************--
--Export data from a table to CSV using the COPY statement
--The \copy command runs the COPY statement behind the scenes. However, instead of the server writing the CSV file, psql writes the CSV file and transfers data from the server to your local file system.

--To use \copy command, you need to have sufficient privileges to your local machine. It does not require PostgreSQL superuser privileges.
--*********************************************************************************************************************--

dvdrental=# \copy persons(first_name, last_name, dob, email) TO '/Users/maya/Documents/DVDRENTALPOSTGRESQL/mygit/SQL_DVD_Rental_Analysis/Import_Export/persons_db.csv' WITH CSV HEADER DELIMITER ','


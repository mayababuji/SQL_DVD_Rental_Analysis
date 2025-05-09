--*********************************************************************************************************************--
--PostgreSQL DROP TABLE
--*********************************************************************************************************************--
--1) Drop a table that does not exist
--[Err] ERROR:  table "author" does not exist

DROP TABLE author;
--to solve this use if exist
DROP TABLE IF EXISTS author;
--2) Drop a table that has dependent objects
--setting up an example
CREATE TABLE authors (
  author_id INT PRIMARY KEY,
  firstname VARCHAR (50) NOT NULL,
  lastname VARCHAR (50) NOT NULL
);

CREATE TABLE pages (
  page_id SERIAL PRIMARY KEY,
  title VARCHAR (255) NOT NULL,
  contents TEXT,
  author_id INT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES authors (author_id)
);
--drop table will issue error
-- ERROR:  cannot drop table authors because other objects depend on it
-- constraint pages_author_id_fkey on table pages depends on table authors 
-- Detail: constraint pages_author_id_fkey on table pages depends on table authors
-- Hint: Use DROP ... CASCADE to drop the dependent objects too.
DROP TABLE IF EXISTS authors;
-- to solve use CASCADE to drop
--This statement deletes the authors table as well as the constraint in the pages table.

DROP TABLE authors CASCADE;

--3) Drop multiple tables
--create sample table
CREATE TABLE tvshows(
  tvshow_id INT GENERATED ALWAYS AS IDENTITY,
  title VARCHAR,
  release_year SMALLINT,
  PRIMARY KEY(tvshow_id)
);

CREATE TABLE animes(
  anime_id INT GENERATED ALWAYS AS IDENTITY,
  title VARCHAR,
  release_year SMALLINT,
  PRIMARY KEY(anime_id)
);

--drop multiple tables
DROP TABLE tvshows, animes;


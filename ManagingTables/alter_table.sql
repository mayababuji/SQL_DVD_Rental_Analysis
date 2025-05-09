--*********************************************************************************************************************--
--PostgreSQL ALTER TABLE
--*********************************************************************************************************************--

DROP TABLE IF EXISTS links;

CREATE TABLE links (
   link_id serial PRIMARY KEY,
   title VARCHAR (512) NOT NULL,
   url VARCHAR (1024) NOT NULL
);
--To add a new column named active, you use the following statement:
ALTER TABLE links
ADD COLUMN active boolean;

--The following statement removes the activecolumn from the linkstable:
ALTER TABLE links
DROP COLUMN active;
--To change the name of the title column to link_title
ALTER TABLE links
RENAME COLUMN title TO link_title;
--The following statement adds a new column named targetto the linkstable
ALTER TABLE links
ADD COLUMN target VARCHAR(10);
--To set _blank as the default value for the targetcolumn in the linkstable
--If you insert the new row into the links table without specifying a value for the target column, the target column will take the _blank as the default value.
ALTER TABLE links
ALTER COLUMN target
SET DEFAULT '_blank';

--The following statement adds a CHECKcondition to the targetcolumn so that the targetcolumn only accepts the following values: _self, _blank, _parent, and _top:--

ALTER TABLE links
ADD CHECK (target IN ('_self', '_blank', '_parent', '_top'));

dvdrental-# \d links
                                       Table "public.links"
 Column  |          Type           | Collation | Nullable |                Default                 
---------+-------------------------+-----------+----------+----------------------------------------
 link_id | integer                 |           | not null | nextval('links_link_id_seq'::regclass)
 title   | character varying(512)  |           | not null | 
 url     | character varying(1024) |           | not null | 
 active  | boolean                 |           |          | 
 target  | character varying(10)   |           |          | '_blank'::character varying
Indexes:
    "links_pkey" PRIMARY KEY, btree (link_id)
Check constraints:
    "links_target_check" CHECK (target::text = ANY (ARRAY['_self'::character varying, '_blank'::character varying, '_parent'::character varying, '_top'::character varying]::text[]))


---The following statement adds a UNIQUE constraint to the url column of the links table:
--attempts to insert the url that already exists causes an error due to the unique_url constraint:
ALTER TABLE links
ADD CONSTRAINT unique_url UNIQUE ( url );

--The following statement changes the name of the links table to urls
ALTER TABLE links
RENAME TO urls;
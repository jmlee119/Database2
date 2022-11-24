  CREATE OR REPLACE  VIEW fox_studio (title, year) AS 
  SELECT  title, year
  FROM movie
  where studioname = 'fox';
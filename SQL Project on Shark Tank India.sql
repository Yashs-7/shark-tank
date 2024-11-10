select * from projectdata;

-- total episodes

SELECT MAX(ep) FROM projectdata;

SELECT COUNT(DISTINCT ep) FROM projectdata;


-- pitches 

SELECT COUNT(DISTINCT brand) FROM projectdata;


--pitches converted

SELECT AVG(a.EQUITY_TAKEN_)
FROM
  (SELECT *
   FROM projectdata
   WHERE EQUITY_TAKEN_ > 0) a;

-- total male

SELECT SUM(male) FROM projectdata;

-- total female

SELECT SUM(female) FROM projectdata;

--gender ratio

SELECT SUM(female) / SUM(male) AS gender_ratio
FROM projectdata;

-- total invested amount

SELECT SUM(AMOUNT_INVESTED_LAKHS) AS total_invested_amount
FROM projectdata;

-- avg equity taken

SELECT AVG(a.EQUITY_ASKED_)
FROM
  (SELECT *
   FROM projectdata
   WHERE EQUITY_ASKED_ > 0) a;

--highest deal taken

SELECT MAX(AMOUNT_INVESTED_LAKHS) FROM projectdata;

--higheest equity taken

SELECT MAX(EQUITY_TAKEN_) 
FROM projectdata;

-- startups having at least women

SELECT SUM(a.female_count) AS startups_having_at_least_women
FROM (
    SELECT CASE WHEN female > 0 THEN 1 ELSE 0 END AS female_count
    FROM projectdata -- Replace 'projectdata' with the correct table name
) a;

-- pitches converted having atleast ne women

SELECT *
FROM projectdata;

SELECT SUM(b.female_count)
FROM
  (SELECT CASE WHEN a.female > 0 THEN 1 ELSE 0 END AS female_count, a.*
   FROM
     (SELECT *
      FROM projectdata
      WHERE deal != 'No Deal') a) b;
	  
-- avg team members

SELECT AVG(team_members) FROM projectdata;

-- amount invested per deal

SELECT AVG(a.AMOUNT_INVESTED_LAKHS) AS amount_invested_per_deal
FROM (SELECT *
      FROM projectdata
      WHERE deal != 'No Deal') a;
	  
	  
-- avg age group of contestants

SELECT AVG_AGE, COUNT(AVG_AGE) AS cnt
FROM projectdata
GROUP BY AVG_AGE
ORDER BY cnt DESC;

-- location group of contestants

SELECT location, COUNT(location) AS cnt
FROM projectdata
GROUP BY location
ORDER BY cnt DESC;

-- sector group of contestants

SELECT sector, COUNT(sector) AS cnt
FROM projectdata
GROUP BY sector
ORDER BY cnt DESC;

--partner deals

SELECT partners, COUNT(partners) AS cnt
FROM projectdata
WHERE partners != '-'
GROUP BY partners
ORDER BY cnt DESC;

-- making the matrix

SELECT *
FROM projectdata;

SELECT 'Ashnner' AS keyy, COUNT(ASHNEER_AMOUNT_INVESTED)
FROM projectdata
WHERE ASHNEER_AMOUNT_INVESTED IS NOT NULL;

SELECT 'Ashnner' AS keyy, COUNT(CAST(ASHNEER_AMOUNT_INVESTED AS NUMBER))
FROM projectdata
WHERE ASHNEER_AMOUNT_INVESTED IS NOT NULL AND ASHNEER_AMOUNT_INVESTED != 0;


SELECT 'Ashneer' AS keyy, SUM(C.ASHNEER_AMOUNT_INVESTED), AVG(C.ASHNEER_EQUITY_TAKEN_)
FROM (SELECT *
      FROM projectdata
      WHERE ASHNEER_EQUITY_TAKEN_ != 0 AND ASHNEER_EQUITY_TAKEN_ IS NOT NULL) C;
      

SELECT m.keyy, m.total_deals_present, m.total_deals, n.total_amount_invested, n.avg_equity_taken
FROM (SELECT a.keyy, a.total_deals_present, b.total_deals
      FROM (SELECT 'Ashneer' AS keyy, COUNT(ASHNEER_AMOUNT_INVESTED) AS total_deals_present
            FROM projectdata
            WHERE ASHNEER_AMOUNT_INVESTED IS NOT NULL) a
      INNER JOIN (SELECT 'Ashneer' AS keyy, COUNT(ASHNEER_AMOUNT_INVESTED) AS total_deals
                  FROM projectdata
                  WHERE ASHNEER_AMOUNT_INVESTED IS NOT NULL AND ASHNEER_AMOUNT_INVESTED != 0) b
          ON a.keyy = b.keyy) m
INNER JOIN (SELECT 'Ashneer' AS keyy, SUM(C.ASHNEER_AMOUNT_INVESTED) AS total_amount_invested, AVG(C.ASHNEER_EQUITY_TAKEN_) AS avg_equity_taken
            FROM (SELECT *
                  FROM projectdata
                  WHERE ASHNEER_EQUITY_TAKEN_ != 0 AND ASHNEER_EQUITY_TAKEN_ IS NOT NULL) C) n
    ON m.keyy = n.keyy;
	

-- which is the startup in which the highest amount has been invested in each domain/sector

SELECT brand, sector, AMOUNT_INVESTED_LAKHS
FROM (
  SELECT brand, sector, AMOUNT_INVESTED_LAKHS, RANK() OVER (PARTITION BY sector ORDER BY AMOUNT_INVESTED_LAKHS DESC) AS rnk
  FROM projectdata
) c
WHERE c.rnk = 1;
	
	  
	  













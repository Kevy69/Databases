-- A)
FIX




-- B)
-- Both give the same result (albeit in a different order)

SELECT
	-- Select one of the values from the list of duplicate regions. can use MIN() or MAX().
	-- Has the same effect as using Region[0] in python, but with aggregate functions.
	MIN(Region) AS 'Region',
	MIN(Country) AS 'Country',
	MIN(City) AS 'City',

	-- Take the count of city, because where grouping all duplicate cities which gives us the customer count,
	-- given that each row represents a customer
	COUNT(City) AS 'Customers'
FROM
	company.customers
GROUP BY
	City
HAVING
	COUNT(City) >= 2;


/*
Better way of doing it.
Instead of using one GROUP BY, you could just GROUP BY multiple column rows in order to get
duplicate row values across columns. Read the question carefully and consider if one or several
GROUP BY's are needed
*/
SELECT
    Region,
    Country,
    City,
    -- Each row represents a customer, so might as well count by all column values
    COUNT(*) AS 'Customers'
FROM
    company.customers
GROUP BY
    Region,
    Country,
    City
HAVING
	-- Doesn't matter which one you chose, as it'll still filter out the same.
    COUNT(City) >= 2;




-- C)
-- Taken from answers sheet
DECLARE @Season as varchar(max);

SET @Season = '';

SELECT 
	@Season += CONCAT('Säsong ', Season, ' sändes från ', FORMAT(MIN([Original air date]), 'MMMM', 'sv'), ' till ',
      FORMAT(Max([Original air date]), 'MMMM yyyy', 'sv'), '. Totalt sändes ', COUNT(*), 
      ' avsnitt som i genomsnitt sågs av ', ROUND(AVG([U.S. viewers(millions)]),1),
      ' miljoner människor i USA',CHAR(13))
FROM 
    GameOfThrones
GROUP BY
    Season
ORDER BY 
    Season

PRINT @Season;




-- D)
SELECT
	FirstName + ' ' +  LastName AS 'Namn',
	
	-- NOTE: DATEDIFF assumes all years below 50 to be part of the 21'st century
	DATEDIFF(YEAR, SUBSTRING(ID, 1, 6), GETDATE()) AS 'Ålder',

	CASE
		WHEN CAST(SUBSTRING(ID, 10, 1) AS int) % 2 = 0 THEN 'Female'
		ELSE 'Male'
	END AS 'Kön'
FROM
	Users;




-- E)

SELECT
	Region AS 'Name',
	COUNT(Country) AS 'Number of countries',
	
    SUM(CAST(Population AS bigint)) AS 'Population',
    -- or
    SUM(CONVERT(bigint, Population)) AS 'Population',
	
    SUM([Area (sq# mi#)]) AS 'Area',

    -- take AVG of pop density and infant mortality
    ROUND(AVG(CAST(REPLACE([Pop# Density (per sq# mi#)], ',', '.') as float)),2) as 'Population Density',
    ROUND(AVG(CAST(REPLACE([Infant mortality (per 1000 births)], ',', '.') as float))*10,0) AS 'Infant Mortality (per 100,000 births)'
FROM
	Countries
GROUP BY
	Region;

-- F)
FIX
SELECT
    FirstName,
    5 AS 'Fem',
    UPPER(LastName) AS 'LastName',
    'Hejsan ' + FirstName + ' ' + LastName AS 'Greeting' 
FROM
    users 
WHERE
    LEN(FirstName) >= 10;




-- Limit rows
SELECT TOP 5 * FROM users;		-- T-SQL
SELECT * FROM users LIMIT 5;	-- ISO SQL




-- Example of IN
SELECT
    * 
FROM
    GameOfThrones 
WHERE
    [Directed BY] IN
    (
        'Alan Taylor',
        'David Nutter'
    );

-- Same thing as this
SELECT
    * 
FROM
    GameOfThrones
WHERE
    [Directed BY] = 'Alan Taylor' 
    OR [Directed BY] = 'David Nutter';




-- Exempel of BETWEEN
SELECT
    * 
FROM
    Airports 
WHERE
    IATA BETWEEN 'AAF' AND 'AAJ';

-- Same as this
SELECT
    * 
FROM
    Airports 
WHERE
    IATA >= 'AAF' 
    AND IATA <= 'AAJ';




-- Exempel of LIKE (mönstermatching)
-- NOTE: Pseudo code
SELECT
    * 
FROM
    users
WHERE
	FirstName LIKE '%a'; -- Names that end with 'a'
	FirstName LIKE 'a%'; -- Names that end with 'a'
	FirstName LIKE 'm_'; -- Names that begin with 'm' and have another char after (e.g two in total)
	FirstName LIKE '_[a]%'; -- Names that contain at least one 'a'




-- ORDER BY
SELECT
    * 
FROM
    users 
ORDER BY
    LastName ASC




-- DISTINCT
-- get unique
select distinct season from GameOfThrones




/* UNION
Merge two datasets. Get FirstName and LastName column from the Users table,
merge with Title and Directed By column from the GameOfThrones table, than sort.
*/
SELECT
    FirstName AS 'Förnamn',
    LastName AS 'Efternamn'
FROM
    Users

UNION ALL

SELECT
    Title,
    [Directed BY]
FROM
    GameOfThrones 
ORDER BY
    'Förnamn';




-- CASE - self explanatory
SELECT
    FirstName AS 'Förnamn',
    CASE
        WHEN len(FirstName) <= 4 THEN 'Kort' 
        WHEN len(FirstName) >= 8 THEN 'Långt' 
        ELSE 'Mellan'
    END
    AS 'Längd på förnamn' 
FROM
    users




CREATE TABLE Teachers
(
	Id INT PRIMARY key,
	Name NVARCHAR(MAX) NOT NULL,
	Age INT
);




SELECT * INTO users2 FROM dbo.Users;
TRUNCATE TABLE users2 
DROP TABLE users2;




INSERT INTO Teachers VALUES (1, 'Peter', 28);

INSERT INTO
    users2 (ID, FirstName) 
VALUES
	('123', 'goy');




UPDATE
	users2
SET
	Email = 'test' WHERE ID = '500603-4268';


UPDATE
    users2 
SET
    Email = FirstName + '@gmail.com' 
WHERE
    LEN(FirstName) = 4;



-- If statement
-- Add a new column called goy, fill it with yes/no depending on if statement return.
SELECT
	*,
	IIF(UserName = 'johlen', 'YES', 'NO') AS 'goy'
FROM
	users;




SELECT 'E' + FORMAT(Episode, '00') FROM GameOfThrones;




SELECT COUNT(*) FROM Elements;
MIN()
MAX()
AVG()
.. etc.

SELECT string_agg(Symbol, ', ') FROM Elements; -- outputs: H, He, Li, etc..




-- Group by
-- Group all common values in the Periods column and return a count.
-- If we dont use COUNT(), than it'll simply just return all the unique values
SELECT
	COUNT(Period)
FROM
	Elements
GROUP BY
    Period;

-- The only columns you can access while grouping, are the ones that are referenced (e.g grouped)
-- In order to access none grouped columns, you'd need to use aggregation.
SELECT
	Period,
    string_agg(Symbol, ', ')
FROM
	Elements
GROUP BY
    Period;


SELECT
	Period,
    string_agg(Symbol, ', ')
FROM
	Elements
GROUP BY
    Period
HAVING
	COUNT(Period) >= 18;


SELECT
	Period,
    string_agg(Symbol, ', ')
FROM
	Elements
WHERE
    Boilingpoint < 1000
GROUP BY
    Period
HAVING
	COUNT(Period) >= 18;



-- Variables
DECLARE @Name AS NVARCHAR(MAX) = 'Test';
SELECT @Name;

SET @Name = 'New val';



-- Groupings
SELECT 
	period, 
	count(period) AS 'Number of elements',
	string_agg(Symbol, ', ') AS 'Symbols'
FROM 
	Elements
WHERE
	Boilingpoint < 1000
GROUP by 
	period
having
	count(period) <= 3


select 
	id,
	ShipRegion,
	ShipCountry,
	ShipCity
from 
	company.orders 
order by
	ShipRegion, ShipCountry, ShipCity
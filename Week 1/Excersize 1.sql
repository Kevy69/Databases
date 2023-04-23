-- A)
-- The FORMAT function takes the season/episode and replaces the arbitrary diggits

SELECT
	Title,
	'S' + FORMAT(Season, '00') + 'E' + FORMAT(Episode, '00') as 'Episode'
FROM
	GameOfThrones;




-- B)
-- Do the operation, without updating the table column
SELECT
	LOWER(
		CONCAT(
			SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)
		)
	)
FROM
	Users2;

-- Same thing, update table column
UPDATE
	Users2
SET
	UserName = LOWER(CONCAT(SUBSTRING(FirstName, 1, 2), SUBSTRING(LastName, 1, 2)));




-- C)
UPDATE
	Airports2
SET
	Time = '-'
WHERE
	Time IS NULL;


UPDATE
    Airports2
SET
	DST = '-'
WHERE
	DST IS NULL;

-- Note: Can also use IFNULL(test, '-')




-- D)

DELETE FROM
    Elements2
WHERE
	Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
	OR Name LIKE 'd%'
	OR Name LIKE 'k%'
	OR Name LIKE 'm%'
	OR Name LIKE 'o%';
    OR Name LIKE 'u%'

-- or

DELETE FROM
	Elements2
WHERE
	Name IN ('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
	OR Name LIKE '[dkmou]%'
	OR Name LIKE '%[^a-zA-Z0-9][dkmou]%';




-- E)

ALTER TABLE
	Elements2
ADD
	Contains_Symbol nvarchar(3);


UPDATE
	Elements2
SET
	Contains_Symbol = 
		CASE 
			WHEN Name LIKE '%' + Symbol + '%' THEN 'YES' 
			ELSE 'NO' 
		END




-- F)
FIX


-- G)

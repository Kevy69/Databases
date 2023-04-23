-- A)
-- The FORMAT function takes the season/episode and replaces the arbitrary diggits.
-- Can either use 0's or #'s depending on needs
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

-- or with (preferred?)
UserName = LOWER(CONCAT(LEFT(FirstName, 2), LEFT(LastName, 2)))

-- or, if you'd like to remove åäö
UserName = TRANSLATE(LOWER(CONCAT(LEFT(FirstName, 2), LEFT(LastName, 2))), 'åäö', 'aao')




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

-- or
-- ISNULL sets without needing a Where clause
UPDATE
    Airports2
SET
	Time = ISNULL(Time, '-'),
	DST = ISNULL(DST, '-')




-- D)

DELETE FROM
	Elements2
WHERE
	Name IN('Erbium', 'Helium', 'Nitrogen', 'Platinum', 'Selenium')
	OR Name LIKE '[dkmou]%'

-- Can also do
	OR Name LIKE 'd%'
	OR Name LIKE 'k%'
	OR Name LIKE 'm%'
	OR Name LIKE 'o%';
    OR Name LIKE 'u%'




-- E)
-- NOTE: ort of an ambiguous question

ALTER TABLE
	Elements2
ADD
	Contains_Symbol nvarchar(3);


UPDATE
	Elements2
SET
	Contains_Symbol = 
		CASE 
			-- Use Symbol char count as length for LEFT
			WHEN LEFT(Symbol, LEN(Symbol)) = LEFT(Name, LEN(Symbol)) THEN 'Yes'
			ELSE 'No'
		END




-- Skipped F) G) as they where dumb
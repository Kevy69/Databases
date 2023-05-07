
/*
ACID
	Atomicity: The entire transaction takes place at once or doens't happen at all.
	Consistency: The database must be consistent before and after the transaction.
	Isolation: Multiple transactions occur independently without interference.
	Durability: The changes of a successful transaction occurs even if the system faliure occurs.
*/


BEGIN TRANSACTION;
ROLLBACK;
-- or
COMMIT;



-- rolling back stuff

BEGIN TRANSACTION;

DELETE FROM
	TEST
WHERE
	Gender = 'Male';

ROLLBACK;


SELECT
	*
FROM
	TEST;



-- Normal way of creating a table with one primary key

CREATE TABLE Users (
	Id INT PRIMARY KEY,
	Username NVARCHAR(MAX),
	Fullame NVARCHAR(MAX)
)

-- With two primary keys.
-- NOTE: MAX doens't work here.

CREATE TABLE Users (
	Id INT,
	Username NVARCHAR(50),
	Fullame NVARCHAR(50),
	CONSTRAINT PK_Users PRIMARY KEY (Id, Username)
)



-- table based constraints

CREATE TABLE Users (
	Id INT PRIMARY KEY,
	Minutes INT CHECK(Minutes > 10 AND Minutes < 15)
)



-- Misc
CREATE TABLE Users (
	Id INT PRIMARY KEY,
	Minutes INT DEFAULT(69),
	Minutes2 INT DEFAULT(GETDATE())
)



-- Views

CREATE VIEW
	OldUsers
AS
-- The view runs the below code
SELECT
	ID,
	FirstName,
	LastName
FROM
	Users
WHERE
	ID < '6';


SELECT * FROM OldUsers

-- NOTE: All normal operations (e.g DROP TABLE) work the same with views.


/*
TODO:
REMOVE QUESTION COMMENTS BEFORE HANDING IN
*/


/*
PREFACE

1. Using excessive spacing between "GO"'s due to my dyslexia.
2. Self explanatory code won't have any comments. The best part is no part.
*/





/*
Använd ”select into” för att ta ut kolumnerna ’Spacecraft’, ’Launch date’, 
’Carrier rocket’, ’Operator’, samt ’Mission type’ för alla lyckade uppdrag 
(Successful outcome) och sätt in i en ny tabell med namn ”SuccessfulMissions”. REMOVE
*/


-- CLEANUP, REMOVE
IF OBJECT_ID(N'dbo.SuccessfulMissions', N'U') IS NOT NULL
   DROP TABLE [dbo].SuccessfulMissions;


SELECT
	Spacecraft,
	[Launch date],
	[Carrier rocket],
	Operator,
	[Mission type]
INTO
	SuccessfulMissions
FROM
	MoonMissions
WHERE
	Outcome = 'Successful';




GO



/*
I kolumnen ’Operator’ har det smugit sig in ett eller flera mellanslag före 
operatörens namn skriv en query som uppdaterar ”SuccessfulMissions” och tar 
bort mellanslagen kring operatör. REMOVE
*/



UPDATE
	SuccessfulMissions
SET
	Operator = TRIM(Operator)

SELECT * FROM SuccessfulMissions
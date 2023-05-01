/*
TODO:
1. REMOVE QUESTION COMMENTS BEFORE HANDING IN
2. Question 4 is kinda sus. tf does he mean?
3. add more comments to code?


PREFACE

1. Using excessive spacing between "GO"'s due to my dyslexia.
2. Self explanatory code won't have any comments. The best part is no part.

Alright, lets begin!
*/





/*
Använd ”select into” för att ta ut kolumnerna ’Spacecraft’, ’Launch date’, 
’Carrier rocket’, ’Operator’, samt ’Mission type’ för alla lyckade uppdrag 
(Successful outcome) och sätt in i en ny tabell med namn ”SuccessfulMissions”. REMOVE
*/

-- REMOVE
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
    -- Use the trim function, which removes leading/trailing spaces
	Operator = TRIM(Operator)




GO




/*
I ett flertal fall har värden i kolumnen ’Spacecraft’ ett alternativt namn som står 
inom parantes, t.ex: ”Pioneer 0 (Able I)”. Skriv en query som uppdaterar 
”SuccessfulMissions” på ett sådant sätt att alla värden i kolumnen ’Spacecraft’ 
endast innehåller originalnamnet, dvs ta bort alla paranteser och deras 
innehåll. Ex: ”Pioneer 0 (Able I)” => ”Pioneer 0”. REMOVE
*/

UPDATE SuccessfulMissions
	SET Spacecraft =
		CASE
			WHEN
                -- Check if row value has paranthesis
				CHARINDEX('(', Spacecraft) > 0
			THEN
                -- Extract substring before the paranthesis by using LEFT and getting the char index.
                -- The '- 1' is to remove the beginning paranthesis as well.
				LEFT(Spacecraft, CHARINDEX('(', Spacecraft) - 1)
			ELSE
				Spacecraft
		END
FROM
	SuccessfulMissions;
    



GO




/*
Skriv en select query som tar ut, grupperar, samt sorterar på kolumnerna 
’Operator’ och ’Mission type’ från ”SuccessfulMissions”. Som en tredje kolumn 
’Mission count’ i resultatet vill vi ha antal uppdrag av varje operatör och typ. Ta 
bara med de grupper som har fler än ett (>1) uppdrag av samma typ och 
operatör. REMOVE
*/

SELECT
	Operator,
	[Mission type],
	COUNT(*) AS 'Mission count'
FROM
	SuccessfulMissions
GROUP BY
	Operator,
	[Mission type]
-- Using having instead of WHERE in order to filter based on aggregate
HAVING
    COUNT(*) > 1
ORDER BY
	Operator,
	[Mission type];




GO




/*
Ta ut samtliga rader och kolumner från tabellen ”Users”, men slå ihop 
’Firstname’ och ’Lastname’ till en ny kolumn ’Name’, samt lägg till en extra 
kolumn ’Gender’ som du ger värdet ’Female’ för alla användare vars näst sista 
siffra i personnumret är jämn, och värdet ’Male’ för de användare där siffran är 
udda. Sätt in resultatet i en ny tabell ”NewUsers”. REMOVE
*/

-- REMOVE
IF OBJECT_ID(N'dbo.NewUsers', N'U') IS NOT NULL
   DROP TABLE [dbo].NewUsers;


SELECT
	*,
	CONCAT(FirstName, ' ', LastName) AS 'Name',
	
	CASE
		WHEN
            /*
            Get the second to last number in the persons ID by taking a substring of the
            total ID length minus 1, than check if said number is even by taking the modulo.
            Female if even, male if not.
            */
			SUBSTRING(ID, LEN(ID) - 1, 1) % 2 = 0 THEN 'Female'
		ELSE
			'Male'
	END
		AS 'Gender'
INTO
	NewUsers
FROM
	Users;




GO




/*
Skriv en query som returnerar en tabell med alla användarnamn i ”NewUsers” 
som inte är unika i den första kolumnen, och antalet gånger de är duplicerade i 
den andra kolumnen. REMOVE
*/

SELECT
	UserName,
	COUNT(*) as 'Duplicate count'
FROM
	NewUsers
GROUP BY
    -- Groupby UserName in order allow for indirectly filtering 
	UserName
HAVING
    -- filter for groups with at least two of the same UserName
	COUNT(*) > 1;




GO




/*
Skriv en följd av queries som uppdaterar de användare med dubblerade 
användarnamn som du fann ovan, så att alla användare får ett unikt 
användarnamn. D.v.s du kan hitta på nya användarnamn för de användarna, så 
länge du ser till att alla i ”NewUsers” har unika värden på ’Username’. REMOVE
*/

-- följd means multiple queries? or should all be unified?

UPDATE
	NewUsers
SET
	UserName = 'jalmar'
WHERE
	ID = '880706-3713';


UPDATE
	NewUsers
SET
	UserName = 'jane'
WHERE
	ID = '811008-5301';


UPDATE
	NewUsers
SET
	UserName = 'daniel'
WHERE
	ID = '580802-4175';




GO




/*
Skapa en query som tar bort alla kvinnor födda före 1970 från ”NewUsers”.
*/

SELECT
	*
FROM
	NewUsers
WHERE
	Gender = 'Female'
	AND
	LEFT(ID, 2) <= 70
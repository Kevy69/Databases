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
(Successful outcome) och sätt in i en ny tabell med namn ”SuccessfulMissions”.
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
bort mellanslagen kring operatör.
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
innehåll. Ex: ”Pioneer 0 (Able I)” => ”Pioneer 0”.
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
operatör.
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
udda. Sätt in resultatet i en ny tabell ”NewUsers”.
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
den andra kolumnen.
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
länge du ser till att alla i ”NewUsers” har unika värden på ’Username’.
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

DELETE FROM
	NewUsers
WHERE
	Gender = 'Female'
	AND
    -- Check if the first two diggits of the SSN (which denote the date of birth)
    -- is less than or equal to 70
	LEFT(ID, 2) <= 70;




GO




/*
Lägg till en ny användare i tabellen ”NewUsers”. 
*/

INSERT INTO
	-- Specifying columns for added clarity
	NewUsers(
		ID,
		UserName,
		Password,
		FirstName,
		LastName,
		Email,
		Phone,
		Name,
		Gender
	)
VALUES
	(
		780420-6996,
		'snoopy',
		'42069',
		'snoop',
		'dogg',
		'420.blazeit@gmail.com',
		'0707696969',
		'snoop dogg',
		'Male'
	);




GO




/*
Skriv en query som returnerar två kolumner ’gender’ och ’avarage age’, och två 
rader där ena raden visar medelåldern för män, och andra raden visar 
medelåldern på kvinnor för alla användare i tabellen ”NewUsers”
*/

SELECT
	Gender AS 'Gender',

    -- Subtract the current year from the 20'th century representation of the birth dates.
    -- Add 1900 to the first two diggits of the ID
	AVG(YEAR(GETDATE()) - (1900 + LEFT(ID, 2))) AS 'Average age'
FROM
	NewUsers
-- Group by gender in order to run the code both males & females
GROUP BY Gender;




GO




/*
Skriv en query som selectar ut alla (77) produkter i company.products 
Dessa ska visas i 4 kolumner: 
Id – produktens id 
Product – produktens namn 
Supplier – namnet på företaget som leverar produkten 
Category – namnet på kategorin som produkten tillhör
*/

SELECT
	prod.Id,
	ProductName,
	CompanyName,
	CategoryName
FROM
    -- join the products, suppliers and categories tables using the
    -- SupplierId and CategoryId to the respective table id's in order to obtain the data needed
	company.products prod
	INNER JOIN company.suppliers sup ON prod.SupplierId = sup.Id
	INNER JOIN company.categories cat ON cat.Id = prod.CategoryId
    



GO




/*
Skriv en query som listar antal anställda i var och en av de fyra regionerna i 
tabellen company.regions
*/

SELECT
	RegionDescription AS 'Region',
	COUNT(*) AS 'Number of Employees'
FROM
    -- Join the employees, employee_territory, territories and regions tables in order to obtain
    -- the needed relational data
	company.employees emp
	INNER JOIN company.employee_territory emp_terr ON emp.Id = emp_terr.EmployeeId
	INNER JOIN company.territories terr ON emp_terr.TerritoryId = terr.Id
	INNER JOIN company.regions reg ON terr.RegionId = reg.Id
GROUP BY
    -- Group by in order to get the number of employees per region in each group
	RegionId,
	RegionDescription
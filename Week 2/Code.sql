select cast('19330720' as datetime2);

DATEDIFF(YEAR, '010610', GETDATE()) AS 'Ålder';


/*
types of joins

Primary & foreign key

Cross join,
Inner join,
left (outer) join,
right (outer) join,
full (outer) join
*/


SELECT * FROM countries;
SELECT * FROM cities;

SELECT
    *
    -- Filter out unwanted columns. Remember to use the correct table (e.g cities.name)
FROM
    cities
    INNER JOIN countries ON cities.countryid = countries.id;


-- Reverse
SELECT
    *
    -- Filter out unwanted columns. Remember to use the correct table (e.g cities.name)
FROM
    countries
    INNER JOIN cities ON countries.id = cities.countryid;




SELECT 
	ci.id,
	ci.name AS 'City',
	co.name AS 'Country'
FROM 
	cities ci
    INNER JOIN countries co ON ci.countryId = co.id
WHERE
	co.name = 'Sweden'




SELECT 
	--ci.id,
	--ci.name as 'City',
	co.name AS 'Country',
	count(ci.name) AS 'Number of cities',
	isnull(string_agg(ci.name, ', '), '-') AS 'List of cities'
FROM 
	cities ci 
	RIGHT OUTER JOIN countries co ON ci.countryId = co.id
GROUP BY
	co.name




-- Cross join
SELECT * FROM countries cross join cities;





SELECT * FROM courses;
SELECT * FROM students;
SELECT * FROM coursesStudents;

SELECT
	*
FROM
	courses c
	INNER JOIN coursesStudents cs ON c.id = cs.courseId
	INNER JOIN students s ON s.id = cs.StudentId
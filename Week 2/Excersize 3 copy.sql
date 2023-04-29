-- A)
-- wtf is going on?

select * from company.orders;
select * from company.order_details;

DECLARE @London_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.orders o JOIN company.order_details od on o.id = od.OrderId WHERE o.ShipCity = 'LONDON');
DECLARE @Num_products as FLOAT = (SELECT COUNT(DISTINCT od.ProductId) FROM company.order_details od)

PRINT(@London_products / @Num_products)

SELECT * FROM company.orders o JOIN company.order_details od on o.id = od.OrderId WHERE o.ShipCity = 'LONDON';


PRINT @Num_products;


-- Företagets totala produktkatalog består av 77 unika produkter.
-- Om vi kollar bland våra ordrar, hur stor andel av dessa produkter har vi någon gång leverarat till London?


DECLARE @test as INT = (SELECT * FROM company.orders WHERE ShipCity = 'London');
PRINT @test
PRINT @London_products




-- B)


SELECT
    COUNT(DISTINCT ProductId) AS 'Unique products ordered',
    ShipCity
FROM
    -- Join tables in order to get product id and shipcity in one table
    company.orders
    INNER JOIN company.order_details ON company.orders.Id = company.order_details.OrderId
GROUP BY
    -- ShipCity and not ProductId as ProductId would just return a list of cities per unique product id
    ShipCity
ORDER BY
    [Unique products ordered] desc;




-- C)
SELECT
	ROUND(
		SUM(
			(company.order_details.UnitPrice * Quantity * (1 - Discount)
		)
	), 0) AS 'Sold ($)'
FROM
	company.orders
	INNER JOIN company.order_details ON company.orders.Id = company.order_details.OrderId
	INNER JOIN company.products ON company.order_details.ProductId = company.products.Id
WHERE
	Discontinued = 1
	AND
	ShipCountry = 'Germany';




-- D)

SELECT TOP (1)
	CategoryName,

    -- Remember, where after 'lagervärde'
	SUM(p.UnitsInStock * p.UnitPrice) AS 'Storage value'
FROM
	company.products prod
	INNER JOIN company.categories cat ON prod.CategoryId = cat.Id
GROUP BY
	CategoryName
ORDER BY CategoryName DESC;
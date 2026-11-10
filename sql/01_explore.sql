USE AdventureWorks2022;
GO

-- 1. How big is the data?
SELECT COUNT(*) AS OrderHeaders FROM Sales.SalesOrderHeader;
SELECT COUNT(*) AS OrderLines   FROM Sales.SalesOrderDetail;
SELECT COUNT(*) AS Customers    FROM Sales.Customer;
SELECT COUNT(*) AS Products     FROM Production.Product;

-- 2. What date range do we have?
SELECT MIN(OrderDate) AS FirstOrder,
       MAX(OrderDate) AS LastOrder,
       MIN(ShipDate)  AS FirstShip,
       MAX(ShipDate)  AS LastShip
FROM Sales.SalesOrderHeader;

-- 3. Peek at the tables we'll use
SELECT TOP 10 * FROM Sales.SalesOrderHeader;
SELECT TOP 10 * FROM Sales.SalesOrderDetail;
SELECT TOP 10 * FROM Sales.SalesTerritory;

-- 4. Data quality check: products with no subcategory
SELECT COUNT(*) AS ProductsWithNoSubcategory
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;
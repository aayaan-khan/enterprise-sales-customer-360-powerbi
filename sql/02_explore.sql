USE AdventureWorks2022;
GO

CREATE OR ALTER VIEW dbo.vw_FactSales
AS
SELECT
    d.SalesOrderID,
    d.SalesOrderDetailID,
    h.OrderDate,
    h.ShipDate,
    h.CustomerID,
    d.ProductID,
    h.TerritoryID,
    h.OnlineOrderFlag,
    d.OrderQty,
    d.UnitPrice,
    d.UnitPriceDiscount,
    d.LineTotal,                              -- revenue after discount
    d.OrderQty * p.StandardCost AS TotalCost  -- cost of goods for this line
FROM Sales.SalesOrderDetail AS d
INNER JOIN Sales.SalesOrderHeader AS h
        ON h.SalesOrderID = d.SalesOrderID
INNER JOIN Production.Product AS p
        ON p.ProductID = d.ProductID;
GO
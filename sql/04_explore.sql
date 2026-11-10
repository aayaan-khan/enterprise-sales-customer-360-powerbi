USE AdventureWorks2022;
GO

WITH m AS (
    SELECT YEAR(f.OrderDate)  AS y,
           MONTH(f.OrderDate) AS mo,
           t.Region,
           p.Category,
           SUM(f.LineTotal)   AS rev
    FROM dbo.vw_FactSales f
    JOIN dbo.vw_DimTerritory t ON t.TerritoryID = f.TerritoryID
    JOIN dbo.vw_DimProduct   p ON p.ProductID   = f.ProductID
    GROUP BY YEAR(f.OrderDate), MONTH(f.OrderDate), t.Region, p.Category
),
b AS (
    SELECT y, mo, Region, Category,
           ROUND(rev * (0.85 + (ABS(CHECKSUM(y, mo, Region, Category)) % 31) / 100.0), -2) AS bud
    FROM m
)
SELECT y AS [Year], Region, Category,
       SUM(CASE WHEN mo = 1  THEN bud END) AS Jan,
       SUM(CASE WHEN mo = 2  THEN bud END) AS Feb,
       SUM(CASE WHEN mo = 3  THEN bud END) AS Mar,
       SUM(CASE WHEN mo = 4  THEN bud END) AS Apr,
       SUM(CASE WHEN mo = 5  THEN bud END) AS May,
       SUM(CASE WHEN mo = 6  THEN bud END) AS Jun,
       SUM(CASE WHEN mo = 7  THEN bud END) AS Jul,
       SUM(CASE WHEN mo = 8  THEN bud END) AS Aug,
       SUM(CASE WHEN mo = 9  THEN bud END) AS Sep,
       SUM(CASE WHEN mo = 10 THEN bud END) AS Oct,
       SUM(CASE WHEN mo = 11 THEN bud END) AS Nov,
       SUM(CASE WHEN mo = 12 THEN bud END) AS Dec
FROM b
GROUP BY y, Region, Category
ORDER BY y, Region, Category;
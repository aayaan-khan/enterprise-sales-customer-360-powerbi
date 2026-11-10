USE AdventureWorks2022;
GO

WITH base AS (
    SELECT
        c.CustomerID,
        p.FirstName,
        p.LastName,
        e.EmailAddress,
        ad.City,
        ad.StateProvince,
        ad.Country,
        CASE ABS(CHECKSUM(c.CustomerID)) % 2 WHEN 0 THEN 'M' ELSE 'F' END AS Gender,
        DATEADD(YEAR, -(20 + ABS(CHECKSUM(c.CustomerID, 'age')) % 50), '2014-06-30') AS BirthDate,
        CASE ABS(CHECKSUM(c.CustomerID, 'seg')) % 3
             WHEN 0 THEN 'Bronze' WHEN 1 THEN 'Silver' ELSE 'Gold' END AS Segment,
        20000 + ABS(CHECKSUM(c.CustomerID, 'inc')) % 120000 AS AnnualIncome
    FROM Sales.Customer AS c
    LEFT JOIN Person.Person       AS p ON p.BusinessEntityID = c.PersonID
    LEFT JOIN Person.EmailAddress AS e ON e.BusinessEntityID = p.BusinessEntityID
    OUTER APPLY (
        SELECT TOP 1 a.City, sp.Name AS StateProvince, cr.Name AS Country
        FROM Person.BusinessEntityAddress AS bea
        JOIN Person.Address        AS a  ON a.AddressID = bea.AddressID
        JOIN Person.StateProvince  AS sp ON sp.StateProvinceID = a.StateProvinceID
        JOIN Person.CountryRegion  AS cr ON cr.CountryRegionCode = sp.CountryRegionCode
        WHERE bea.BusinessEntityID = COALESCE(c.StoreID, c.PersonID)
        ORDER BY bea.AddressTypeID
    ) AS ad
),
dirty AS (
    SELECT
        CustomerID,
        CASE WHEN CustomerID % 13 = 0 THEN '  ' + FirstName + ' ' ELSE FirstName END AS FirstName,
        LastName,
        CASE WHEN CustomerID % 20 = 0 THEN '' ELSE EmailAddress END                  AS EmailAddress,
        City,
        StateProvince,
        CASE WHEN Country = 'United States'
             THEN CHOOSE(CustomerID % 4 + 1, 'United States', 'US', 'USA', 'united states ')
             ELSE Country END                                                        AS Country,
        CASE WHEN CustomerID % 9 = 0
             THEN CASE Gender WHEN 'M' THEN 'Male' ELSE 'Female' END
             ELSE Gender END                                                         AS Gender,
        CASE WHEN CustomerID % 50 = 0 THEN '1900-01-01'
             ELSE CONVERT(varchar(10), BirthDate, 23) END                            AS BirthDate,
        Segment,
        CASE WHEN CustomerID % 25 = 0 THEN 'N/A'
             WHEN CustomerID % 11 = 0 THEN '$' + FORMAT(AnnualIncome, 'N0')
             ELSE CAST(AnnualIncome AS varchar(20)) END                              AS AnnualIncome
    FROM base
)
SELECT * FROM dirty
UNION ALL
SELECT * FROM dirty WHERE CustomerID % 66 = 0;   -- ~300 duplicate rows
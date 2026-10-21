USE EcommerceAnalytics;
GO

SELECT
    COUNT_BIG(*) AS TotalRows,
    COUNT(DISTINCT Product_ID) AS DistinctProductIDs,
    COUNT(DISTINCT Product_Name) AS DistinctProductNames,
    COUNT(DISTINCT Category) AS DistinctCategories
FROM dbo.EcommerceRaw;
GO

SELECT
    Product_Name,
    COUNT_BIG(*) AS RecordCount,
    COUNT(DISTINCT Category) AS CategoryCount,
    COUNT(DISTINCT Product_ID) AS ProductIDCount,
    MIN(Price) AS MinimumPrice,
    MAX(Price) AS MaximumPrice,
    AVG(Price) AS AveragePrice
FROM dbo.EcommerceRaw
GROUP BY Product_Name
ORDER BY CategoryCount DESC, RecordCount DESC;
GO

-- Product_ID appeared with multiple names/categories/prices in the exploration.
SELECT
    Product_ID,
    COUNT(DISTINCT Product_Name) AS NameCount,
    COUNT(DISTINCT Category) AS CategoryCount,
    COUNT(DISTINCT Price) AS PriceCount
FROM dbo.EcommerceRaw
GROUP BY Product_ID
HAVING COUNT(DISTINCT Product_Name) > 1
    OR COUNT(DISTINCT Category) > 1
    OR COUNT(DISTINCT Price) > 1
ORDER BY Product_ID;
GO

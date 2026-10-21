USE EcommerceAnalytics;
GO

-- Descriptive product attributes by category; not transaction-based sales metrics.
SELECT
    Category,
    COUNT_BIG(*) AS TotalRecords,
    COUNT(DISTINCT Product_Name) AS DistinctProductNames,
    ROUND(AVG(Price), 2) AS AverageListedPrice,
    ROUND(AVG(CAST(Discount AS FLOAT)), 2) AS AverageDiscount,
    ROUND(AVG(CAST(Return_Rate AS FLOAT)), 2) AS AverageRecordedReturnRate,
    ROUND(AVG(CAST(Shipping_Cost AS FLOAT)), 2) AS AverageShippingCost,
    ROUND(AVG(CAST(Stock_Level AS FLOAT)), 2) AS AverageStockLevel
FROM dbo.EcommerceRaw
GROUP BY Category
ORDER BY AverageRecordedReturnRate DESC;
GO

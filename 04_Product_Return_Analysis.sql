USE EcommerceAnalytics;
GO

-- Recorded return-rate values, not actual returned-order counts.
SELECT
    Category,
    Product_Name,
    COUNT_BIG(*) AS RecordCount,
    ROUND(AVG(Price), 2) AS AverageListedPrice,
    ROUND(AVG(CAST(Discount AS FLOAT)), 2) AS AverageDiscount,
    ROUND(AVG(CAST(Return_Rate AS FLOAT)), 2) AS AverageRecordedReturnRate,
    ROUND(AVG(CAST(Shipping_Cost AS FLOAT)), 2) AS AverageShippingCost
FROM dbo.EcommerceRaw
GROUP BY Category, Product_Name
HAVING COUNT_BIG(*) >= 1000
ORDER BY AverageRecordedReturnRate DESC;
GO

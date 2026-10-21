USE EcommerceAnalytics;
GO

SELECT
    Category, Product_Name,
    COUNT_BIG(*) AS RecordCount,
    ROUND(AVG(Price), 2) AS AverageListedPrice,
    ROUND(AVG(CAST(Discount AS FLOAT)), 2) AS AverageDiscount,
    ROUND(AVG(CAST(Shipping_Cost AS FLOAT)), 2) AS AverageShippingCost,
    ROUND(AVG(CAST(Return_Rate AS FLOAT)), 2) AS AverageRecordedReturnRate,
    ROUND(AVG(CAST(Stock_Level AS FLOAT)), 2) AS AverageStockLevel
FROM dbo.EcommerceRaw
GROUP BY Category, Product_Name
HAVING COUNT_BIG(*) >= 1000
ORDER BY AverageRecordedReturnRate DESC;
GO

SELECT
    Shipping_Method,
    COUNT_BIG(*) AS RecordCount,
    ROUND(AVG(CAST(Shipping_Cost AS FLOAT)), 2) AS AverageShippingCost,
    ROUND(AVG(CAST(Return_Rate AS FLOAT)), 2) AS AverageRecordedReturnRate,
    ROUND(AVG(Price), 2) AS AverageListedPrice,
    ROUND(AVG(CAST(Discount AS FLOAT)), 2) AS AverageDiscount
FROM dbo.EcommerceRaw
GROUP BY Shipping_Method
ORDER BY AverageShippingCost DESC;
GO

SELECT
    Seasonality,
    COUNT_BIG(*) AS RecordCount,
    ROUND(AVG(Price), 2) AS AverageListedPrice,
    ROUND(AVG(CAST(Discount AS FLOAT)), 2) AS AverageDiscount,
    ROUND(AVG(CAST(Return_Rate AS FLOAT)), 2) AS AverageRecordedReturnRate,
    ROUND(AVG(CAST(Shipping_Cost AS FLOAT)), 2) AS AverageShippingCost
FROM dbo.EcommerceRaw
GROUP BY Seasonality
ORDER BY Seasonality;
GO

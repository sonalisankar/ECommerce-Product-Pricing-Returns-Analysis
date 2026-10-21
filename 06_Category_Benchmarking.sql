USE EcommerceAnalytics;
GO

WITH ProductMetrics AS (
    SELECT
        Category,
        Product_Name,
        COUNT_BIG(*) AS RecordCount,
        AVG(Price) AS AverageListedPrice,
        AVG(CAST(Discount AS FLOAT)) AS AverageDiscount,
        AVG(CAST(Return_Rate AS FLOAT)) AS ProductReturnRate,
        AVG(CAST(Shipping_Cost AS FLOAT)) AS AverageShippingCost
    FROM dbo.EcommerceRaw
    GROUP BY Category, Product_Name
    HAVING COUNT_BIG(*) >= 1000
),
CategoryBenchmarks AS (
    SELECT Category, AVG(ProductReturnRate) AS CategoryAverageReturnRate
    FROM ProductMetrics
    GROUP BY Category
)
SELECT
    p.Category, p.Product_Name, p.RecordCount,
    ROUND(p.ProductReturnRate, 2) AS ProductReturnRate,
    ROUND(b.CategoryAverageReturnRate, 2) AS CategoryAverageReturnRate,
    ROUND(p.ProductReturnRate - b.CategoryAverageReturnRate, 3)
        AS DifferenceFromCategoryAverage,
    ROUND(p.AverageListedPrice, 2) AS AverageListedPrice,
    ROUND(p.AverageShippingCost, 2) AS AverageShippingCost
FROM ProductMetrics AS p
INNER JOIN CategoryBenchmarks AS b ON p.Category = b.Category
ORDER BY DifferenceFromCategoryAverage DESC;
GO

USE EcommerceAnalytics;
GO

CREATE OR ALTER VIEW dbo.vw_ProductReturnBenchmark
AS
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
    p.Category,
    p.Product_Name,
    p.RecordCount,
    p.AverageListedPrice,
    p.AverageDiscount,
    p.ProductReturnRate,
    b.CategoryAverageReturnRate,
    p.ProductReturnRate - b.CategoryAverageReturnRate
        AS DifferenceFromCategoryAverage,
    p.AverageShippingCost
FROM ProductMetrics AS p
INNER JOIN CategoryBenchmarks AS b ON p.Category = b.Category;
GO

SELECT TOP (10)
    Category, Product_Name, RecordCount,
    ROUND(ProductReturnRate, 3) AS ProductReturnRate,
    ROUND(CategoryAverageReturnRate, 3) AS CategoryAverageReturnRate,
    ROUND(DifferenceFromCategoryAverage, 3) AS DifferenceFromCategoryAverage
FROM dbo.vw_ProductReturnBenchmark
ORDER BY DifferenceFromCategoryAverage DESC;
GO

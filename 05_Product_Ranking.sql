USE EcommerceAnalytics;
GO

WITH ProductAnalysis AS (
    SELECT
        Category,
        Product_Name,
        COUNT_BIG(*) AS RecordCount,
        AVG(Price) AS AverageListedPrice,
        AVG(CAST(Discount AS FLOAT)) AS AverageDiscount,
        AVG(CAST(Return_Rate AS FLOAT)) AS AverageRecordedReturnRate,
        AVG(CAST(Shipping_Cost AS FLOAT)) AS AverageShippingCost
    FROM dbo.EcommerceRaw
    GROUP BY Category, Product_Name
    HAVING COUNT_BIG(*) >= 1000
),
RankedProducts AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY Category
            ORDER BY AverageRecordedReturnRate DESC
        ) AS ReturnRateRank
    FROM ProductAnalysis
)
SELECT
    Category, Product_Name, RecordCount,
    ROUND(AverageListedPrice, 2) AS AverageListedPrice,
    ROUND(AverageDiscount, 2) AS AverageDiscount,
    ROUND(AverageRecordedReturnRate, 2) AS AverageRecordedReturnRate,
    ROUND(AverageShippingCost, 2) AS AverageShippingCost,
    ReturnRateRank
FROM RankedProducts
ORDER BY Category, ReturnRateRank, Product_Name;
GO

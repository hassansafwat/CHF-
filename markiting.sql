WITH RandomizedCustomers AS (
    SELECT 
        FT.phone_number,
        FT.Business_Date AS Receipt_Date,
        FT.Total AS Amount,
        DS.[Store_Name] AS Branch,
        ROW_NUMBER() OVER (PARTITION BY FT.Business_Date ORDER BY NEWID()) AS RowNum
    FROM Kazyon_EDW.Sales.Fact_Transactions AS FT
	LEFT JOIN [Kazyon_EDW].[Sales].[Dim_Stores]DS
	ON DS.Store_ID=FT.Store_ID
    WHERE FT.Phone_Number IS NOT NULL
        AND FT.Business_Date BETWEEN '20241111' AND '20241116'
        AND FT.Total > 799
        AND FT.Country_ID = 'EGYPT'
)
SELECT TOP 100
    phone_number,
    Receipt_Date,
    Amount,
    Branch
FROM RandomizedCustomers
ORDER BY NEWID(); -- Randomize selection

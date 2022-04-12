-- Sum of credit transactions by date from 2017 to 2021.
SELECT [Date], SUM(Amount) AS total
FROM dbo.Checking$
WHERE Amount > 0
	AND YEAR([Date]) BETWEEN 2017 and 2021
GROUP BY [Date]
ORDER BY [Date];

-- Total credit transactions.
SELECT SUM(Amount) AS total
FROM dbo.Checking$
WHERE Amount > 0;

-- Join advertising expenditure with revenue from 2017 to 2021 by day and fill in nulls with zero.
WITH credit_sum AS
(SELECT [Date], SUM(Amount) AS total
FROM dbo.Checking$
WHERE Amount > 0
	AND YEAR([Date]) BETWEEN 2017 and 2021
GROUP BY [Date])

SELECT ad.[Date], ad.[Advertising Amount], ISNULL(cs.total,0)
FROM dbo.Advertising$ ad
LEFT JOIN credit_sum cs
	ON ad.[Date] = cs.[Date]
ORDER BY ad.[Date];


-- Sum advertising and revenue by year
WITH credit_sum AS
(SELECT [Date], SUM(Amount) AS total
FROM dbo.Checking$
WHERE Amount > 0
	AND YEAR([Date]) BETWEEN 2017 and 2021
GROUP BY [Date])

SELECT YEAR(ad.[Date]) AS [Year], SUM(ad.[Advertising Amount])*-1 AS Advertising_Spent, SUM(ISNULL(cs.total,0)) AS Revenue
FROM dbo.Advertising$ ad
LEFT JOIN credit_sum cs
	ON ad.[Date] = cs.[Date]
GROUP BY YEAR(ad.[Date])
ORDER BY [Year];
WITH churn_rate_calc AS(
SELECT Churn, CASE
	WHEN Churn = 'Yes' THEN 1 ELSE 0
	END AS calculation,
	CASE 
	WHEN tenure BETWEEN 0 AND 11 THEN 'Less than 1 Year'
	WHEN tenure BETWEEN 12 AND 23 THEN '1 Year'
	WHEN tenure BETWEEN 24 AND 35 THEN '2 Years'
	ELSE '3+ Years'
	END AS tenure_bucket
FROM customers
)

SELECT tenure_bucket, ROUND(CAST(SUM(calculation) AS FLOAT) / COUNT(Churn), 3) * 100 AS churn_rate
FROM churn_rate_calc
GROUP BY tenure_bucket



--Internet Service Churn Rate

WITH service_calc AS(
SELECT InternetService, Churn, CASE
	WHEN Churn = 'Yes' THEN 1 
	ELSE 0
	END AS calculation
FROM customers
)
SELECT InternetService, 
		ROUND(CAST(SUM(calculation) AS FLOAT) / 
		COUNT(Churn), 3) * 100 AS churn_rate
FROM service_calc
GROUP BY InternetService

-- Fiber optic churns at 41.9%, more than double DSL (19.0%), 
--while customers with no internet service churn least (7.4%).
--Churn drops sharply with tenure (48.3% → 12.1%)
--Fiber optic customers churn 2x+ more than DSL, non-internet customers churn least.
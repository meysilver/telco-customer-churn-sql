 --What is our overall customer churn rate, and how does it break down by contract type?
WITH Churn_rate_calc AS(
SELECT Contract, Churn,customerID,
CASE WHEN Churn = 'Yes' THEN 1
	 ELSE 0
END AS Calculation
FROM customers
)
--SELECT Contract,ROUND(CAST(SUM(Calculation) AS FLOAT) / COUNT(Churn), 3) * 100 AS Churn_rate
--FROM Churn_rate_calc
--GROUP BY Contract

-- Across all customers
SELECT ROUND(CAST(SUM(Calculation) AS FLOAT) / COUNT(customerID),3) * 100 AS customer_churn
FROM Churn_rate_calc

--Overall churn is 26.5%, but month-to-month customers churn at over 15x the rate of two-year contract customers,
-- making contract type the clearest churn driver
--
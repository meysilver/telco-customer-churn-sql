
--Question 4: Support/service add-ons — Do customers without support-related add-ons (TechSupport, 
--OnlineSecurity, DeviceProtection) churn more than those with them?

WITH service AS(
SELECT DeviceProtection, Churn, CASE	
	WHEN Churn = 'Yes' THEN 1
	ELSE 0
	END AS calculation
FROM customers
)
SELECT DeviceProtection, 
ROUND(CAST(SUM(calculation) AS FLOAT) 
/ COUNT(Churn), 3) * 100 AS churn_rate
FROM service
GROUP BY DeviceProtection

--customers without any support/protection add-ons churn at roughly 2-3x the rate of those with them, 
--consistent across all three services.

--the highest-risk customer profile is month-to-month, fiber optic, electronic check, 
--no support add-ons, under 12 months tenure



--revenue recovery

SELECT Churn,
COUNT(*) AS customers_at_risk, SUM(MonthlyCharges) AS monthly_monetary_risk
FROM customers
WHERE Contract = 'Month-to-month' 
AND InternetService = 'Fiber optic'
AND PaymentMethod = 'Electronic check'
AND TechSupport = 'No'
AND tenure  < 12
GROUP BY Churn

--565 customers match this highest-risk profile, representing $45,995.25 in monthly recurring revenue — annualized, 
--that's roughly $551,943 at risk if this segment churns at the rates accustomed 
--(remember, month-to-month alone churns at 42.7%, so a meaningful chunk of these 565 are likely to leave 
--without intervention)


-- what % of these 565 have actually churned already vs. are still active?7

--413 of the 565 highest-risk customers (73%) have already churned, taking $33,894.50/month with them. 
--Only 152 (27%) are still active, representing $12,100.75/month that's genuinely still recoverable if tackled urgently.
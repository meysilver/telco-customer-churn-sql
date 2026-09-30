-- Billing & revenue — Do customers who churn pay more or less on average than those who stay, 
--and does that vary by payment method?

SELECT Churn, '$' || format(ROUND(AVG(MonthlyCharges),2)) AS Avg_monthly_charges
FROM customers
GROUP BY Churn 

--Customers who churn pay more than customers that continue with the business
-- Variamce by payment method?
SELECT Churn, PaymentMethod, '$' || format(ROUND(AVG(MonthlyCharges),2)) AS Avg_monthly_charges
FROM customers
GROUP BY PaymentMethod, Churn

-- Indeed, it varies by mode of payment, where Credit card(auto), Bank transfer(auto) and Mailed check have a -$13(approx) churn loss.
-- Electronic check loses about $4 each month but relatively doesnt rival the above.

--churn rate by payment method
WITH churn_rate_calc AS(
SELECT PaymentMethod, Churn,
CASE WHEN Churn = 'Yes' THEN 1
ELSE 0
END AS churn_calc
FROM customers
)
SELECT PaymentMethod, ROUND(CAST(SUM(churn_calc) AS FLOAT) /COUNT(Churn),3)  * 100 || '%' AS churn_rate
FROM churn_rate_calc
GROUP BY PaymentMethod

-- Electronic check has the smallest billing gap between churners/stayers, but the highest churn rate by far
-- suggests electronic check isn't churning because of price, 
--something else about payment experience (friction, no auto-pay, etc.) is driving it away


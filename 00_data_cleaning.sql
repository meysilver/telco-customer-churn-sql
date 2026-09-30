--Data cleaning: Telco Customer Churn dataset



--  Check total row count matches expected (7,043 customers)
SELECT COUNT(*) FROM customers;



-- Check for nulls in key columns used in the analysis
SELECT

SUM(CASE WHEN tenure IS NULL THEN 1 ELSE 0 END) AS tenure_missing,
SUM(CASE WHEN MonthlyCharges IS NULL THEN 1 ELSE 0 END) AS MonthlyCharges_missing,
SUM(CASE WHEN TotalCharges IS NULL THEN 1 ELSE 0 END) AS TotalCharges_missing,
SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_missing,
SUM(CASE WHEN Churn IS NULL THEN 1 ELSE 0 END) AS Churn_missing

FROM customers;


-- Found 11 nulls in TotalCharges. Investigate before fixing.
SELECT customerID, tenure, Churn,MonthlyCharges, TotalCharges
FROM customers
WHERE TotalCharges IS NULL;

-- All 11 rows have tenure = 0. These are new customers who
-- haven't completed a billing cycle yet. Not an error but calculation gap.


---- Fix: set TotalCharges to 0 for these rows
-- updating TotalCharges column
UPDATE customers
SET TotalCharges = 0
WHERE TotalCharges IS NULL;

--checking for unique ID'S
SELECT DISTINCT(customerID)
FROM customers
-- 7043 unique customer ID's

--checking category consistency
SELECT DISTINCT Contract FROM customers;

SELECT DISTINCT PaymentMethod FROM customers;

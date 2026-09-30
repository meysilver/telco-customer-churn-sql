# Telecom Customer Churn Analysis

SQL analysis of a telecom subscriber dataset. The goal was to figure out
what's actually driving customer churn, and how much revenue is at risk
right now because of it.

## Dataset

IBM's Telco Customer Churn dataset. 7,043 customers, with fields for
tenure, contract type, billing, payment method, subscribed services, and
whether each customer churned.

Source: https://github.com/IBM/telco-customer-churn-on-icp4d

## Approach

Started with a baseline churn rate, then checked it against contract
type, billing, payment method, tenure, service type, and support
add-ons one at a time to see which ones actually mattered. Combined the
strongest factors into one risk segment and worked out what that segment
is worth in dollars.

## Findings

**Contract type matters most.** Overall churn is 26.5%. Month-to-month
customers churn at 42.7%. One-year contracts drop to 11.3%, two-year
contracts to 2.8%.

**Electronic check doesn't fit the billing pattern.** Customers who
churn pay a bit more on average than customers who stay, across every
payment method. But electronic check has the smallest billing gap of any
method (~$4-5) and by far the highest churn rate (45.3% vs 15-19% for
everyone else). Price isn't the explanation there. Something about the
payment method itself is losing customers.

**Most churn happens in the first year.** Under 12 months, churn is
48.3%. It drops to 29.5% by year two, 22.0% by year three, and 12.1%
after four years.

Fiber optic customers also churn more than DSL customers (41.9% vs
19.0%), which is worse for revenue since fiber is the pricier service.

**Support add-ons help.** Customers without TechSupport, OnlineSecurity,
or DeviceProtection churn at 2-3x the rate of customers who have them.

**Putting the risk factors together.** Combined the highest-risk traits
into one profile: month-to-month, fiber optic, electronic check, no tech
support, under 12 months tenure.

| | Customers | Monthly Revenue |
|---|---|---|
| Already churned | 413 (73%) | $33,894.50 |
| Still active | 152 (27%) | $12,100.75 |
| Total segment | 565 | $45,995.25 |

413 of those 565 customers are already gone. The 152 still active are
worth $12,100.75/month and are the ones worth acting on now.

## Recommendations

- Focus retention outreach on the 152 still-active, highest-risk customers
- Look into why electronic check customers leave at such a high rate,
  since it isn't about price
- Bundle tech support and online security into fiber optic onboarding
- Test incentives to move month-to-month customers onto annual contracts

## Tools

SQL (SQLite) for the analysis. Python (pandas, matplotlib) for the
charts.

## Files
─ telco_churn db/ Source CSV and SQLite database
├── screenshots/ Query result screenshots
├── 00_data_cleaning.sql
├── 01_churn_overview.sql
├── 02_billing_revenue.sql
├── 03_tenure_service.sql
└── 04_revenue_recovery.sql


## Running it

Open the SQLite database in `telco_churn db/` using DB Browser for SQLite
(or any SQLite tool) and run the queries in order — each one is commented
with the question it answers.

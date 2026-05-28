-- ============================================================
-- TELECOM CUSTOMER CHURN ANALYSIS
-- ============================================================


-- ============================================================
-- 1. Project Objective
-- ============================================================
-- The objective of this project is to analyze telecom customer
-- churn using SQL.
--
-- The analysis focuses on understanding customer churn rate,
-- customer status distribution, churn patterns by contract type,
-- payment method, internet type, satisfaction score, age group,
-- churn reasons, revenue loss, and high-value churned customers.
--
-- The final SQL outputs will be used to support Tableau dashboard
-- visualizations.
-- ============================================================

-- ============================================================
-- 2. Business Questions
-- ============================================================
-- 1. How many customers are available in the dataset?
-- 2. What is the customer distribution by status?
-- 3. What is the overall customer churn rate?
-- 4. What percentage of customers belongs to each customer status?
-- 5. Which contract type has the highest churn rate?
-- 6. Which payment method has the highest churn rate?
-- 7. Which internet type has the highest churn rate?
-- 8. How does satisfaction score affect customer churn?
-- 9. Which age group has the highest churn rate?
-- 10. What are the most common churn categories and churn reasons?
-- 11. Which churn category is associated with the highest revenue loss?
-- 12. What percentage of total revenue was lost from churned customers?
-- 13. Which customer segments have high churn risk and revenue loss?
-- 14. Which high-CLTV churned customers should be reviewed for win-back analysis?
-- ============================================================

-- ============================================================
-- SQL IMPORT CHECK
-- ============================================================

SHOW TABLES;

-- ============================================================
--  VIEW THE DATA
-- ============================================================

SELECT *
FROM cleaned_telco_churn
LIMIT 10;

-- ============================================================
-- TOTAL CUSTOMERS
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM cleaned_telco_churn;

-- ============================================================
-- CUSTOMER STATUS BREAKDOWN
-- ============================================================

SELECT customer_status, COUNT(*) as total_customers
FROM cleaned_telco_churn
GROUP BY customer_status
ORDER BY total_customers DESC;


-- ============================================================
-- OVERALL CHURN RATE
-- ============================================================

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn;

-- ============================================================
-- CUSTOMER STATUS PERCENTAGE
-- ============================================================

SELECT 
    customer_status,
    COUNT(*) AS total_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM cleaned_telco_churn), 2) AS percentage_of_customers
FROM cleaned_telco_churn
GROUP BY customer_status
ORDER BY total_customers DESC;


-- ============================================================
-- CHURN RATE BY CONTRACT TYPE
-- ============================================================

SELECT
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn
GROUP BY contract
ORDER BY churn_rate_percentage DESC;

-- ============================================================
-- CHURN RATE BY PAYMENT METHOD
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn
GROUP BY payment_method
ORDER BY churn_rate_percentage DESC;


-- ============================================================
-- CHURN RATE BY INTERNET TYPE
-- ============================================================

SELECT 
    internet_type, 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn
GROUP BY internet_type
ORDER BY churn_rate_percentage DESC;

-- ============================================================
-- CHURN RATE BY SATISFACTION SCORE
-- ============================================================

SELECT
    satisfaction_score,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn
GROUP BY satisfaction_score
ORDER BY satisfaction_score;

-- ============================================================
-- CHURN RATE BY AGE GROUP
-- ============================================================

SELECT
    age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage
FROM cleaned_telco_churn
GROUP BY age_group
ORDER BY churn_rate_percentage DESC;

-- ============================================================
-- TOP CHURN REASONS
-- ============================================================

SELECT churn_category, churn_reason, COUNT(*) AS churned_customers
FROM cleaned_telco_churn
WHERE customer_status = 'Churned'
GROUP BY churn_category, churn_reason
ORDER BY churned_customers DESC;

-- ============================================================
-- REVENUE LOSS BY CHURN CATEGORY
-- ============================================================

SELECT churn_category, COUNT(*) AS churned_customers, ROUND(SUM(total_revenue), 2) AS revenue_loss
FROM cleaned_telco_churn
WHERE customer_status = 'Churned'
GROUP BY churn_category
ORDER BY revenue_loss DESC; 

-- ============================================================
-- OVERALL REVENUE LOSS FROM CHURNED CUSTOMERS
-- ============================================================

SELECT
    ROUND(SUM(total_revenue), 2) AS total_revenue,
    ROUND(SUM(CASE WHEN customer_status = 'Churned' THEN total_revenue ELSE 0 END), 2) AS revenue_lost_from_churn,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN total_revenue ELSE 0 END) * 100.0 / SUM(total_revenue),
        2
    ) AS revenue_loss_percentage
FROM cleaned_telco_churn;


-- ============================================================
-- HIGH-RISK CUSTOMER SEGMENT FOR RETENTION
-- ============================================================

SELECT
    contract,
    internet_type,
    satisfaction_score,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS churn_rate_percentage,
    ROUND(
        SUM(CASE WHEN customer_status = 'Churned' THEN total_revenue ELSE 0 END),
        2
    ) AS revenue_lost
FROM cleaned_telco_churn
GROUP BY contract, internet_type, satisfaction_score
HAVING COUNT(*) >= 20
ORDER BY churn_rate_percentage DESC, revenue_lost DESC;

-- ============================================================
-- HIGH CLTV CHURNED CUSTOMERS
-- ============================================================

SELECT customer_id, customer_status, contract,internet_type,satisfaction_score, total_revenue, cltv
FROM cleaned_telco_churn
WHERE customer_status = 'Churned'
ORDER BY cltv DESC;


-- ============================================================
-- 3. Key Insights
-- ============================================================

-- 1. The dataset contains 3,676 customers.

-- 2. Customer churn is a major business issue.
-- Out of 3,676 customers, 1,869 customers churned,
-- resulting in an overall churn rate of 50.84%.

-- 3. Churned customers represent the largest customer status group.
-- Churned customers account for 50.84% of total customers,
-- followed by Stayed customers at 45.29% and Joined customers at 3.86%.

-- 4. Month-to-Month contract customers have the highest churn rate.
-- Month-to-Month customers have a churn rate of 74.52%,
-- compared with 24.02% for One Year contracts and 6.28% for Two Year contracts.

-- 5. Customers using Bank Withdrawal and Mailed Check payment methods
-- show higher churn risk.
-- Bank Withdrawal has a churn rate of 57.14%,
-- while Mailed Check has a churn rate of 56.57%.
-- Credit Card customers show a lower churn rate of 36.21%.

-- 6. Fiber Optic customers have the highest churn rate by internet type.
-- Fiber Optic customers have a churn rate of 60.71%,
-- followed by Cable customers at 51.95% and DSL customers at 42.11%.
-- Customers with No internet service have the lowest churn rate at 22.55%.

-- 7. Customer satisfaction has a strong relationship with churn.
-- Customers with satisfaction scores of 1 and 2 have a 100.00% churn rate.
-- Customers with satisfaction score 3 have a churn rate of 34.46%.
-- Customers with satisfaction scores of 4 and 5 have 0.00% churn.

-- 8. Middle age customers have the highest churn rate by age group.
-- Middle age customers have a churn rate of 55.65%,
-- followed by Under 30 customers at 52.69%.
-- Senior Citizens have the lowest churn rate among age groups at 41.68%.

-- 9. Competitor-related reasons are the most common drivers of churn.
-- The top churn reasons include:
-- Competitor had better devices: 313 customers
-- Competitor made better offer: 311 customers
-- Attitude of support person: 220 customers

-- 10. Competitor is the highest revenue-loss churn category.
-- The Competitor category caused $1,694,413.15 in revenue loss,
-- which is much higher than Dissatisfaction, Attitude, Price, and Other categories.

-- 11. Churned customers caused a significant revenue impact.
-- Total revenue is $10,427,163.98.
-- Revenue lost from churned customers is $3,684,459.82,
-- which represents 35.34% of total revenue.

-- 12. The highest-risk customer segment is Month-to-Month Fiber Optic
-- customers with low satisfaction scores.
-- Month-to-Month Fiber Optic customers with satisfaction score 1
-- have a 100.00% churn rate and caused $1,148,252.81 in revenue loss.
-- Month-to-Month Fiber Optic customers with satisfaction score 2
-- also have a 100.00% churn rate and caused $564,908.31 in revenue loss.

-- 13. High-CLTV churned customers should be reviewed for win-back analysis.
-- The highest CLTV churned customer is customer_id 1043-YCUTE
-- with a CLTV of 6,484.
-- Other high-CLTV churned customers include 1323-OOEPC,
-- 0112-QWPNC, 5089-IFSDP, and 0406-BPDVR.

-- ============================================================


-- ============================================================
-- 4. Business Recommendations
-- ============================================================

-- 1. Focus retention efforts on Month-to-Month customers.
-- Month-to-Month customers have the highest churn rate,
-- so the company should encourage these customers to move toward
-- longer-term contracts through loyalty offers, discounts, or bundled plans.

-- 2. Prioritize low-satisfaction customers.
-- Customers with satisfaction scores of 1 and 2 show the highest churn risk.
-- These customers should be targeted first through service recovery,
-- priority support, and feedback-based improvement actions.

-- 3. Improve Fiber Optic customer experience.
-- Fiber Optic customers show the highest churn rate by internet type.
-- The company should review service quality, pricing, speed, reliability,
-- and customer support issues for this segment.

-- 4. Respond to competitor-driven churn.
-- Competitor-related reasons are the leading churn drivers and also cause
-- the highest revenue loss.
-- The company should review competitor pricing, device offers, plan benefits,
-- and promotional strategies.

-- 5. Improve billing and payment experience.
-- Bank Withdrawal and Mailed Check customers show higher churn rates.
-- The company should simplify billing, reduce payment friction,
-- and encourage more convenient payment options.

-- 6. Target high-risk customer segments first.
-- Month-to-Month Fiber Optic customers with low satisfaction scores
-- should be treated as the highest-priority retention segment because
-- they show both high churn rate and high revenue loss.

-- 7. Build a win-back strategy for high-CLTV churned customers.
-- Churned customers with high CLTV should be reviewed separately because
-- they represent strong long-term business value.
-- These customers can be targeted with personalized win-back offers.

-- 8. Use churn category revenue loss for business prioritization.
-- Churn categories with the highest revenue loss should receive priority
-- when planning customer retention, service improvement, and marketing actions.

-- ============================================================


-- ============================================================
-- 5. Tableau Dashboard Plan
-- ============================================================
-- The SQL analysis outputs will be used to build two interactive
-- Tableau dashboards for telecom customer churn analysis.

-- The dashboards will focus on churn analysis, churn drivers,
-- revenue impact, and high-value customer risk.

## -- Dashboards:

-- 1. Churn Analysis Dashboard
-- - Churned Customers
-- - Joined Customers
-- - Stayed Customers
-- - Churn Rate Percentage
-- - Churn Rate by Contract Type
-- - Churn Rate by Internet Type
-- - Churn Rate by Age Group
-- - Churn Rate by Satisfaction Score
-- - Top Churn Categories
-- - Top Churn Reasons

-- 2. Revenue KPI Dashboard
-- - Total Revenue
-- - Revenue Loss
-- - Revenue Loss Percentage
-- - Revenue Loss by Churn Category
-- - Revenue Loss by Churn Reason
-- - Revenue Loss Percentage by Payment Method
-- - Top 10 High CLTV Churned Customers
-- - High Risk Customer Segments
-- - Internet Type Filter
-- - Payment Method Filter
-- ============================================================


-- ============================================================
-- 6. Final Project Conclusion
-- ============================================================
-- This project analyzed telecom customer churn using SQL as part
-- of an end-to-end data analytics portfolio project.
--
-- The SQL analysis helped identify overall churn rate, customer
-- status distribution, churn patterns across customer segments,
-- major churn reasons, revenue loss, and high-value churned customers.
--
-- The analysis showed that churn is not random. Certain customer
-- groups, especially Month-to-Month customers, Fiber Optic customers,
-- customers with low satisfaction scores, and specific high-risk
-- customer segments, showed stronger churn patterns.
--
-- Revenue analysis showed that churned customers caused a significant
-- business impact, with revenue loss concentrated in specific churn
-- categories.
--
-- The high-CLTV churned customer analysis helped identify valuable
-- customers who should be reviewed for possible win-back strategy.
--
-- Overall, this SQL analysis provides a strong foundation for building
-- a Tableau dashboard and supporting data-driven customer retention
-- decisions.
-- ============================================================
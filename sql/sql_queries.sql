-- 1. Create cleaned customer consumption table

CREATE TABLE electricity_consumption_clean AS
SELECT
    customer_id,
    meter_id,
    region,
    customer_type,
    reading_date,
    consumption_kwh,
    bill_amount,
    payment_status,
    fraud_flag
FROM electricity_consumption
WHERE customer_id IS NOT NULL
  AND reading_date IS NOT NULL
  AND consumption_kwh IS NOT NULL;


-- 2. Check duplicate records

SELECT
    customer_id,
    reading_date,
    COUNT(*) AS duplicate_count
FROM electricity_consumption_clean
GROUP BY customer_id, reading_date
HAVING COUNT(*) > 1;


-- 3. Monthly consumption summary

SELECT
    customer_id,
    DATE_TRUNC('month', reading_date) AS billing_month,
    SUM(consumption_kwh) AS monthly_consumption_kwh,
    AVG(consumption_kwh) AS avg_daily_consumption,
    MAX(consumption_kwh) AS max_daily_consumption,
    MIN(consumption_kwh) AS min_daily_consumption
FROM electricity_consumption_clean
GROUP BY customer_id, DATE_TRUNC('month', reading_date);


-- 4. Fraud distribution by region

SELECT
    region,
    COUNT(*) AS total_records,
    SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) AS fraud_records,
    ROUND(
        SUM(CASE WHEN fraud_flag = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS fraud_percentage
FROM electricity_consumption_clean
GROUP BY region
ORDER BY fraud_percentage DESC;


-- 5. Suspicious low consumption customers

SELECT
    customer_id,
    AVG(consumption_kwh) AS avg_consumption,
    MIN(consumption_kwh) AS lowest_consumption,
    MAX(consumption_kwh) AS highest_consumption,
    CASE
        WHEN MIN(consumption_kwh) < AVG(consumption_kwh) * 0.5
        THEN 'Suspicious Drop'
        ELSE 'Normal'
    END AS risk_status
FROM electricity_consumption_clean
GROUP BY customer_id;


-- 6. Customer type fraud summary

SELECT
    customer_type,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT CASE WHEN fraud_flag = 1 THEN customer_id END) AS fraud_customers,
    ROUND(
        COUNT(DISTINCT CASE WHEN fraud_flag = 1 THEN customer_id END) * 100.0 /
        COUNT(DISTINCT customer_id),
        2
    ) AS fraud_rate_percentage
FROM electricity_consumption_clean
GROUP BY customer_type
ORDER BY fraud_rate_percentage DESC;

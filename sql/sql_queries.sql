-- 1. Create cleaned utility consumption table

CREATE TABLE utility_consumption_clean (
    customer_id VARCHAR(50),
    billing_month DATE,
    service_type VARCHAR(20),
    region VARCHAR(100),
    tariff_type VARCHAR(50),
    meter_id VARCHAR(50),
    previous_reading DECIMAL(18,2),
    current_reading DECIMAL(18,2),
    consumption_units DECIMAL(18,2),
    average_3m_consumption DECIMAL(18,2),
    average_6m_consumption DECIMAL(18,2),
    bill_amount DECIMAL(18,2),
    payment_status VARCHAR(30),
    anomaly_flag INT,
    anomaly_type VARCHAR(100),
    anomaly_score DECIMAL(10,4),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Basic data quality checks

SELECT 
    COUNT(*) AS total_records,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN consumption_units IS NULL THEN 1 ELSE 0 END) AS missing_consumption,
    SUM(CASE WHEN consumption_units < 0 THEN 1 ELSE 0 END) AS negative_consumption,
    SUM(CASE WHEN consumption_units = 0 THEN 1 ELSE 0 END) AS zero_consumption
FROM utility_consumption_clean;

-- 3. Detect abnormal consumption using business rules

SELECT
    customer_id,
    billing_month,
    service_type,
    consumption_units,
    average_3m_consumption,
    CASE
        WHEN consumption_units < 0 THEN 'Negative Consumption'
        WHEN consumption_units = 0 THEN 'Zero Consumption'
        WHEN consumption_units > average_3m_consumption * 3 THEN 'High Spike'
        WHEN consumption_units < average_3m_consumption * 0.2 THEN 'Sudden Drop'
        ELSE 'Normal'
    END AS anomaly_type
FROM utility_consumption_clean;

-- 4. Region-wise anomaly summary

SELECT
    region,
    service_type,
    COUNT(*) AS total_records,
    SUM(anomaly_flag) AS total_anomalies,
    ROUND(SUM(anomaly_flag) * 100.0 / COUNT(*), 2) AS anomaly_rate_percent
FROM utility_consumption_clean
GROUP BY region, service_type
ORDER BY anomaly_rate_percent DESC;

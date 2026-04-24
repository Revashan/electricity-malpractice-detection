# Electricity Malpractice Detection - Data Analyst Project

## Project Overview

This project analyzes electricity consumption data to identify possible malpractice or fraud activities such as electricity theft, meter tampering, abnormal consumption drops, and billing irregularities.

The project uses SQL, Python, and Power BI to clean, analyze, visualize, and detect suspicious customer behavior.

## Business Problem

Electricity providers lose revenue due to electricity theft and meter manipulation. Manual inspection is costly and time-consuming. This project helps identify high-risk customers using data-driven analysis.

## Objective

- Analyze electricity consumption patterns
- Detect abnormal consumption behavior
- Identify suspicious customers
- Build fraud-related KPIs
- Create an interactive Power BI dashboard
- Support inspection teams with actionable insights

## Dataset

Dataset source: Kaggle

## Tools Used

- SQL
- Python
- Pandas
- NumPy
- Scikit-learn
- Power BI
- DAX



## Project Workflow

1. Data Collection
2. Data Cleaning
3. Exploratory Data Analysis
4. Feature Engineering
5. Fraud Pattern Analysis
6. Machine Learning Model
7. Power BI Dashboard
8. Business Insights

## Key Features Created

| Feature | Description |
|---|---|
| avg_customer_consumption | Average usage per customer |
| consumption_drop_ratio | Current usage compared with average usage |
| sudden_drop_flag | Identifies sudden usage drop |
| high_usage_flag | Identifies unusually high consumption |
| month | Reading month |
| year | Reading year |

## Power BI Dashboard Pages

### 1. Executive Summary
Shows total customers, total consumption, fraud customers, fraud rate, and suspicious customers.

### 2. Fraud Analysis
Shows fraud by region, customer type, month, and customer risk level.

### 3. Customer Consumption Analysis
Shows detailed consumption trends and suspicious usage patterns.

## Key Insights

- Fraud cases are higher in selected regions.
- Commercial customers show higher fraud risk.
- Sudden consumption drops are strong indicators of malpractice.
- Consumption behavior is more useful than billing amount alone.
- Data-driven inspection prioritization can reduce manual effort.

## Machine Learning Model

Random Forest Classifier was used because it handles non-linear relationships and works well with structured tabular data.

Evaluation metrics used:

- Precision
- Recall
- F1 Score
- Confusion Matrix

## Business Impact

This project can help electricity providers:

- Reduce revenue loss
- Prioritize inspection activities
- Detect suspicious customers early
- Improve fraud monitoring
- Build a scalable analytics dashboard

## Conclusion

The project demonstrates how electricity malpractice can be detected using consumption behavior, customer profile data, fraud labels, and dashboard analytics.

## Author
 Revathy

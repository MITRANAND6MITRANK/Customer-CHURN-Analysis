Customer Churn Analysis
Project Overview

This project is an end-to-end analysis of customer churn, demonstrating the complete workflow from raw data to actionable insights. The goal is to identify patterns that predict churn and provide dashboards for management decision-making.

Key highlights:

Full data pipeline: SQL → Power Query → DAX → Power BI dashboards

Customer churn prediction and analysis

Clean, reproducible structure for end-to-end BI workflow

Project Pipeline
1️⃣ Data (01_data/)

Raw_data.csv → Original customer dataset

cleaned.csv → Cleaned and pre-processed data ready for analysis

2️⃣ SQL Queries (02_sql/)

sql_churn_data_pipeline.sql → SQL scripts for data cleaning, feature engineering, and churn calculation

3️⃣ Power Query Transformations (03_power_query/)

Step-by-step transformations performed in Power Query to shape and map features

Examples:

Churn status calculation

Age and tenure grouping

Services unpivot for better analytics

4️⃣ DAX Measures (04_dax_measures/)

Summary page KPIs:

Total Customers, Total Churn, Churn Rate, New Joiners

Churn Prediction Page:

Count of predicted churners

Dynamic title measures for dashboard visuals

Tools & Technologies

Database: PostgreSQL

BI & Analytics: Power BI (Power Query, DAX)

Data Handling: CSV, SQL transformations

Version Control: Git & GitHub

Key Insights & Outcomes

Visual dashboards for monitoring churn

KPI metrics to track customer retention

Predictive insights to identify customers at risk of churn

Demonstrated end-to-end BI project skills suitable for recruiters

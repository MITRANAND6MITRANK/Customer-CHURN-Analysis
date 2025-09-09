/* =========================================================
   Customer Churn Analysis – SQL Pipeline
   Author: MITRANAND6MITRANK
   Description:
   This script performs data exploration, cleaning, and 
   export steps for churn dataset in PostgreSQL.
   ========================================================= */

/* =========================================================
   01. Data Exploration – Basic Counts
   ========================================================= */

-- View all data
SELECT * FROM churn_data;

-- Gender distribution
SELECT 
    Gender, 
    COUNT(Gender) AS TotalCount,
    COUNT(Gender) * 100.0 / (SELECT COUNT(*) FROM churn_data) AS Percentage
FROM churn_data
GROUP BY Gender;

-- Contract distribution
SELECT 
    Contract, 
    COUNT(Contract) AS TotalCount,
    COUNT(Contract) * 100.0 / (SELECT COUNT(*) FROM churn_data) AS Percentage
FROM churn_data
GROUP BY Contract;

-- Revenue contribution by Customer_Status
SELECT 
    Customer_Status, 
    COUNT(Customer_Status) AS TotalCount, 
    SUM(Total_Revenue) AS TotalRev,
    SUM(Total_Revenue) / (SELECT SUM(Total_Revenue) FROM churn_data) * 100 AS RevPercentage
FROM churn_data
GROUP BY Customer_Status;

-- State distribution
SELECT 
    State, 
    COUNT(State) AS TotalCount,
    COUNT(State) * 100.0 / (SELECT COUNT(*) FROM churn_data) AS Percentage
FROM churn_data
GROUP BY State
ORDER BY Percentage DESC;

-- Total customers by state
SELECT COUNT(State) FROM churn_data;


/* =========================================================
   02. Data Exploration – Null Value Checks
   ========================================================= */

SELECT 
    COUNT(*) FILTER (WHERE Customer_ID IS NULL) AS Customer_ID_Null_Count,
    COUNT(*) FILTER (WHERE Gender IS NULL) AS Gender_Null_Count,
    COUNT(*) FILTER (WHERE Age IS NULL) AS Age_Null_Count,
    COUNT(*) FILTER (WHERE Married IS NULL) AS Married_Null_Count,
    COUNT(*) FILTER (WHERE State IS NULL) AS State_Null_Count,
    COUNT(*) FILTER (WHERE Number_of_Referrals IS NULL) AS Number_of_Referrals_Null_Count,
    COUNT(*) FILTER (WHERE Tenure_in_Months IS NULL) AS Tenure_in_Months_Null_Count,
    COUNT(*) FILTER (WHERE Value_Deal IS NULL) AS Value_Deal_Null_Count,
    COUNT(*) FILTER (WHERE Phone_Service IS NULL) AS Phone_Service_Null_Count,
    COUNT(*) FILTER (WHERE Multiple_Lines IS NULL) AS Multiple_Lines_Null_Count,
    COUNT(*) FILTER (WHERE Internet_Service IS NULL) AS Internet_Service_Null_Count,
    COUNT(*) FILTER (WHERE Internet_Type IS NULL) AS Internet_Type_Null_Count,
    COUNT(*) FILTER (WHERE Online_Security IS NULL) AS Online_Security_Null_Count,
    COUNT(*) FILTER (WHERE Online_Backup IS NULL) AS Online_Backup_Null_Count,
    COUNT(*) FILTER (WHERE Device_Protection_Plan IS NULL) AS Device_Protection_Plan_Null_Count,
    COUNT(*) FILTER (WHERE Premium_Support IS NULL) AS Premium_Support_Null_Count,
    COUNT(*) FILTER (WHERE Streaming_TV IS NULL) AS Streaming_TV_Null_Count,
    COUNT(*) FILTER (WHERE Streaming_Movies IS NULL) AS Streaming_Movies_Null_Count,
    COUNT(*) FILTER (WHERE Streaming_Music IS NULL) AS Streaming_Music_Null_Count,
    COUNT(*) FILTER (WHERE Unlimited_Data IS NULL) AS Unlimited_Data_Null_Count,
    COUNT(*) FILTER (WHERE Contract IS NULL) AS Contract_Null_Count,
    COUNT(*) FILTER (WHERE Paperless_Billing IS NULL) AS Paperless_Billing_Null_Count,
    COUNT(*) FILTER (WHERE Payment_Method IS NULL) AS Payment_Method_Null_Count,
    COUNT(*) FILTER (WHERE Monthly_Charge IS NULL) AS Monthly_Charge_Null_Count,
    COUNT(*) FILTER (WHERE Total_Charges IS NULL) AS Total_Charges_Null_Count,
    COUNT(*) FILTER (WHERE Total_Refunds IS NULL) AS Total_Refunds_Null_Count,
    COUNT(*) FILTER (WHERE Total_Extra_Data_Charges IS NULL) AS Total_Extra_Data_Charges_Null_Count,
    COUNT(*) FILTER (WHERE Total_Long_Distance_Charges IS NULL) AS Total_Long_Distance_Charges_Null_Count,
    COUNT(*) FILTER (WHERE Total_Revenue IS NULL) AS Total_Revenue_Null_Count,
    COUNT(*) FILTER (WHERE Customer_Status IS NULL) AS Customer_Status_Null_Count,
    COUNT(*) FILTER (WHERE Churn_Category IS NULL) AS Churn_Category_Null_Count,
    COUNT(*) FILTER (WHERE Churn_Reason IS NULL) AS Churn_Reason_Null_Count
FROM churn_data;


/* =========================================================
   03. Data Cleaning – Insert into Production Table
   ========================================================= */

INSERT INTO prod_churn (
    Customer_ID, Gender, Age, Married, State, Number_of_Referrals, Tenure_in_Months,
    Value_Deal, Phone_Service, Multiple_Lines, Internet_Service, Internet_Type,
    Online_Security, Online_Backup, Device_Protection_Plan, Premium_Support,
    Streaming_TV, Streaming_Movies, Streaming_Music, Unlimited_Data, Contract,
    Paperless_Billing, Payment_Method, Monthly_Charge, Total_Charges, Total_Refunds,
    Total_Extra_Data_Charges, Total_Long_Distance_Charges, Total_Revenue,
    Customer_Status, Churn_Category, Churn_Reason
)
SELECT 
    Customer_ID,
    Gender,
    Age,
    Married,
    State,
    Number_of_Referrals,
    Tenure_in_Months,
    COALESCE(Value_Deal, 'None'),
    Phone_Service,
    COALESCE(Multiple_Lines, 'No'),
    Internet_Service,
    COALESCE(Internet_Type, 'None'),
    COALESCE(Online_Security, 'No'),
    COALESCE(Online_Backup, 'No'),
    COALESCE(Device_Protection_Plan, 'No'),
    COALESCE(Premium_Support, 'No'),
    COALESCE(Streaming_TV, 'No'),
    COALESCE(Streaming_Movies, 'No'),
    COALESCE(Streaming_Music, 'No'),
    COALESCE(Unlimited_Data, 'No'),
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charge,
    Total_Charges,
    Total_Refunds,
    Total_Extra_Data_Charges,
    Total_Long_Distance_Charges,
    Total_Revenue,
    Customer_Status,
    COALESCE(Churn_Category, 'Others'),
    COALESCE(Churn_Reason, 'Others')
FROM churn_data;

-- Verify cleaned table
SELECT * FROM prod_churn;


/* =========================================================
   04. Export Cleaned Data
   ========================================================= */

-- Export prod_churn data to CSV (update path as per system)
\copy prod_churn TO 'C:/Users/Asus/Desktop/Data-Resources/prod_churn.csv' WITH CSV HEADER;


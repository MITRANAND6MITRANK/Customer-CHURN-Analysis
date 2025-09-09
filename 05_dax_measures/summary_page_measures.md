Summary Page - Measures

Total Customers = Count(prod_Churn[Customer_ID])

New Joiners = CALCULATE(COUNT(prod_Churn[Customer_ID]), prod_Churn[Customer_Status] = "Joined")

Total Churn = SUM(prod_Churn[Churn Status]) 

Churn Rate = [Total Churn] / [Total Customers]

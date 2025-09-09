Add a new column in prod_Churn
1.	Churn Status = if [Customer_Status] = "Churned" then 1 else 0
2.	Change Churn Status data type to numbers
3.	Monthly Charge Range = if [Monthly_Charge] < 20 then "< 20" else if [Monthly_Charge] < 50 then "20-50" else if [Monthly_Charge] < 100 then "50-100" else "> 100"

CREATE DATABASE churn_analysis;
USE churn_analysis;

SELECT * FROM customers;

SELECT COUNT(*)
FROM customers;

SELECT * FROM customers
WHERE TotalCharges IS NULL;

SELECT churn, COUNT(*)
FROM customers
GROUP BY churn;

SELECT Contract, COUNT(*)
FROM customers
WHERE churn = "Yes"
GROUP BY contract;

SELECT AVG(MonthlyCharges)
FROM customers;

SELECT churn, AVG(MonthlyCharges)
FROM customers
GROUP BY churn;


SELECT churn, AVG(tenure)
FROM customers
GROUP BY churn;

SHOW DATABASES;

USE churn_analysis;

SHOW TABLES;


SELECT
    Churn,
    ROUND(AVG(MonthlyCharges), 2) AS Average_Monthly_Charge,
    COUNT(*) AS Total_Customers
FROM customers
GROUP BY Churn;

SELECT Contract ,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn="Yes" THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(SUM(CASE WHEN Churn="Yes" THEN 1 ELSE 0 END)*100.0 /COUNT(*)) AS Churn_Rate
FROM customers
GROUP BY Contract
ORDER BY Churn_Rate DESC;

SELECT Churn,
COUNT(*) AS Total_Customers,
ROUND(AVG(tenure),2) AS Avg_Tenure,
MIN(tenure) AS Min_Tenure,
MAX(tenure) AS Max_Tenure
FROM customers
GROUP BY Churn;

SELECT customerID,
( 
CASE WHEN OnlineSecurity = 'Yes' THEN 1 ELSE 0 END +
CASE WHEN OnlineBackup = 'Yes' THEN 1 ELSE 0 END +
CASE WHEN DeviceProtection = 'Yes' THEN 1 ELSE 0 END +
CASE WHEN TechSupport = 'Yes' THEN 1 ELSE 0 END +
CASE WHEN StreamingTV = 'Yes' THEN 1 ELSE 0 END +
CASE WHEN StreamingMovies = 'Yes' THEN 1 ELSE 0 END )
AS Total_Services
FROM Customers
LIMIT 10;


SELECT
    Total_Services,
    COUNT(*) AS Total_Customers,

    SUM(CASE
            WHEN Churn='Yes'
            THEN 1
            ELSE 0
        END) AS Churned_Customers,

    ROUND(
        SUM(CASE
                WHEN Churn='Yes'
                THEN 1
                ELSE 0
            END)
        *100.0/COUNT(*),
        2
    ) AS Churn_Rate

FROM
(
    SELECT
        customerID,
        Churn,

        (
            CASE WHEN OnlineSecurity='Yes' THEN 1 ELSE 0 END +
            CASE WHEN OnlineBackup='Yes' THEN 1 ELSE 0 END +
            CASE WHEN DeviceProtection='Yes' THEN 1 ELSE 0 END +
            CASE WHEN TechSupport='Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingTV='Yes' THEN 1 ELSE 0 END +
            CASE WHEN StreamingMovies='Yes' THEN 1 ELSE 0 END
        ) AS Total_Services

    FROM customers
) AS ServiceData

GROUP BY Total_Services

ORDER BY Total_Services;


SELECT PaymentMethod, COUNT(*) AS Total_Customers,

SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)
AS Churned_Customers,

ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)
AS Churned_Rate

FROM Customers
GROUP BY PaymentMethod
ORDER BY Churned_Rate DESC;

SELECT Contract, PaymentMethod, COUNT(*) AS Total_Customer,

SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customer,

ROUND(SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2)
AS Churned_Rate

FROM Customers
GROUP BY Contract,PaymentMethod
ORDER BY Churned_Rate DESC;
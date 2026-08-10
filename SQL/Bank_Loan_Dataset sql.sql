USE bank_loan_db;

SHOW TABLES;

-- ===========================================
-- BANK LOAN DEFAULT & CREDIT RISK ANALYSIS
-- ===========================================

-- DISPLAY DATASET
SELECT * FROM bank_loan;

-- TABLE STRUCTURE
DESCRIBE bank_loan;

-- ===========================================
-- BASIC KPI ANALYSIS
-- ===========================================

-- TOTAL CUSTOMERS
SELECT COUNT(*) AS Total_Customers
FROM bank_loan;

-- TOTAL LOAN AMOUNT
SELECT SUM(Loan_Amount) AS Total_Loan_Amount
FROM bank_loan;

-- AVERAGE ANNUAL INCOME
SELECT AVG(Annual_Income) AS Average_Annual_Income
FROM bank_loan;

-- AVERAGE CREDIT SCORE
SELECT AVG(Credit_Score) AS Average_Credit_Score
FROM bank_loan;

-- TOTAL DEFAULT CUSTOMERS
SELECT SUM(`Default`) AS Total_Default_Customers
FROM bank_loan;

-- OVERALL DEFAULT RATE
SELECT
ROUND(SUM(`Default`) * 100.0 / COUNT(*),2) AS Default_Rate
FROM bank_loan;

-- ===========================================
-- CUSTOMER DISTRIBUTION
-- ===========================================

-- GENDER DISTRIBUTION
SELECT Gender,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Gender;

-- EMPLOYMENT TYPE DISTRIBUTION
SELECT Employment_Type,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Employment_Type;

-- PROPERTY AREA DISTRIBUTION
SELECT Property_Area,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Property_Area;

-- EDUCATION DISTRIBUTION
SELECT Education,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Education;

-- MARITAL STATUS DISTRIBUTION
SELECT Marital_Status,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Marital_Status;

-- ===========================================
-- LOAN ANALYSIS
-- ===========================================

-- LOAN PURPOSE ANALYSIS
SELECT
Loan_Purpose,
SUM(Loan_Amount) AS Total_Loan_Amount
FROM bank_loan
GROUP BY Loan_Purpose
ORDER BY Total_Loan_Amount DESC;

-- DEFAULT RATE BY LOAN PURPOSE
SELECT
Loan_Purpose,
COUNT(*) AS Total_Customers,
SUM(`Default`) AS Default_Customers,
ROUND(SUM(`Default`)*100.0/COUNT(*),2) AS Default_Rate
FROM bank_loan
GROUP BY Loan_Purpose
ORDER BY Default_Rate DESC;

-- LOAN AMOUNT BY LOAN TERM
SELECT
Loan_Term,
SUM(Loan_Amount) AS Total_Loan_Amount
FROM bank_loan
GROUP BY Loan_Term
ORDER BY Loan_Term;

-- ===========================================
-- CUSTOMER ANALYSIS
-- ===========================================

-- AVERAGE INCOME BY EMPLOYMENT TYPE
SELECT
Employment_Type,
AVG(Annual_Income) AS Average_Income
FROM bank_loan
GROUP BY Employment_Type;

-- AVERAGE CREDIT SCORE BY PROPERTY AREA
SELECT
Property_Area,
AVG(Credit_Score) AS Average_Credit_Score
FROM bank_loan
GROUP BY Property_Area;

-- DEFAULT CUSTOMERS BY GENDER
SELECT
Gender,
SUM(`Default`) AS Default_Customers
FROM bank_loan
GROUP BY Gender;

-- DEFAULT CUSTOMERS BY PROPERTY AREA
SELECT
Property_Area,
SUM(`Default`) AS Default_Customers
FROM bank_loan
GROUP BY Property_Area;

-- ===========================================
-- EXISTING DEBT ANALYSIS
-- ===========================================

SELECT
AVG(Existing_Debt) AS Average_Debt,
MAX(Existing_Debt) AS Maximum_Debt,
MIN(Existing_Debt) AS Minimum_Debt
FROM bank_loan;

-- ===========================================
-- FILTERING
-- ===========================================

-- HIGH INCOME CUSTOMERS
SELECT
Loan_ID,
Annual_Income
FROM bank_loan
WHERE Annual_Income > 1000000;

-- CREDIT SCORE ABOVE 700
SELECT
Loan_ID,
Credit_Score
FROM bank_loan
WHERE Credit_Score > 700;

-- TOP 10 HIGHEST LOAN AMOUNTS
SELECT
Loan_ID,
Loan_Amount
FROM bank_loan
ORDER BY Loan_Amount DESC
LIMIT 10;

-- ===========================================
-- RISK BUCKET (CASE WHEN)
-- ===========================================

SELECT
Loan_ID,
Credit_Score,
CASE
WHEN Credit_Score >= 750 THEN 'Low Risk'
WHEN Credit_Score >= 650 THEN 'Medium Risk'
ELSE 'High Risk'
END AS Risk_Level
FROM bank_loan;

-- DEFAULT RATE BY RISK LEVEL
SELECT
CASE
WHEN Credit_Score >= 750 THEN 'Low Risk'
WHEN Credit_Score >= 650 THEN 'Medium Risk'
ELSE 'High Risk'
END AS Risk_Level,
COUNT(*) AS Total_Customers,
SUM(`Default`) AS Default_Customers,
ROUND(SUM(`Default`)*100.0/COUNT(*),2) AS Default_Rate
FROM bank_loan
GROUP BY Risk_Level
ORDER BY Default_Rate DESC;

-- ===========================================
-- INCOME BRACKET (CASE WHEN)
-- ===========================================

SELECT
Loan_ID,
Annual_Income,
CASE
WHEN Annual_Income < 500000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 500000 AND 1000000 THEN 'Medium Income'
ELSE 'High Income'
END AS Income_Bracket
FROM bank_loan;

-- DEFAULT RATE BY INCOME BRACKET
SELECT
CASE
WHEN Annual_Income < 500000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 500000 AND 1000000 THEN 'Medium Income'
ELSE 'High Income'
END AS Income_Bracket,
COUNT(*) AS Total_Customers,
SUM(`Default`) AS Default_Customers,
ROUND(SUM(`Default`) * 100.0 / COUNT(*),2) AS Default_Rate
FROM bank_loan
GROUP BY Income_Bracket
ORDER BY Default_Rate DESC;

-- TOTAL LOAN AMOUNT BY INCOME BRACKET
SELECT
CASE
WHEN Annual_Income < 500000 THEN 'Low Income'
WHEN Annual_Income BETWEEN 500000 AND 1000000 THEN 'Medium Income'
ELSE 'High Income'
END AS Income_Bracket,
SUM(Loan_Amount) AS Total_Loan_Amount
FROM bank_loan
GROUP BY Income_Bracket;

-- ===========================================
-- RISK ANALYSIS
-- ===========================================

-- AVERAGE LOAN AMOUNT BY RISK LEVEL
SELECT
CASE
WHEN Credit_Score >= 750 THEN 'Low Risk'
WHEN Credit_Score >= 650 THEN 'Medium Risk'
ELSE 'High Risk'
END AS Risk_Level,
AVG(Loan_Amount) AS Average_Loan_Amount
FROM bank_loan
GROUP BY Risk_Level;

-- HIGH RISK CUSTOMERS
SELECT
Loan_ID,
Annual_Income,
Credit_Score,
Loan_Amount,
`Default`
FROM bank_loan
WHERE Credit_Score < 650
AND `Default` = 1;

-- ===========================================
-- CUSTOMER SEGMENTATION
-- ===========================================

-- CUSTOMERS BY PROPERTY AREA & GENDER
SELECT
Property_Area,
Gender,
COUNT(*) AS Customers
FROM bank_loan
GROUP BY Property_Area, Gender
ORDER BY Property_Area;

-- ===========================================
-- DEFAULT STATUS
-- ===========================================

-- CUSTOMERS WHO DEFAULTED
SELECT *
FROM bank_loan
WHERE `Default` = 1;

-- CUSTOMERS WHO DID NOT DEFAULT
SELECT *
FROM bank_loan
WHERE `Default` = 0;
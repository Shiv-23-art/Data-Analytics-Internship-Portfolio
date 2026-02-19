CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

CREATE TABLE ecommerce_returns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    User_ID VARCHAR(20),
    Order_Date DATE,
    Return_Date VARCHAR(10),
    Product_Category VARCHAR(50),
    Product_Price FLOAT,
    Order_Quantity INT,
    Return_Reason VARCHAR(100),
    Return_Status VARCHAR(20),
    Days_to_Return INT,
    User_Age INT,
    User_Gender VARCHAR(10),
    User_Location VARCHAR(50),
    Payment_Method VARCHAR(50),
    Shipping_Method VARCHAR(50),
    Discount_Applied FLOAT
);
SELECT COUNT(*) FROM ecommerce_returns;

SET SQL_SAFE_UPDATES = 0;

UPDATE ecommerce_returns
SET Return_Date = NULL
WHERE Return_Date = '';

SET SQL_SAFE_UPDATES = 1;

ALTER TABLE ecommerce_returns
MODIFY COLUMN Return_Date DATE;

SELECT Return_Status, COUNT(*) AS Total_Orders
FROM ecommerce_returns
GROUP BY Return_Status;

SELECT Product_Category,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned_Orders,
       ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Return_Rate_Percent
FROM ecommerce_returns
GROUP BY Product_Category
ORDER BY Return_Rate_Percent DESC;

SELECT Product_Category,
       ROUND(AVG(Days_to_Return), 2) AS Avg_Days_to_Return
FROM ecommerce_returns
WHERE Return_Status = 'Returned'
GROUP BY Product_Category
ORDER BY Avg_Days_to_Return DESC;

SELECT User_Gender,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned,
       ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Return_Rate_Percent
FROM ecommerce_returns
GROUP BY User_Gender;

SELECT ROUND(Discount_Applied, -1) AS Discount_Range,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returns,
       ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END)/COUNT(*) * 100, 2) AS Return_Rate_Percent
FROM ecommerce_returns
GROUP BY Discount_Range
ORDER BY Discount_Range;

SELECT Shipping_Method,
       COUNT(*) AS Total_Orders,
       SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) AS Returned_Orders,
       ROUND(SUM(CASE WHEN Return_Status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Return_Rate_Percent
FROM ecommerce_returns
GROUP BY Shipping_Method
ORDER BY Return_Rate_Percent DESC;

SELECT Return_Reason,
       COUNT(*) AS Total_Returns
FROM ecommerce_returns
WHERE Return_Status = 'Returned'
GROUP BY Return_Reason
ORDER BY Total_Returns DESC
LIMIT 5;
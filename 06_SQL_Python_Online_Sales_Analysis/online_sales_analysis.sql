CREATE DATABASE sales_analysis;
USE sales_analysis;
CREATE TABLE online_sales (
transaction_id INT,
order_date DATE,
product_category VARCHAR(100),
product_name VARCHAR(255),
units_sold INT,
unit_price DECIMAL(10, 2),
total_revenue DECIMAL(12, 2),
region VARCHAR(100),
payment_method VARCHAR(50)
);

INSERT INTO online_sales (
    transaction_id, order_date, product_category, product_name,
    units_sold, unit_price, total_revenue, region, payment_method
) VALUES
(1, '2023-01-05', 'Electronics', 'Smartphone', 3, 300.00, 900.00, 'North', 'Credit Card'),
(2, '2023-01-15', 'Fashion', 'T-shirt', 5, 20.00, 100.00, 'South', 'UPI'),
(3, '2023-02-10', 'Home Appliances', 'Vacuum Cleaner', 2, 150.00, 300.00, 'East', 'Debit Card'),
(4, '2023-02-25', 'Electronics', 'Laptop', 1, 1000.00, 1000.00, 'West', 'Net Banking'),
(5, '2023-03-03', 'Fashion', 'Jeans', 4, 40.00, 160.00, 'North', 'Cash on Delivery'),
(6, '2023-03-15', 'Fashion', 'Sneakers', 2, 60.00, 120.00, 'South', 'Credit Card'),
(7, '2023-04-01', 'Electronics', 'Headphones', 6, 50.00, 300.00, 'East', 'UPI'),
(8, '2023-04-12', 'Home Appliances', 'Microwave', 1, 200.00, 200.00, 'West', 'Credit Card'),
(9, '2023-05-10', 'Fashion', 'Jacket', 3, 80.00, 240.00, 'North', 'Net Banking'),
(10, '2023-05-20', 'Electronics', 'Tablet', 2, 400.00, 800.00, 'South', 'UPI'),
(11, '2023-06-07', 'Home Appliances', 'Refrigerator', 1, 1200.00, 1200.00, 'East', 'Debit Card'),
(12, '2023-06-25', 'Fashion', 'Dress', 4, 70.00, 280.00, 'West', 'Credit Card'),
(13, '2023-07-15', 'Fashion', 'Watch', 2, 150.00, 300.00, 'North', 'Cash on Delivery'),
(14, '2023-08-05', 'Electronics', 'Smartwatch', 3, 120.00, 360.00, 'South', 'UPI'),
(15, '2023-08-22', 'Home Appliances', 'Washing Machine', 1, 800.00, 800.00, 'East', 'Net Banking');

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT transaction_id) AS order_volume,
    SUM(total_revenue) AS total_revenue
FROM 
    online_sales
GROUP BY 
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY 
    month;
    
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(total_revenue) AS total_revenue
FROM online_sales
GROUP BY year, month
ORDER BY total_revenue DESC
LIMIT 3;

SELECT 
    YEAR(order_date) AS year,
    COUNT(DISTINCT transaction_id) AS total_orders,
    SUM(total_revenue) AS total_revenue
FROM online_sales
GROUP BY year
ORDER BY year;

SELECT 
    YEAR(order_date) AS year,
    QUARTER(order_date) AS quarter,
    COUNT(DISTINCT transaction_id) AS total_orders,
    SUM(total_revenue) AS total_revenue
FROM online_sales
GROUP BY year, quarter
ORDER BY year, quarter;

WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        COUNT(DISTINCT transaction_id) AS order_volume,
        SUM(total_revenue) AS monthly_revenue
    FROM online_sales
    GROUP BY month
)
SELECT 
    month,
    order_volume,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month) AS cumulative_revenue
FROM monthly_sales
ORDER BY month;

SELECT 
    product_category,
    SUM(total_revenue) AS category_revenue,
    (SUM(total_revenue) / (SELECT SUM(total_revenue) FROM online_sales)) * 100 AS revenue_percentage
FROM online_sales
GROUP BY product_category
ORDER BY category_revenue DESC;

WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_revenue) AS monthly_revenue
    FROM online_sales
    GROUP BY month
)
SELECT 
    month,
    monthly_revenue,
    LAG(monthly_revenue, 1) OVER (ORDER BY month) AS previous_month_revenue,
    (monthly_revenue - LAG(monthly_revenue, 1) OVER (ORDER BY month)) / LAG(monthly_revenue, 1) OVER (ORDER BY month) * 100 AS revenue_growth_percentage
FROM monthly_sales
ORDER BY month;

WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(order_date, '%Y-%m') AS month,
        SUM(total_revenue) AS monthly_revenue
    FROM online_sales
    GROUP BY month
)
SELECT 
    month,
    monthly_revenue,
    AVG(monthly_revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_revenue
FROM monthly_sales
ORDER BY month;
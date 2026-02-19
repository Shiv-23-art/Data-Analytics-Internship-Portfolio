# Online Sales Trend Analysis (SQL + Python)

Objective:
Perform time-based sales analysis using SQL for aggregation and Python for visualization, focusing on monthly revenue trends and performance insights.

Tools Used:
- MySQL
- Python
- Pandas
- Matplotlib
- mysql.connector

Project Scope:
- Designed database structure and inserted transactional sales data
- Performed monthly and yearly revenue analysis using SQL
- Calculated cumulative revenue using window functions
- Identified top-performing months based on revenue
- Visualized monthly trends and rolling averages in Python

SQL Techniques Applied:
- GROUP BY with DATE_FORMAT() and EXTRACT()
- SUM() for revenue aggregation
- COUNT(DISTINCT transaction_id) for order tracking
- Window functions (SUM() OVER()) for cumulative revenue analysis

Python Analysis:
- Connected Python to MySQL database
- Generated time-series revenue charts
- Implemented 3-month rolling average for trend smoothing

Key Insights:
- Identified seasonal revenue fluctuations
- Observed progressive revenue growth over time
- Highlighted peak-performing months contributing to overall sales performance

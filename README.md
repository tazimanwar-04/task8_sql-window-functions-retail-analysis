# Task 8 – SQL Window Functions Analysis (MySQL)

## Overview
This project demonstrates the practical use of **SQL window functions** using a retail sales dataset.  
The objective is to perform advanced analytical queries such as ranking, running totals, and month-on-month growth analysis using **MySQL 8+**.

The dataset was first cleaned and standardized using **Python (Jupyter Notebook)** and then imported into MySQL for analysis.

---

## Dataset
- Source: Retail / Superstore-style sales dataset
- Total Records: 9,994
- Key Columns Used:
  - order_date
  - customer_id
  - customer_name
  - region
  - category
  - product_name
  - sales
  - profit

Column names were cleaned and converted to `snake_case` before loading into MySQL.

---

## Tools & Technologies
- MySQL 8+
- MySQL Workbench
- Python (Pandas)
- Jupyter Notebook
- CSV files

---

## Tasks Performed

### 1. Data Cleaning
- Renamed columns to SQL-friendly format
- Converted date columns to datetime
- Exported cleaned dataset as CSV

### 2. Customer Sales Aggregation
- Calculated total sales per customer per region using `GROUP BY`

### 3. Ranking Customers by Region
- Used `ROW_NUMBER()` with `PARTITION BY region`
- Ranked customers based on total sales within each region

### 4. Ranking Function Comparison
- Compared `ROW_NUMBER()`, `RANK()`, and `DENSE_RANK()`
- Analyzed tie-handling behavior

### 5. Running Total of Sales
- Calculated daily and cumulative sales over time
- Used `SUM() OVER (ORDER BY order_date)`

### 6. Month-on-Month (MoM) Growth
- Aggregated sales at monthly level
- Used `LAG()` to calculate MoM sales change

### 7. Top 3 Products per Category
- Ranked products using `DENSE_RANK()`
- Extracted top 3 products within each category

### 8. Exporting Results
- Exported analytical results to CSV files for submission

---

## Output Files
- `task8_window.sql` – All SQL queries
- `ranked_customers.csv` – Customer ranking per region
- `mom_growth.csv` – Month-on-month sales growth
- `top_products.csv` – Top 3 products per category
- `insights_task8.txt` – Business insights derived from analysis

---

## Key Learnings
- Practical use of SQL window functions
- Difference between ranking functions
- Importance of data aggregation before window operations
- Real-world analytical thinking using SQL

---

## Conclusion
This task showcases how SQL window functions can be used to solve real business problems such as customer ranking, trend analysis, and product performance evaluation. The project follows an end-to-end analytical workflow from data cleaning to insight generation.

use task8_sql;
select * from retail_clean
limit 5;
select customer_id,
customer_name,
sum(sales) as total_sales
from retail_clean
group by customer_id, customer_name;

select customer_id,
customer_name,
region,
sum(sales) as total_sales,
avg(sales) as average,
min(sales) as min_sales,
max(sales) as max_sales
from retail_clean
group by customer_id, customer_name, region;
select
customer_id,
customer_name,
region,
sum(sales) AS total_sales,
row_number() over(partition by region
order by sum(sales) desc) as region_rank
from retail_clean
group by customer_id, customer_name, region;

select customer_id,
customer_name,
region,
sum(sales) as total_sales,
row_number() over(partition by region order by sum(sales) desc)
as row_num,
rank() over(partition by region order by sum(sales) desc) as rank_num,
dense_rank() over(partition by region order by sum(sales) desc) as dense_rank_num
from retail_clean
group by customer_id, customer_name, region;

select
order_date, 
sum(sales) as daily_sales
from retail_clean
where order_date is not null
group by order_date
order by order_date;

select
order_date,
sum(sales) as daily_sales,
sum(sum(sales)) over(order by order_date) as running_total_sales
from retail_clean
where order_date is not null
group by order_date
order by order_date;

select 
date_format(order_date, '%Y-%m') as order_month,
sum(sales) as monthly_sales,

sum(sum(sales)) over (
order by date_format(order_date, '%Y-%m')
) as running_total_sales
from retail_clean
where order_date is not null
group by order_month
order by order_month;

select
date_format(order_date, '%y-%m') as order_month,
sum(sales) as montly_sales
from retail_clean
where order_date is not null
group by order_month
order by order_month;


-- add lag() to get previous month sales --

select
order_month,
monthly_sales,
lag(monthly_sales, 1) over (
order by order_month
) as previous_month_sales
from (
select 
date_format(order_date, '%y-%m') as order_month,
sum(sales) as monthly_sales
from retail_clean
where order_date is not null
group by order_month
) t;

-- Calculate MoM growth--
 SELECT
    order_month,
    monthly_sales,
    previous_month_sales,
    (monthly_sales - previous_month_sales) AS mom_growth
FROM (
    SELECT
        order_month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY order_month) AS previous_month_sales
    FROM (
        SELECT
            DATE_FORMAT(order_date, '%Y-%m') AS order_month,
            SUM(sales) AS monthly_sales
        FROM retail_clean
        WHERE order_date IS NOT NULL
        GROUP BY order_month
    ) m
) f;

select
category,
product_name,
sum(sales) as total_sales
from
retail_clean
group by category, product_name;

select
category,
product_name,
total_sales,
dense_rank() over(partition by category 
order by total_sales desc)
as product_rank
from (
select 
category,
product_name,
sum(sales) as total_sales
from retail_clean
group by category, product_name
) t;

select category,
product_name,
total_sales,
product_rank
from(
select
category,
product_name,
sum(sales) as total_sales,
dense_rank() over(partition by category order by sum(sales) desc)
as product_rank
from retail_clean
group by category, product_name
) ranked_products
where product_rank <= 3
group by category, product_rank;


SELECT
    customer_id,
    customer_name,
    region,
    SUM(sales) AS total_sales,
    ROW_NUMBER() OVER (
        PARTITION BY region
        ORDER BY SUM(sales) DESC
    ) AS region_rank
FROM retail_clean
GROUP BY customer_id, customer_name, region;


SELECT
    order_month,
    monthly_sales,
    previous_month_sales,
    (monthly_sales - previous_month_sales) AS mom_growth
FROM (
    SELECT
        order_month,
        monthly_sales,
        LAG(monthly_sales, 1) OVER (ORDER BY order_month) AS previous_month_sales
    FROM (
        SELECT
            DATE_FORMAT(order_date, '%Y-%m') AS order_month,
            SUM(sales) AS monthly_sales
        FROM retail_clean
        WHERE order_date IS NOT NULL
        GROUP BY order_month
    ) m
) f;

SELECT
    category,
    product_name,
    total_sales,
    product_rank
FROM (
    SELECT
        category,
        product_name,
        SUM(sales) AS total_sales,
        DENSE_RANK() OVER (
            PARTITION BY category
            ORDER BY SUM(sales) DESC
        ) AS product_rank
    FROM retail_clean
    GROUP BY category, product_name
) ranked_products
WHERE product_rank <= 3
ORDER BY category, product_rank;



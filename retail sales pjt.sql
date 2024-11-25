-- SQL Retail Sales Analysis - P1
create table retail_sales(transaction_id int primary key,sale_date date,sale_time time,
customer_id	 int,gender	varchar(10),age int,category varchar(20),quantity int,
price_per_unit float,cogs float,total_sale float
); 
--Return top 10 rows from table
select * from retail_sales limit 10;
--Total number of records in my dataset:2000
select count(*) from retail_sales;
--Data cleaning:
--i)Checking for null vlaues in each column
SELECT * FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
--ii)Only three records are null so i decided to Remove those.
DELETE  FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
--now my data dont have null values.
/*Data Exploration*/
-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

/*Data Analysis*/
select * from retail_sales;
-- Q.1 Write a SQL query to calculate the total sales (total_sale) for each category.
select category,sum(total_sale) as net_sale from retail_sales group by(category);


-- Q.2 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales where sale_date = '2022-11-05'

-- Q.3 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
select * from retail_sales where category = 'Clothing' and quantity>3 and sale_date between'2022-11-01' and '2022-11-30';


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
select round(avg(age),3) as avgerage_age from retail_sales where category = 'Beauty';


--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1200.
select * from retail_sales where total_sale > 1200;


-- Q.6 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
select 
case
	when extract(hour from sale_time)<12 then 'Morning'
    when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
    else 'Evening'
end as shift,count(*) as total_orders from retail_sales group by shift;

-- Q.7 Write a SQL query to find the number of unique customers who purchased items from each category.
select category,count(distinct transaction_id) as uni_customers from retail_sales group by category;


-- Q.8 Write a SQL query Which category and gender combination has the highest number of sales, and what is that number?
select category,gender,count(*) as sale_hierarcy from retail_sales group by category,gender order by 1;

--Q.9 Write a SQL query count of gender purchase in beauty category.
select gender,count(category) as beauty_category from retail_sales where category = 'Beauty' group by gender,category;

/*Business Key Problems*/
--Problem:1. Determine the top-selling categories and their total sales over a specified period.
select category,
	sum(quantity) as tot_qnty_sold,
	sum(total_sale) as tot_revenue
from retail_sales
	group by category
	order by tot_revenue desc
	limit 3;
--Problem:2. Analyze the age and gender distribution of customers making purchases.
select 
	gender,
	round(avg(age),0) as average_age,
	COUNT(DISTINCT customer_id) AS unique_customers
from retail_sales
	group by gender; 

--Problem:3.Calculate the total revenue generated on each day.
select sale_date,
	sum(total_sale) as total_revenue
from retail_sales
group by sale_date
order by sale_date;

--Problem:4. Find out which time of day has the highest sales volume.

select 
	extract(hour from sale_time) as sale_hour,
	sum(total_sale) as tot_revenue
from retail_sales
group by sale_hour
order by tot_revenue desc
limit 1;


--Problem:5. Identify if certain categories or demographics show seasonal buying trends.
SELECT 
    category,
    EXTRACT(MONTH FROM sale_date) AS sale_month,
    SUM(total_sale) AS tot_revenue
FROM 
    retail_sales
GROUP BY 
    category, 
    EXTRACT(MONTH FROM sale_date)
ORDER BY 
    sale_month;

commit;
/*Project Completed*/
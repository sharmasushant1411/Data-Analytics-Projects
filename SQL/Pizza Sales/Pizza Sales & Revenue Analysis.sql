SELECT CONVERT(date, [date]) AS day, COUNT(*) AS order_count
FROM [dbo].[orders]
GROUP BY CONVERT(date, [date])
ORDER BY order_count DESC;

select 	*
from orders;

SELECT 	time, count(distinct order_id) as total_customers
from orders
group by time
order by total_customers desc;

select 	date, count(*)
from orders
group by date;

select  distinct(order_id), count(*)
from 	order_details
group by order_id;

select date, count(order_id)
from orders
group by date;

/* customers we have each day */

-- no. of orders per day
WITH no_of_orders_per_day AS 
(SELECT 	o.date, 
COUNT(o.order_id) AS orders_per_day
FROM 	orders o
GROUP BY o.date)

SELECT date, orders_per_day
FROM no_of_orders_per_day
ORDER BY orders_per_day DESC;

-- taking the avg of no. of orders per day to get the value on a daily basis 
WITH no_of_orders_per_day AS 
(
	SELECT 	o.date, 
			COUNT(o.order_id) AS orders_per_day
	FROM 	orders o
	GROUP BY o.date
)

SELECT ROUND(AVG(orders_per_day), 0) AS Average_orders 
FROM no_of_orders_per_day;

-- are there any peak hours?
SELECT DATEPART(HOUR, o.time) AS hour, COUNT(o.order_id) AS no_of_orders
FROM orders o
GROUP BY DATEPART(HOUR, o.time)
ORDER BY no_of_orders DESC;

/* how many pizzas are typically in an order ? */

-- no. of pizzas ordered per customer
-- Calculate the average quantity of pizzas per order
WITH cte AS 
(
    SELECT od.order_id, SUM(od.quantity) AS quantity_per_order
    FROM order_details od
    GROUP BY od.order_id
)

SELECT AVG(quantity_per_order) AS average_pizzas_per_order
FROM cte;

-- no.of customers ordered per quantity
WITH cte AS 
(
    SELECT od.order_id, SUM(od.quantity) AS quantity_per_order
    FROM order_details od
    GROUP BY od.order_id
)

SELECT quantity_per_order, COUNT(order_id) AS no_of_orders
FROM cte
GROUP BY quantity_per_order
ORDER BY COUNT(order_id) DESC;

/*  Do we have any bestsellers? */
SELECT TOP 5
    pt.name,
    p.size,
    SUM(od.quantity) AS Total_pizzas
FROM
    pizza_types pt
INNER JOIN
    pizzas p
    ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN
    order_details od
    ON p.pizza_id = od.pizza_id
GROUP BY
    pt.name,
    p.size
ORDER BY
    Total_pizzas DESC;

/* how much money did we make this year? */
SELECT CONCAT(CAST(ROUND(SUM(p.price * od.quantity) / 1000, 2) AS DECIMAL(10, 2)), 'k') AS Total_revenue
FROM pizzas p
INNER JOIN order_details od
ON p.pizza_id = od.pizza_id;

/* can we identify any seasonality in the sales? */
SELECT DATEPART(MONTH, o.date) AS months,
       ROUND(SUM(p.price * od.quantity), 2) AS Total_Revenue
FROM orders o
INNER JOIN order_details od
    ON o.order_id = od.order_id
INNER JOIN pizzas p
    ON od.pizza_id = p.pizza_id
GROUP BY DATEPART(MONTH, o.date)
ORDER BY DATEPART(MONTH, o.date);

-- Are there any pizzas we should take of the menu, or any promotions we could leverage?

/* Are there any pizzas we should take of the menu, it means we can check worst selling pizzas where total quantity ordered is low */
SELECT TOP 5 pt.name, p.size, SUM(od.quantity) AS Total_pizzas
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name, p.size
ORDER BY Total_pizzas DESC;

/* revenue analysis */

-- total revenue - '817860.05'
SELECT ROUND(SUM(p.price * od.quantity), 2) AS Total_revenue
FROM pizzas p
INNER JOIN order_details od
ON p.pizza_id = od.pizza_id;

-- avg revenue by quarter - '204465.01'
WITH quarterly_revenue AS (
    SELECT 
        (DATEPART(YEAR, o.date) * 4 + (DATEPART(QUARTER, o.date) - 1)) AS quarter,
        SUM(p.price * od.quantity) AS revenue
    FROM orders o
    INNER JOIN order_details od
    ON o.order_id = od.order_id
    INNER JOIN pizzas p
    ON od.pizza_id = p.pizza_id
    GROUP BY 
        (DATEPART(YEAR, o.date) * 4 + (DATEPART(QUARTER, o.date) - 1))
)

-- Calculate the average revenue per quarter
SELECT ROUND(AVG(revenue), 2) AS Avg_Revenue_per_Quarter
FROM quarterly_revenue;

-- avg revenue by month - '68155'
WITH monthly_revenue AS 
(
    SELECT 
        DATEPART(MONTH, o.date) AS months,
        ROUND(SUM(p.price * od.quantity), 2) AS revenue
    FROM orders o
    INNER JOIN order_details od
    ON o.order_id = od.order_id
    INNER JOIN pizzas p
    ON od.pizza_id = p.pizza_id
    GROUP BY DATEPART(MONTH, o.date)
)

SELECT ROUND(AVG(revenue), 2) AS Avg_monthly_revenue
FROM monthly_revenue;

-- monthly revenue
SELECT DATENAME(MONTH, o.date) AS months,
       ROUND(SUM(p.price * od.quantity), 2) AS revenue
FROM orders o
INNER JOIN order_details od
ON o.order_id = od.order_id
INNER JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY DATENAME(MONTH, o.date)
ORDER BY 1;

-- quarterly revenue
SELECT DATEPART(QUARTER, o.date) AS quarter,
       SUM(p.price * od.quantity) AS revenue
FROM orders o
INNER JOIN order_details od ON o.order_id = od.order_id
INNER JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY DATEPART(QUARTER, o.date)
ORDER BY quarter;

-- revenue on each day of the week 
SELECT DATENAME(WEEKDAY, o.date) AS dayname,
       SUM(p.price * od.quantity) AS revenue
FROM orders o
INNER JOIN order_details od
ON o.order_id = od.order_id
INNER JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY DATENAME(WEEKDAY, o.date)
ORDER BY dayname;

-- best selling pizzas by revenue
SELECT TOP 5 pt.name, p.size, ROUND(SUM(p.price * od.quantity), 2) AS revenue
FROM pizza_types pt
INNER JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name, p.size
ORDER BY revenue DESC;

-- worst selling pizza by revenue
SELECT TOP 5 pt.name, p.size, ROUND(SUM(p.price * od.quantity), 2) AS revenue
FROM pizza_types pt
INNER JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name, p.size
ORDER BY revenue;

-- average revenue per pizza sale
SELECT ROUND(AVG(p.price * od.quantity), 2) AS average_revenue
FROM pizzas p
INNER JOIN order_details od ON p.pizza_id = od.pizza_id;

-- revenue by pizza sizes 
WITH monthly_sales AS (
    SELECT 
        DATEPART(MONTH, o.date) AS monthnumber,
        DATENAME(MONTH, o.date) AS monthname,
        ROUND(SUM(p.price * od.quantity), 2) AS total_sales
    FROM orders o
    INNER JOIN order_details od
    ON o.order_id = od.order_id
    INNER JOIN pizzas p
    ON od.pizza_id = p.pizza_id
    GROUP BY DATEPART(MONTH, o.date), DATENAME(MONTH, o.date)
),
monthly_sales_diff AS (
    SELECT 
        monthnumber,
        monthname,
        total_sales,
        LAG(total_sales) OVER (ORDER BY monthnumber) AS prev_month_sales
    FROM monthly_sales
)
SELECT 
    monthnumber,
    monthname,
    total_sales,
    prev_month_sales,
    ROUND((total_sales - prev_month_sales) / prev_month_sales * 100, 2) AS sales_growth_percent
FROM monthly_sales_diff;

-- revenue by category
SELECT category, ROUND(SUM(price * quantity), 2) AS revenue
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY category;

/* sales analysis */

-- TOTAL orders placed 
SELECT 		sum(quantity)AS Total_orders_placed
FROM 		order_details;

-- Total quantities ordered
SELECT 		count(order_id) AS Total_Quantities_ordered
FROM 		orders;

-- no. of orders per day
WITH no_of_orders_per_day AS
(
	SELECT 		o.date,
				COUNT(o.order_id) AS orders_per_day
	FROM 		orders o
	GROUP BY 	o.date
)
-- taking the avg of no. of orders per day to get the value on a daily basis 
SELECT  ROUND(AVG(orders_per_day), 2) AS Average_orders
FROM 	no_of_orders_per_day;

-- Peak hours
SELECT DATEPART(HOUR, o.time) AS hour,
       COUNT(o.order_id) AS no_of_orders
FROM orders o
GROUP BY DATEPART(HOUR, o.time)
ORDER BY hour;

-- Orders placed each day of the week
SELECT DATENAME(WEEKDAY, date) AS day,
       COUNT(order_id) AS No_of_orders
FROM orders
GROUP BY DATENAME(WEEKDAY, date)
ORDER BY day;

-- Pizza orders by size
SELECT size,
       SUM(quantity) AS pizza_order_by_size
FROM pizzas p
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY size;

-- Pizza orders by category
SELECT pt.category,
       SUM(od.quantity) AS pizza_order_by_category
FROM pizza_types pt
JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category;

-- Best selling pizza
SELECT TOP 5 pt.name AS Name,
              p.size AS Size,
              SUM(od.quantity) AS Total_pizzas
FROM pizza_types pt
INNER JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name, p.size
ORDER BY Total_pizzas DESC;

-- Worst selling pizza 
SELECT TOP 5 pt.name AS Name,
              p.size AS Size,
              SUM(od.quantity) AS Total_pizzas
FROM pizza_types pt
INNER JOIN pizzas p ON pt.pizza_type_id = p.pizza_type_id
INNER JOIN order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name, p.size
ORDER BY Total_pizzas ASC;

-- Seasonal sales
SELECT 
	CASE 
		WHEN MONTH(date) BETWEEN 3 AND 5 THEN 'spring'
        WHEN MONTH(date) BETWEEN 6 AND 8 THEN 'summer'
        WHEN MONTH(date) BETWEEN 9 AND 11 THEN 'autumn'
        ELSE 'winter'
	END AS seasons,
    SUM(quantity) AS Total_sales,
    SUM(price * quantity) AS total_revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY 
	CASE 
		WHEN MONTH(date) BETWEEN 3 AND 5 THEN 'spring'
        WHEN MONTH(date) BETWEEN 6 AND 8 THEN 'summer'
        WHEN MONTH(date) BETWEEN 9 AND 11 THEN 'autumn'
        ELSE 'winter'
	END;
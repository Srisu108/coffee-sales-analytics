/*
=========================================================
Coffee Sales & Profitability Analytics
Business Analysis
=========================================================

Purpose:
Answer key business questions using SQL Server.

Database:
KaggleAnalytics

Tables:
- dbo.customers
- dbo.products
- dbo.orders

Important modelling note:
dbo.orders is stored at order-line grain.
Therefore, DISTINCT order_id must be used when
calculating the number of orders.



/* =====================================================
   Q1. Overall Business Performance
   ===================================================== */

*/
----1. What is driving coffess sales and profitability, and where are the opportunities or patterns in the business?

----Analysis 1 Overall business performance?
select * from products
select * from orders;
select * from customers;
select
	cast(sum(sales) as decimal(10,2)) as total_sales,
	cast(sum(total_profit) as decimal(10,2))  as Total_profit,
	sum(Quantity) as Units_sold
from orders;

----------analysis -2 sales and profit by coffe type
select distinct coffee_type,
	sum(sales) as total_sales,
	sum(total_profit) AS total_profit,
	sum(Quantity) As unit_sold
from orders
Group by coffee_type
order by total_sales DESC;

----Analysis 3 - Sales and profit by country
select country,
	sum(sales) as total_sales,
	sum(total_profit) AS total_profit,
	sum(Quantity) As unit_sold
from orders
Group by country
order by total_sales desc;

/* =====================================================
   Q2. Product Performance
   ===================================================== */
---------   Business Question 2 — What products are driving the business?----


		----- "Which coffee products contribute the most sales and profit?

		select
			p.product_id,
			p.coffee_type,
			p.roast_type,
			p.size,
			cast(sum(o.sales) as decimal(10,2)) as total_sales,
			sum(o.total_profit) AS total_profit,
			sum(o.Quantity) As unit_sold
		from orders o
		JOIN products p
			on p.product_id = o.product_id
		Group by 
			p.product_id,
			p.coffee_type,
			p.roast_type,
			p.size
		Order by total_sales Desc;

        

		--------   Business Question 3 — Which countries generate the most business? -------

		select
			c.country,
			count(Distinct o.order_id) AS no_of_orders,
			sum(o.Quantity) As unit_sold,
			cast(sum(o.sales) as decimal(10,2)) as total_sales,
			sum(o.total_profit) AS total_profit
		from customers c
		Join orders o
			On c.customer_id = o.customer_id
		Group by c.country
		order by total_sales Desc;
	
	
SELECT
    SUM(sales) AS total_sales,
    SUM(total_profit) AS total_profit,
    SUM(quantity) AS units_sold
FROM orders;

SELECT
    SUM(sales) AS total_sales,
    SUM(total_profit) AS total_profit,
    SUM(total_profit) / SUM(sales) * 100 AS profit_margin_pct,
    SUM(quantity) AS units_sold
FROM dbo.orders;



-------------------        Business Question 4: How do sales and profit change over time?   =-------
-----====   Yearly====
select
	year(order_date) As year,
	----Month(order_date) as month,
	sum(sales) as total_sales,
	sum(total_profit) as total_profit,
	sum(quantity) as units_sold
from orders
group by
	year(order_date)
order by total_sales desc;

---=====  Monthly ========----

select
	year(order_date) As year,
	Month(order_date) as month,
	sum(sales) as total_sales,
	sum(total_profit) as total_profit,
	sum(quantity) as units_sold
from orders
group by
	year(order_date),
	Month(order_date)
order by
	year,
	month;

--------   

select
	year(order_date) As year,
	sum(sales) as total_sales,
	sum(total_profit) as total_profit,
	sum(total_profit)/NULLIF(sum(sales),0)* 100 As gross_profit_pct

from orders
group by
	year(order_date)
ORDER BY
	YEAR;
---------------   Q5 — Which coffee types / categories drive the business? ------------------

select
	p.coffee_type,
	sum(o.quantity) AS units_sold,
	sum(o.sales) as total_sales,
	sum(o.total_profit) as total_profit,
	sum(o.total_profit)/nullif(sum(o.sales),0) * 100 AS profit_margin_pct
from products p
Join orders o
	on p.product_id = o.product_id
Group by
	p.coffee_type
order by total_sales Desc;

------------------Q6 Q6 — Does Roast Type affect performance?---
---- Which roast type generates the most volume, sales and profit, and are some roast types more profitable than others?
select* from products;
----- Roast TYPE ------
select
	p.roast_type,
	sum(o.quantity) AS units_sold,
	sum(o.sales) as total_sales,
	sum(o.total_profit) as total_profit,
	sum(o.total_profit)/nullif(sum(o.sales),0) * 100 AS profit_margin_pct
from products p
Join orders o
	on p.product_id = o.product_id
Group by
	p.roast_type
order by total_sales Desc;

----Q7-Size Type -------Which package size generates the most sales and profit, and does package size affect profitability?

select
	p.size,
	sum(o.quantity) AS units_sold,
	sum(o.sales) as total_sales,
	sum(o.total_profit) as total_profit,
	sum(o.total_profit)/nullif(sum(o.sales),0) * 100 AS profit_margin_pct
from products p
Join orders o
	on p.product_id = o.product_id
Group by
	p.size
order by total_sales Desc;


--------------------------------Q8  Customer & Loyalty Performance ---------------
------Do customers with a loyalty card generate different sales, order volume and profitability compared with non-loyalty customers?
select * from customers;
select * from orders;
select * from products

select
	c.loyalty_card,
	count(Distinct o.order_id) as no_of_orders,
	count(Distinct o.customer_id) as no_of_customers,
	sum(o.quantity) AS units_sold,
	sum(o.sales) as total_sales,
	sum(o.total_profit) as total_profit,
	sum(o.total_profit)/nullif(sum(o.sales),0) * 100 AS profit_margin_pct
from customers c
Join orders o
	on c.customer_id = o.customer_id
Group by
	c.loyalty_card
order by total_sales Desc;

/* One more useful KPI

Since we have both orders and customers, let's calculate:

Average Orders per Customer */

select
	c.loyalty_card,
	count(Distinct o.order_id) as no_of_orders,
	count(Distinct o.customer_id) as no_of_customers,
	cast(count(Distinct o.order_id) /nullif(count(Distinct o.customer_id),0) AS decimal(10,2))  As Avg_order_by_customer,
	sum(o.sales) as total_sales,
	sum(o.total_profit) as total_profit,
	sum(o.total_profit)/nullif(sum(o.sales),0) * 100 AS profit_margin_pct
from customers c
Join orders o
	on c.customer_id = o.customer_id
Group by
	c.loyalty_card
order by total_sales Desc;


----- AOV — Average Order Value----

/* Business question

How much sales revenue does the business generate per order on average? */

SELECT
    SUM(sales) AS total_sales,
    COUNT(DISTINCT order_id) AS number_of_orders,
    SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0) AS average_order_value
FROM dbo.orders;

-------Q Do loyalty and non-loyalty orders have different average basket values?

SELECT
    c.loyalty_card,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    SUM(o.sales) AS total_sales,
    CAST(
        SUM(o.sales) /
        NULLIF(COUNT(DISTINCT o.order_id), 0)
        AS DECIMAL(10,2)
    ) AS aov
FROM dbo.customers c
JOIN dbo.orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.loyalty_card
ORDER BY
    aov DESC;



/* =====================================================
   KPI Reference
   =====================================================

   Total Sales       = 45,134.26
   Total Profit      = 4,520.22
   Units Sold        = 3,551
   Orders            = 957
   AOV               = approximately 47.16
   Profit Margin     = approximately 10.01%

   These values were reconciled against the Power BI
   semantic model and dashboard.
*/
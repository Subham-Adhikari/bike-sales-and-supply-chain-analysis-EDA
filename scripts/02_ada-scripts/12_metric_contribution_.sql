-- find top 10% customers contributes how many % of revenue?
-- ANS: ~40.28% REVENUE

WITH total_cust_revenue AS
  (
  	SELECT
  		customer_key,
  		SUM(sales_amount) customer_revenue
  	FROM gold.fact_sales F
  	WHERE order_date IS NOT NULL
  	GROUP BY customer_key
  
  ),
top_ten_percCustomers AS
  (
  	SELECT
  		customer_key,
  		customer_revenue,-- INDIVIDUAL CUSTOMER REVENUE
  		SUM(customer_revenue) OVER() total_revenue, -- TOTAL REVENUE
  		PERCENT_RANK() OVER(ORDER BY customer_revenue DESC) top_tenCust_percentrank
  	FROM total_cust_revenue
  )



SELECT
	ROUND(
		CAST(SUM(customer_revenue) AS float) / MAX(total_revenue) * 100
		, 2) AS top_10_percent_revenue_contribution
FROM top_ten_percCustomers
WHERE top_tenCust_percentrank <= 0.1;
GO





--Which product category had highest revenue = ?, CALCULATE THIS WHERE ORDER DATE IS PRESENT.
--  bike, almost 96.46% of total revenue

SELECT *,
	SUM(sales_amount) OVER() golbal_revenue,
	ROUND(
		CAST(sales_amount AS float) / SUM(sales_amount) OVER() * 100
		, 2) percContribution_ofCategories
FROM
(
	SELECT
		P.category,
		SUM(F.sales_amount) sales_amount
	FROM gold.fact_sales F
	INNER JOIN gold.dim_products P
	ON F.product_key = P.product_key
	WHERE F.order_date IS NOT NULL
	GROUP BY P.category
)T
ORDER BY sales_amount DESC;
GO



-- Average shipping time in days = ?
--ANS: 7 DAYS
SELECT 
	AVG(dayDifference)
FROM
(
	SELECT
		order_date,
		shipping_date,
		DATEDIFF(DAY, order_date, shipping_date) dayDifference
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL OR shipping_date IS NOT NULL
)T;
GO



/* 
	% of orders shipped on/before due_date = ?, exclude orderdate, shippingdate and due date with
	no values.



	% on-time = (On-time orders / Valid orders) × 100 --VALID ORDER MEANS ORDER WHICH IS
														DELIVERED, WHETHER LATE OR ON-TIME
	          = (2 / 3) × 100 
			  = 66.67%

*/
-- ANS: 100
SELECT
	CAST(onTime_orders AS float) / all_orders * 100
FROM
(
	SELECT
		COUNT(DISTINCT order_number) AS onTime_orders,
		(SELECT 
			COUNT(DISTINCT order_number) 
		 FROM gold.fact_sales 
		 WHERE order_date IS NOT NULL AND 
		       shipping_date IS NOT NULL AND 
			   due_date IS NOT NULL) AS all_orders
	FROM gold.fact_sales
	WHERE (order_date IS NOT NULL AND shipping_date IS NOT NULL AND due_date IS NOT NULL)
		  AND
		  shipping_date <= due_date -- ON TIME ORDERS
)T;
GO



/*

What are our top 10 customers by revenue, and what percentage of total revenue do 
they represent? (Customer concentration risk)
-> ANS: ~0.45%
*/

WITH topTen_customers AS 
(
	SELECT TOP (10) WITH TIES
		customer_key,
		SUM(sales_amount) sales_amount,
		SUM(SUM(sales_amount)) OVER() global_sales_amount
	FROM gold.fact_sales
	GROUP BY customer_key
	ORDER BY sales_amount DESC
)

SELECT
	ROUND(CAST(SUM(sales_amount) AS float) / MAX(global_sales_amount) * 100, 2)
FROM topTen_customers;
GO


/*
Which product categories generate the most profit margin? (Cost vs Sales analysis)
***PROFIT = REVENUE - COST
***IF PROFIT MARGIN: ((Revenue − Cost) / Revenue) × 100
***GROSS PROFIT = REVENUE - COGS
***IF GROSS PROFIT MARGIN: (Revenue − Cost of Goods Sold) / Revenue × 100
remember,
	when i am talking about profit or profit %, then always divided it with cost price.
	and 
	when i am talking about profit margin %, then always divided it with revenue.

-> ANS: ACCESSORIES, PROFIT MARGIN % [~62.78%]
*/

SELECT TOP (1)
	P.category,
	SUM(P.cost) cost,
	SUM(F.sales_amount) sales_amount,
	SUM(F.sales_amount) - SUM(P.cost) profit,
	ROUND(
		CAST((SUM(F.sales_amount) - SUM(P.cost)) AS float) / SUM(F.sales_amount) * 100
		, 2) profitMargin_perc
FROM gold.fact_sales F
INNER JOIN gold.dim_products P
ON F.product_key = P.product_key
GROUP BY P.category
ORDER BY profitMargin_perc DESC;
GO



/*
What's our month-over-month revenue growth rate? (Business growth tracking)
for each month of each year.
-> ANS: AVERAGE REVENUE GROWTH RATE IS ~29%
*/

WITH initial_table AS
(
	SELECT
		YEAR(order_date) order_year,
		MONTH(order_date) order_month,
		FORMAT(order_date, 'MMM-yy') order_monthYear,
		SUM(sales_amount) current_sales_amount,
		LAG(SUM(sales_amount)) 
			OVER(ORDER BY YEAR(order_date) ASC, MONTH(order_date) ASC) 
				AS previous_sales_amount
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY 
		YEAR(order_date),
		MONTH(order_date) ,
		FORMAT(order_date, 'MMM-yy')
),
mom_RevenueGrowthRate AS
(
	SELECT
		order_year, order_month, order_monthYear, 
		current_sales_amount, previous_sales_amount,
		ROUND(CAST(
			(current_sales_amount - previous_sales_amount) AS float) / previous_sales_amount
			 * 100, 2) percChange_vs_PM,
		CASE
			WHEN
				ROUND(CAST(
			(current_sales_amount - previous_sales_amount) AS float) / previous_sales_amount
			 * 100, 2) > 0
			 THEN 'increase'
			 WHEN
				ROUND(CAST(
			(current_sales_amount - previous_sales_amount) AS float) / previous_sales_amount
			 * 100, 2) < 0
			 THEN 'decrease'
			 ELSE 'no-change'
		END vs_PreviousMonth
	FROM initial_table
)

SELECT
	ROUND(AVG(percChange_vs_PM), 0) avgRevenueGrowthRate_mom
FROM mom_RevenueGrowthRate
WHERE previous_sales_amount IS NOT NULL;
GO


/*

Which products are underperforming (low sales despite high inventory cost)? 
(Inventory optimization)

*/

SELECT
	P.product_key,
	P.cost, --DONT SUM IT, IT WILL CREATE AMBIGUITY RESULLT, THIS COST IS UNIQUER PER PRODUCT
	COALESCE(SUM(F.sales_amount), 0) sales_amount
FROM gold.dim_products P
LEFT JOIN gold.fact_sales F
ON P.product_key = F.product_key
GROUP BY P.product_key, P.cost
ORDER BY sales_amount ASC, cost DESC;
GO


-- SKU = Stock Keeping Unit = Unique product identifier

-- EXAMPLES:
-- T-shirt Red M    → SKU001
-- T-shirt Red L    → SKU002  (different size = different SKU)
-- T-shirt Blue M   → SKU003  (different color = different SKU)

-- KEY POINTS:
-- ✅ Each SKU = Own inventory + sales data
-- ✅ "Underperforming Products" ≈ "Underperforming SKUs" (same analysis)

-- WHY IT MATTERS:
-- Track inventory at most granular level
-- Identify specific variants that don't sell
-- Make targeted decisions (discount, stop ordering, etc.)


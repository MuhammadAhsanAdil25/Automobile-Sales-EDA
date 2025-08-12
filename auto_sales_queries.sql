--Looking at the data we have to work with
SELECT *
FROM automobile..auto_sales_details;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Sales per month
SELECT year(ORDERDATE) AS year
	,month(ORDERDATE) AS month
	,round(sum(SALES), 0) AS total_sales_per_month
FROM automobile..auto_sales_details
WHERE STATUS LIKE '%shipped%'
GROUP BY year(ORDERDATE)
	,month(ORDERDATE)
ORDER BY 1
	,2;


--Sales per city
SELECT COUNTRY
	,CITY
	,round(sum(SALES), 0) AS total_sales_per_city
FROM automobile..auto_sales_details
WHERE STATUS LIKE '%shipped%'
GROUP BY COUNTRY
	,CITY
ORDER BY 3 DESC;


--Sales per country
SELECT COUNTRY
	,round(sum(SALES), 0) AS total_sales_per_country
FROM automobile..auto_sales_details
WHERE STATUS LIKE '%shipped%'
GROUP BY COUNTRY
ORDER BY 2 DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Most frequent customer
SELECT CUSTOMERNAME
	,count(ORDERNUMBER) AS no_of_orders
	,round(sum(SALES), 0) AS sales
FROM automobile..auto_sales_details
WHERE STATUS LIKE '%shipped%'
GROUP BY CUSTOMERNAME
ORDER BY 2 DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Most in-demand products
WITH product_cte
AS (
	SELECT PRODUCTLINE
		,PRODUCTCODE
		,sum(QUANTITYORDERED) OVER (PARTITION BY PRODUCTCODE) AS total_units_sold
		,sum(SALES) OVER (PARTITION BY PRODUCTCODE) AS sales
		,ROW_NUMBER() OVER (
			PARTITION BY PRODUCTCODE ORDER BY PRODUCTCODE
			) AS ranking
	FROM automobile..auto_sales_details
	WHERE STATUS LIKE '%shipped%'
	)
SELECT PRODUCTLINE
	,PRODUCTCODE
	,total_units_sold
	,round(sales, 0) AS total_sales
FROM product_cte
WHERE ranking < 2
ORDER BY 4 DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Average price and sales per deal size
SELECT DEALSIZE
	,round(avg(PRICEEACH), 0) AS avg_price
	,round(sum(SALES), 0) AS total_sales
FROM automobile..auto_sales_details
WHERE STATUS LIKE '%shipped%'
GROUP BY DEALSIZE
ORDER BY 3 DESC;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Efficiency in terms of completing orders
SELECT STATUS
	,count(*) AS total
	,(count(*) * 100) / (
		SELECT count(*)
		FROM automobile..auto_sales_details
		) AS percentage_efficiency
FROM automobile..auto_sales_details
GROUP BY STATUS;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Sales lost due to incomplete order 
SELECT STATUS
	,count(*) AS no_of_orders
	,round(sum(SALES), 0) AS total_sales_lost
FROM automobile..auto_sales_details
WHERE STATUS IN (
		'Cancelled'
		,'Disputed'
		)
GROUP BY STATUS;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Analyzing product line profitability
SELECT PRODUCTLINE
	,round(AVG(PRICEEACH), 0) AS avg_selling_price
	,AVG(MSRP) AS avg_msrp
	,round(((AVG(PRICEEACH) - AVG(MSRP)) / AVG(MSRP) * 100), 0) AS PriceVsMsrp_percentage
FROM automobile..auto_sales_details
GROUP BY PRODUCTLINE
ORDER BY 1;


-- Analyzing specific product profitability
WITH product_profit
AS (
	SELECT DISTINCT PRODUCTLINE
		,PRODUCTCODE
		,avg(PRICEEACH) OVER (PARTITION BY PRODUCTCODE) AS avg_selling_price
		,avg(MSRP) OVER (PARTITION BY PRODUCTCODE) AS avg_msrp
	FROM automobile..auto_sales_details
		--ORDER BY 1,2
	)
SELECT PRODUCTLINE
	,PRODUCTCODE
	,round(avg_selling_price, 0) AS avg_selling_price
	,avg_msrp
	,round(((avg_selling_price - avg_msrp) / (avg_msrp) * 100), 0) AS PriceVsMsrp_percentage
FROM product_profit;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
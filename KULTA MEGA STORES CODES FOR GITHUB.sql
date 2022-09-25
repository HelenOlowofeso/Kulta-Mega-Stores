SELECT * FROM KMSExcel

--1; Which product category had the highest sales?--

SELECT product_category, SUM (Sales)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 DESC

--2; What are the Top 3 and Bottom 3 Regions with regards to sales?--

SELECT *
FROM (SELECT region, SUM (sales)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3 ) tmp
UNION ALL
SELECT * 
FROM (SELECT region, SUM (sales)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 ASC
LIMIT 3) tmp1

		--OR Do them separately with the codes below--

SELECT region, SUM (sales)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3

SELECT region, SUM (sales)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 ASC
LIMIT 3

--3; What was the total sales of appliances in Ontario?-- (bear in mind Ontario exist in both region and province rows)--
SELECT Province, product_sub_category, SUM(sales) AS total_sales
FROM KMSExcel
WHERE product_sub_category ='Appliances'
AND Province = 'Ontario'
Group by 1,2

SELECT SUM(sales) AS Total_Sales, product_sub_category, region
FROM KMSExcel
WHERE product_sub_category ='Appliances'
AND region = 'Ontario'
Group by 2,3

/*4; Advise the management of KMS on what to to do to increase the revenue 
from the bottom 10 customers*/

SELECT DISTINCT Customer_name, SUM (profit)
FROM KMSExcel
GROUP BY 1 
ORDER by 2 ASC
LIMIT 10
/*TO ANSWER THE QUESTION: From the data, the bottom 10 customers spend money mostly on Office supplies. It is possible they buy other categories from another supplier(s) and/or the fact that the , KMS can organise a Promotion or give bottom customers some discount/offers, incentivising them they buy other categories from them KMS. KMS can also give these customers a discount on the categor(y/ies) they buy, for examples if they spend $150 they get a percentage discount. this will also help reduce the spend amount and could mean more volume.
KMS can also push for an eco-friendly recycling model, where customers  are encouraged to exchange old/expired/damaged technolgy/supplies/furniture for new ones at a packaged discount in addition to bundle sales. Where buying one product category can enable customers get juicy discount/perks"*/

--5; KMS incurred the most shipping cost using which shipping method?--
SELECT ship_mode, SUM (shipping_cost)
FROM KMSExcel
GROUP BY 1 
ORDER by 2 DESC
LIMIT 1

--6; Who are the most valuable customers?--
SELECT DISTINCT customer_name, SUM(profit)
FROM KMSExcel
GROUP BY 1
ORDER BY 2 DESC


/*7; If the delivery truck is the most economical but the slowest shipping method 
and Express Air is the fastest but the most expensive one, do you think the company 
appropriately spent shipping costs based on the Order Priority? Explain your answer
*/

SELECT DISTINCT order_priority, ship_mode, SUM(shipping_cost)
FROM KMSExcel
GROUP BY 1,2
ORDER BY 1,3 DESC

/*TO ANSWER THE QUESTION:No I don’t, an analysis of the shipping costs shows that there as no reason to ship so many low and medium priority orders via express air. Furthermore, when we examine the logistics of delivery in terms of product container types/sizing. 
Low and medium priority items which are not jumbo sizes could have been sent via regular air mail rather than express air and would have resulted in some savings on shipping costs. Inversely for better customer experience, critical orders should have been shipped using the fastest mode of transport (express air) rather than regular air.*/

--8; Which small business customer had the highest sales?--
SELECT customer_name, SUM(sales)
FROM KMSExcel
WHERE customer_segment = 'Small Business'
GROUP BY 1
OrDER BY 2 DESC 

SELECT customer_name, customer_segment, SUM(sales)
FROM KMSExcel
WHERE customer_segment = 'Small Business'
GROUP BY 1,2
OrDER BY 3 DESC

/*9; Which Corporate Customer placed the most number of orders in 2009 – 2012?
How many orders were placed by the Corporate customer?*/
SELECT customer_name, SUM(order_quantity)
FROM KMSExcel
WHERE customer_segment= 'Corporate'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--10; Which consumer customer was the most profitable one?--
SELECT Customer_name, SUM(profit) AS Profits
FROM KMSExcel
WHERE customer_segment= 'Consumer'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
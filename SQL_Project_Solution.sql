select * from walmartsales_dataset;
-- q1
SELECT Branch, MONTH(date) AS month_num, gross_margin_percentage,
    LAG(gross_margin_percentage) OVER (PARTITION BY Branch ORDER BY date) AS previous_margin,
    ((gross_margin_percentage - LAG(gross_margin_percentage) OVER (PARTITION BY Branch ORDER BY date))) * 100 AS growth_rate
FROM walmartsales_dataset
ORDER BY Branch, date;

-- q2
select Product_line,round(sum(cogs-gross_income),2) AS Profit from walmartsales_dataset
group by Product_line
order by Profit desc;

-- q3
select Customer_ID,round(sum(Total),2) AS Total_Spend, 
case 
	when round(sum(Total),2) <= 19700 then 'Low'
    when round(sum(Total),2) between 19701 and 22700 then 'Medium'
    else 'High'
end AS Category
from walmartsales_dataset
group by Customer_ID;

-- q4
WITH ProductLineStats AS (
SELECT Product_line,AVG(Total) AS avg_total FROM walmartsales_dataset
GROUP BY Product_line
)
SELECT w.Product_line,w.Total AS transaction_value,pl.avg_total,
CASE
	WHEN w.Total > pl.avg_total * 1.5 THEN 'High'
	WHEN w.Total < pl.avg_total * 0.5 THEN 'Low'
	ELSE 'Normal'
END AS Category
FROM walmartsales_dataset w
JOIN ProductLineStats pl
ON w.Product_line = pl.Product_line
ORDER BY w.Product_line, w.Total;

-- q5
select city,Payment,count(*) AS Count from walmartsales_dataset
group by City,Payment
order by Count desc,city;

-- q6
select Gender,month(date) as month,count(*) AS count from walmartsales_dataset
group by Gender,month(date)
order by month;

-- q7
select Product_line,Customer_type,count(*) AS Total_Purchase from walmartsales_dataset
group by Customer_type,Product_line
order by Product_line;

-- q8
SELECT customer_id,date,next_purchase_date
FROM (
SELECT customer_id,date,
LEAD(date) OVER (PARTITION BY customer_id ORDER BY date) AS next_purchase_date
FROM walmartsales_dataset) AS abc
WHERE DATEDIFF(next_purchase_date, date) <= 30;

-- q9
SELECT Customer_ID, ROUND(SUM(Total), 2) AS Total_Purchase FROM walmartsales_dataset
GROUP BY Customer_ID
ORDER BY total_purchase DESC
LIMIT 5;

-- q10
select dayofweek(date) AS Day_Of_Week,dayname(date) AS Day_Name,round(sum(Total),2) AS Total_Sale from walmartsales_dataset
group by Day_Of_Week,day_name
order by total_sale desc;select * from car  limit 2;
select * from car  limit 2;

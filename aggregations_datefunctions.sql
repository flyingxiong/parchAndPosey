# 26 DATE functions
SELECT WEEKDAY(occurred_at) as day_of_week,
       SUM(total) AS total_qty,
        EXTRACT(YEAR FROM occurred_at)
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

# 27 QUIZ: DATE functions
# Find the sales in terms of total dollars for all orders in each year, ordered from greatest to least. Do you notice any trends in the yearly sales totals?
SELECT EXTRACT(YEAR FROM occurred_at) as year, SUM(orders.total_amt_usd) as total_sales
    FROM orders
GROUP BY EXTRACT(YEAR FROM occurred_at)
ORDER BY total_sales DESC;

SELECT EXTRACT(YEAR FROM occurred_at) ord_year,  SUM(total_amt_usd) total_spent
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

# Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
SELECT EXTRACT(MONTH FROM occurred_at) as month, SUM(orders.total_amt_usd) as total_sales
    FROM orders
GROUP BY month
ORDER BY total_sales DESC;

SELECT EXTRACT(MONTH FROM occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

# Which year did Parch & Posey have the greatest sales in terms of total number of orders? Are all years evenly represented by the dataset?
SELECT EXTRACT(YEAR FROM occurred_at) as year, COUNT(*) total_sales
    FROM orders
GROUP BY year
ORDER BY 2 DESC;

SELECT EXTRACT(YEAR FROM occurred_at) ord_year,  COUNT(*) total_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

# Which month did Parch & Posey have the greatest sales in terms of total number of orders? Are all months evenly represented by the dataset?
SELECT EXTRACT(MONTH FROM occurred_at) as month, COUNT(*) as total_quantity
    FROM orders
GROUP BY month
ORDER BY total_quantity DESC;

SELECT EXTRACT(MONTH FROM occurred_at) ord_month, COUNT(*) total_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

# In which month of which year did Walmart spend the most on gloss paper in terms of dollars?
SELECT EXTRACT(MONTH FROM orders.occurred_at) as month, SUM(orders.gloss_amt_usd) AS gloss_usd
    FROM orders
JOIN accounts a on a.id = orders.account_id
WHERE a.name = 'Walmart'
GROUP BY month
ORDER BY gloss_usd DESC ;

SELECT EXTRACT(MONTH FROM o.occurred_at) ord_date, SUM(o.gloss_amt_usd) tot_spent
FROM orders o
JOIN accounts a
ON a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;


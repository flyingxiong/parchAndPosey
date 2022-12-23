# 11 Quiz: MIN, MAX, AVG
# 1.When was the earliest order ever placed? You only need to return the date.
SELECT MIN(orders.occurred_at)
    FROM orders;

# 2. Try performing the same query as in question 1 without using an aggregation function.
SELECT orders.occurred_at
    FROM orders
ORDER BY occurred_at
LIMIT 1;

# 3. When did the most recent (latest) web_event occur?
SELECT MAX(orders.occurred_at)
    FROM orders;

# 4. Try to perform the result of the previous query without using an aggregation function.
SELECT orders.occurred_at
    FROM orders
ORDER BY occurred_at DESC
LIMIT 1;

# 5. Find the mean (AVERAGE) amount spent per order on each paper type, as well as the mean amount of each paper type purchased per order. Your final answer should have 6 values - one for each paper type for the average number of sales, as well as the average amount.
SELECT AVG(gloss_amt_usd), AVG(gloss_qty),
       AVG(poster_amt_usd), AVG(poster_qty),
       AVG(standard_amt_usd), AVG(standard_amt_usd)
    FROM orders;

# 6. Via the video, you might be interested in how to calculate the MEDIAN. Though this is more advanced than what we have covered so far try finding - what is the MEDIAN total_usd spent on all orders?
SELECT *
FROM (SELECT total_amt_usd
         FROM orders
         ORDER BY total_amt_usd
         LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

# 14 Quiz: GROUP BY
# Which account (by name) placed the earliest order? Your solution should have the account name and the date of the order.
SELECT MIN(o.occurred_at) order_date, a.name account_name
    FROM orders o
JOIN accounts a on a.id = o.account_id;

SELECT a.name, o.occurred_at
FROM accounts a
JOIN orders o
ON a.id = o.account_id
ORDER BY occurred_at
LIMIT 1;

# Find the total sales in usd for each account. You should include two columns - the total sales for each company's orders in usd and the company name.
SELECT SUM(o.total_amt_usd) total_sales, a.name company_name
    FROM orders o
JOIN accounts a on a.id = o.account_id
GROUP BY a.name;

SELECT a.name, SUM(total_amt_usd) total_sales
FROM orders o
JOIN accounts a
ON a.id = o.account_id
GROUP BY a.name;

# Via what channel did the most recent (latest) web_event occur, which account was associated with this web_event? Your query should return only three values - the date, channel, and account name.
SELECT MAX(we.occurred_at) date, we.channel channel, a.name account_name
    FROM web_events we
JOIN accounts a on a.id = we.account_id;

SELECT w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
ORDER BY w.occurred_at DESC
LIMIT 1;

# Find the total number of times each type of channel from the web_events was used. Your final table should have two columns - the channel and the number of times the channel was used.
SELECT COUNT(web_events.occurred_at) totol_occurence, web_events.channel
    FROM web_events
GROUP BY channel;

SELECT w.channel, COUNT(*)
FROM web_events w
GROUP BY w.channel;

# Who was the primary contact associated with the earliest web_event?
SELECT MIN(we.occurred_at) earliest, sr.name contact
    FROM web_events we
JOIN accounts a on a.id = we.account_id
JOIN sales_reps sr on sr.id = a.sales_rep_id;

SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

# What was the smallest order placed by each account in terms of total usd. Provide only two columns - the account name and the total usd. Order from smallest dollar amounts to largest.
SELECT a.name account_name, MIN(o.total_amt_usd) total_usd
    FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.name
ORDER BY total_usd;

SELECT a.name, MIN(total_amt_usd) smallest_order
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY smallest_order;

# Find the number of sales reps in each region. Your final table should have two columns - the region and the number of sales_reps. Order from fewest reps to most reps.
SELECT r.name region, COUNT(sr.id) sales_reps
    FROM sales_reps sr
JOIN region r on r.id = sr.region_id
GROUP BY r.id
ORDER BY sales_reps;

SELECT r.name, COUNT(*) num_reps
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY num_reps;

# 16 group by part 2
SELECT account_id,
       channel,
       COUNT(id) AS events
FROM web_events
GROUP BY account_id, channel
ORDER BY channel, account_id DESC;

# 17 group by part 2
# For each account, determine the average amount of each type of paper they purchased across their orders. Your result should have four columns - one for the account name and one for the average quantity purchased for each of the paper types for each account.
SELECT a.name account_name, AVG(o.gloss_qty), AVG(o.standard_qty), AVG(o.poster_qty)
    FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.name;

# For each account, determine the average amount spent per order on each paper type. Your result should have four columns - one for the account name and one for the average amount spent on each paper type.
SELECT a.name account_name, AVG(O.gloss_amt_usd), AVG(O.standard_amt_usd), AVG(O.poster_amt_usd)
    FROM orders o
JOIN accounts a on o.account_id = a.id
GROUP BY a.name;

# Determine the number of times a particular channel was used in the web_events table for each sales rep. Your final table should have three columns - the name of the sales rep, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT sr.name, e.channel, COUNT(e.occurred_at) AS occurances
    FROM web_events e
JOIN accounts a on a.id = e.account_id
JOIN sales_reps sr on sr.id = a.sales_rep_id
GROUP BY E.channel, SR.name
ORDER BY occurances DESC;

# Determine the number of times a particular channel was used in the web_events table for each region. Your final table should have three columns - the region name, the channel, and the number of occurrences. Order your table with the highest number of occurrences first.
SELECT r.name, e.channel, COUNT(e.occurred_at) AS occurances
    FROM web_events e
JOIN accounts a on a.id = e.account_id
JOIN sales_reps sr on a.sales_rep_id = sr.id
JOIN region r on r.id = sr.region_id
GROUP BY r.name, e.channel
ORDER BY occurances DESC ;

SELECT r.name, w.channel, COUNT(*) num_events
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
JOIN sales_reps s
ON s.id = a.sales_rep_id
JOIN region r
ON r.id = s.region_id
GROUP BY r.name, w.channel
ORDER BY num_events DESC;

# DISTINCT
SELECT web_events.account_id,
       web_events.channel,
       COUNT(web_events.id) as events
    FROM web_events
GROUP BY web_events.account_id, web_events.channel
ORDER BY web_events.account_id, events;

# is the same as above, except the events column
SELECT DISTINCT web_events.account_id,
                channel
    FROM web_events
ORDER BY web_events.account_id;

# 20 distict quiz
# Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT DISTINCT accounts.name, R.name
    FROM accounts
JOIN sales_reps sr on sr.id = accounts.sales_rep_id
JOIN region r on r.id = sr.region_id;

SELECT DISTINCT id, name
FROM accounts;
# Have any sales reps worked on more than one account?
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

# 23 Having
# 1. How many of the sales reps have more than 5 accounts that they manage?
SELECT COUNT(*) as number_accounts
    FROM accounts
JOIN sales_reps sr on accounts.sales_rep_id = sr.id
GROUP BY sr.id, sr.name
HAVING number_accounts > 5;

SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
HAVING COUNT(*) > 5
ORDER BY num_accounts;

SELECT COUNT(*) num_reps_above5
FROM(SELECT s.id, s.name, COUNT(*) num_accounts
        FROM accounts a
        JOIN sales_reps s
        ON s.id = a.sales_rep_id
        GROUP BY s.id, s.name
        HAVING COUNT(*) > 5
        ORDER BY num_accounts) AS Table1;

# 2. How many accounts have more than 20 orders?
SELECT COUNT(*) AS number_orders
    FROM orders
JOIN accounts a on a.id = orders.account_id
JOIN sales_reps sr on sr.id = a.sales_rep_id
GROUP BY a.id, a.name
HAVING number_orders > 20;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING COUNT(*) > 20
ORDER BY num_orders;

# 3. Which account has the most orders?
SELECT a.name, COUNT(*) AS number_orders
    FROM orders
JOIN accounts a on a.id = orders.account_id
JOIN sales_reps sr on sr.id = a.sales_rep_id
GROUP BY a.id, a.name
ORDER BY number_orders DESC
LIMIT 1;

SELECT a.id, a.name, COUNT(*) num_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY num_orders DESC
LIMIT 1;

# 4. Which accounts spent more than 30,000 usd total across all orders?
SELECT a.name
    FROM orders
JOIN accounts a ON a.id = orders.account_id
GROUP BY a.name
HAVING SUM(orders.total_amt_usd) > 30000;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) > 30000
ORDER BY total_spent;

# 5. Which accounts spent less than 1,000 usd total across all orders?
SELECT a.name
    FROM orders
JOIN accounts a ON a.id = orders.account_id
GROUP BY a.name
HAVING SUM(orders.total_amt_usd) < 1000;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
HAVING SUM(o.total_amt_usd) < 1000
ORDER BY total_spent;

# 6. Which account has spent the most with us?
SELECT a.name, SUM(orders.total_amt_usd) AS total
    FROM orders
JOIN accounts a ON a.id = orders.account_id
GROUP BY a.name
ORDER BY total DESC
LIMIT 1;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent DESC
LIMIT 1;

# 7. Which account has spent the least with us?
SELECT a.name, SUM(orders.total_amt_usd) AS total
    FROM orders
JOIN accounts a ON a.id = orders.account_id
GROUP BY a.name
ORDER BY total
LIMIT 1;

SELECT a.id, a.name, SUM(o.total_amt_usd) total_spent
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY total_spent
LIMIT 1;

# 8. Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT accounts.name
    FROM accounts
JOIN web_events we on accounts.id = we.account_id
WHERE we.channel = 'facebook'
GROUP BY we.account_id
HAVING COUNT(*) > 6;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
HAVING COUNT(*) > 6 AND w.channel = 'facebook'
ORDER BY use_of_channel;

# 9. Which account used facebook most as a channel?
SELECT accounts.name, COUNT(*) AS total
    FROM accounts
JOIN web_events we on accounts.id = we.account_id
WHERE channel = 'facebook'
GROUP BY we.account_id, we.channel
ORDER BY total DESC
LIMIT 1;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE w.channel = 'facebook'
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 1;

# 10. Which channel was most frequently used by most accounts?
SELECT we.channel, COUNT(*) AS total
    FROM accounts
JOIN web_events we on accounts.id = we.account_id
GROUP BY we.account_id, we.channel
ORDER BY total DESC
LIMIT 10;

SELECT a.id, a.name, w.channel, COUNT(*) use_of_channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a.id, a.name, w.channel
ORDER BY use_of_channel DESC
LIMIT 10;

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


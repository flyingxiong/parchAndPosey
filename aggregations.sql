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



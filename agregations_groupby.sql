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
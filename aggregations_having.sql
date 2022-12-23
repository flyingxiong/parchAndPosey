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
SELECT orders.*,
       accounts.*
  FROM orders
  JOIN accounts
    ON orders.account_id = accounts.id;

SELECT orders.*
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;

# 04 join
SELECT orders.standard_qty, orders.gloss_qty,
       orders.poster_qty, accounts.website,
       accounts.primary_poc
FROM orders
JOIN accounts
ON accounts.id = orders.account_id;

# 10
SELECT web_events.channel, web_events.occurred_at
    FROM web_events
JOIN accounts a on web_events.account_id = a.id
WHERE a.name = 'Walmart';
# Solution
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

SELECT region.name, sr.name, a.name
FROM region
JOIN sales_reps sr on region.id = sr.region_id
JOIN accounts a on sr.id = a.sales_rep_id;

# Solution
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

SELECT region.name, a.name, (o.total_amt_usd/(o.total+0.01))
FROM region
JOIN sales_reps on region.id = sales_reps.region_id
JOIN accounts a on sales_reps.id = a.sales_rep_id
JOIN orders o on a.id = o.account_id;

# Solution
SELECT r.name region, a.name account,
           o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;


# 19 last check
# 1. Provide a table that provides the region for each sales_rep along
# with their associated accounts. This time only for the Midwest region.
# Your final table should include three columns: the region name,
# the sales rep name, and the account name. Sort the accounts
# alphabetically (A-Z) according to account name.
SELECT  r.name region, sr.name sales, a.name account
    FROM region r
JOIN sales_reps sr on sr.region_id = r.id
JOIN accounts a on sr.id = a.sales_rep_id
ORDER BY account DESC;

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest'
ORDER BY a.name;

# 2.Provide a table that provides the region for each sales_rep along
# with their associated accounts. This time only for accounts where the sales rep
# has a first name starting with S and in the Midwest region.
# Your final table should include three columns: the region name,
# the sales rep name, and the account name.
# Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, sr.name sales, a.name account
    FROM region r
JOIN sales_reps sr on sr.region_id = r.id
JOIN accounts a on sr.id = a.sales_rep_id
WHERE a.name LIKE 'S%';

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE 'S%'
ORDER BY a.name;

# 3. Provide a table that provides the region for each sales_rep along
# with their associated accounts. This time only for accounts where the sales rep
# has a last name starting with K and in the Midwest region.
# Your final table should include three columns: the region name, the sales rep name,
# and the account name. Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, sr.name sales, a.name account
    FROM region r
JOIN sales_reps sr on sr.region_id = r.id
JOIN accounts a on sr.id = a.sales_rep_id
WHERE sr.name LIKE '% K%' and r.name = 'Midwest';

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

# 4. Provide the name for each region for every order, as well as the account name
# and the unit price they paid (total_amt_usd/total) for the order.
# However, you should only provide the results if the standard order quantity exceeds 100.
# Your final table should have 3 columns: region name, account name, and unit price.
# In order to avoid a division by zero error, adding .01 to the denominator here is
# helpful total_amt_usd/(total+0.01).
SELECT r2.name region, a.name account, (r.total_amt_usd/(r.total_amt_usd+0.01)) unit_price
    FROM orders r
JOIN accounts a on r.account_id = a.id
JOIN sales_reps sr on a.sales_rep_id = sr.id
JOIN region r2 on r2.id = sr.region_id
WHERE r.standard_qty > 100;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100;

# 5 Provide the name for each region for every order, as well as the account name and the
# unit price they paid (total_amt_usd/total) for the order. However, you should only provide
# the results if the standard order quantity exceeds 100 and the poster order quantity exceeds 50.
# Your final table should have 3 columns: region name, account name, and unit price.
# Sort for the smallest unit price first. In order to avoid a division by zero error,
# adding .01 to the denominator here is helpful (total_amt_usd/(total+0.01).
SELECT r2.name region, a.name account, (r.total_amt_usd/(r.total_amt_usd+0.01)) unitprice
    FROM orders r
JOIN accounts a on r.account_id = a.id
JOIN sales_reps sr on a.sales_rep_id = sr.id
JOIN region r2 on r2.id = sr.region_id
WHERE r.standard_qty > 100 AND poster_qty > 50
ORDER BY unitprice;


SELECT r2.name region, a.name account, (r.total_amt_usd/(r.total_amt_usd+0.01)) unitprice
    FROM orders r
JOIN accounts a on r.account_id = a.id
JOIN sales_reps sr on a.sales_rep_id = sr.id
JOIN region r2 on r2.id = sr.region_id
WHERE r.standard_qty > 1000 AND poster_qty > 50
ORDER BY unitprice DESC;

# 6
SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
WHERE o.standard_qty > 100 AND o.poster_qty > 50
ORDER BY unit_price DESC;

# 7 What are the different channels used by account id 1001?
# Your final table should have only 2 columns: account name and the different channels.
# You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channel
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
WHERE a.id = '1001';

# 8 Find all the orders that occurred in 2015. Your final table should have 4 columns:
# occurred_at, account name, order total, and order total_amt_usd.

SELECT orders.occurred_at, a.name, orders.total, orders.total_amt_usd
    FROM orders
JOIN accounts JOIN accounts a on orders.account_id = a.id
WHERE occurred_at > '2015';

SELECT o.occurred_at, a.name, o.total, o.total_amt_usd
FROM accounts a
JOIN orders o
ON o.account_id = a.id
WHERE o.occurred_at BETWEEN '01-01-2015' AND '01-01-2016'
ORDER BY o.occurred_at DESC;
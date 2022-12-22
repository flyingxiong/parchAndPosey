SELECT *
FROM parch_and_posey.orders
ORDER BY occurred_at
LIMIT 10;

# 18. Practice
SELECT id, occurred_at, total_amt_usd
FROM parch_and_posey.orders
LIMIT 10;

SELECT id, account_id, total_amt_usd
FROM parch_and_posey.orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM parch_and_posey.orders
ORDER BY total_amt_usd DESC, account_id
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM parch_and_posey.orders
ORDER BY total_amt_usd
LIMIT 20;

# 21. ORDER BY Quiz start from 21.1
SELECT id, account_id, total_amt_usd
FROM parch_and_posey.orders
ORDER BY account_id, total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM parch_and_posey.orders
ORDER BY total_amt_usd DESC, account_id
LIMIT 5;

# 23 WHERE
SELECT *
FROM parch_and_posey.orders
WHERE account_id = 4251
ORDER BY occurred_at
LIMIT 1000;

# 24 quiz: where
SELECT  *
FROM parch_and_posey.orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT  *
FROM parch_and_posey.orders
WHERE total_amt_usd < 1000
LIMIT 10;

# 25
SELECT name, website, primary_poc
FROM parch_and_posey.accounts
WHERE name = 'Exxon Mobil'

# 29
SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty,
       gloss_qty + poster_qty AS nonstandard_qty
FROM parch_and_posey.orders

# 30




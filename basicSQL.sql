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
WHERE name = 'Exxon Mobil';

# 29
SELECT account_id,
       occurred_at,
       standard_qty,
       gloss_qty,
       poster_qty,
       gloss_qty + poster_qty AS nonstandard_qty
FROM parch_and_posey.orders;

# 30 Write a query that finds the percentage of revenue that comes from poster paper for each order.
# You will need to use only the columns that end with _usd.
# (Try to do this without using the total column.) Display the id and account_id fields also.
SELECT id,
       account_id,
       standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

SELECT id,
       account_id,
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

# 33 LIKE operator
SELECT *
FROM parch_and_posey.web_events
WHERE occurred_at LIKE '%T03%'
LIMIT 10;

# 34 QUIZ: LIKE
SELECT name
FROM accounts
WHERE name LIKE 'c%';

SELECT name
FROM accounts
WHERE name LIKE '%s';

SELECT name
FROM accounts
WHERE name LIKE '%one%';

# 36 IN
SELECT *
    FROM orders
WHERE account_id IN (1001, 1021);

# 37
SELECT name, primary_poc, sales_rep_id
    FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstorm');

SELECT *
    FROM web_events
WHERE channel IN ('organic', 'adwords');

# 43 quiz: AND and BETWEEN
SELECT *
    FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;


# NOTE: do not forget the name in the last line
SELECT name
    FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%S';

SELECT occurred_at,
       gloss_qty
    FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at LIKE '%2016%'
ORDER BY occurred_at DESC;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'
ORDER BY occurred_at DESC;

# 46 Quiz: OR
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
    FROM orders
WHERE standard_qty = 0 AND ( gloss_qty > 1000 OR poster_qty > 1000 );

SELECT name
    FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
      AND (primary_poc LIKE '%ana%' OR primary_poc like '%Ana%')
      AND primary_poc NOT LIKE '%eana%';
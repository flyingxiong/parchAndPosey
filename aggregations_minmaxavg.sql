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
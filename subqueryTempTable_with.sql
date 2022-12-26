SELECT channel,
       AVG(event_count) AS avg_event_count
FROM (SELECT EXTRACT(DAY FROM web_events.occurred_at) AS day,
             web_events.channel,
             COUNT(*)                                 AS event_count
      FROM web_events
      GROUP BY 1, 2) sub
GROUP BY 1
ORDER BY 2 DESC;

WITH events AS (SELECT EXTRACT(DAY FROM web_events.occurred_at) AS day,
                       web_events.channel,
                       COUNT(*)                                 AS event_count
                FROM web_events
                GROUP BY 1, 2)

SELECT channel,
       AVG(event_count) AS evg_event_count
FROM events
GROUP BY 1
ORDER BY 2 DESC;


# Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
WITH temp AS (SELECT sr.id                     AS sale_id,
                     sr.name                   AS sale_rep,
                     r.name                    AS region,
                     SUM(orders.total_amt_usd) AS total
              FROM orders
                       JOIN accounts a on a.id = orders.account_id
                       JOIN sales_reps sr on sr.id = a.sales_rep_id
                       JOIN region r on r.id = sr.region_id
              GROUP BY 2, 3
              ORDER BY 4),
    temp2 AS ( SELECT region, MAX(total) AS region_max
               FROM temp
               GROUP BY 1
    )

SELECT sale_id, sale_rep, temp.region, region_max
FROM temp2
JOIN temp on temp.total = temp2.region_max
ORDER BY 4 DESC ;

WITH t1 AS (
     SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
      FROM sales_reps s
      JOIN accounts a
      ON a.sales_rep_id = s.id
      JOIN orders o
      ON o.account_id = a.id
      JOIN region r
      ON r.id = s.region_id
      GROUP BY 1,2
      ORDER BY 3 DESC),
t2 AS (
      SELECT region_name, MAX(total_amt) total_amt
      FROM t1
      GROUP BY 1)
SELECT t1.rep_name, t1.region_name, t1.total_amt
FROM t1
JOIN t2
ON t1.region_name = t2.region_name AND t1.total_amt = t2.total_amt;

# For the region with the largest sales total_amt_usd, how many total orders were placed?


# How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?


# For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?


# What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?


# What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
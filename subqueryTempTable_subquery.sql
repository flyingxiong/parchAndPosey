SELECT *
FROM orders
WHERE EXTRACT(MONTH FROM occurred_at) = (SELECT EXTRACT(MONTH FROM MIN(occurred_at)) AS min_month
                                         FROM orders)
ORDER BY occurred_at;

# Use DATE_TRUNC to pull month level information about the first order ever placed in the orders table.
SELECT EXTRACT(MONTH FROM earlist_order) AS earliest_month
FROM (SELECT MIN(occurred_at) AS earlist_order
      FROM orders
      LIMIT 1) sub;

SELECT EXTRACT(YEAR_MONTH FROM MIN(occurred_at))
FROM orders;

# Use the result of the previous query to find only the orders that took place in the same month and year as the first order, and then pull the average for each type of paper qty in this month.

SELECT EXTRACT(YEAR_MONTH FROM occurred_at),
       AVG(standard_qty)  as avg_standard,
       AVG(gloss_qty)     AS avg_gloss,
       AVG(poster_qty)    as avg_poster,
       SUM(total_amt_usd) AS total_spent
FROM orders
WHERE EXTRACT(YEAR_MONTH FROM occurred_at) = (SELECT EXTRACT(YEAR_MONTH FROM MIN(occurred_at))
                                              FROM orders);

SELECT EXTRACT(MONTH FROM earlist_order) AS earliest_month,
       EXTRACT(YEAR FROM earlist_order)  AS earliest_year
FROM (SELECT MIN(occurred_at) AS earlist_order
      FROM orders
      LIMIT 1) sub;

SELECT EXTRACT(YEAR_MONTH FROM MIN(occurred_at))
FROM orders;

# 09 quiz: subquery Mania
# Provide the name of the sales_rep in each region with the largest total amount of total_amt_usd sales.
SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM (SELECT rep_name, region_name, MAX(total_amt) total_amt
      FROM (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
            FROM sales_reps s
                     JOIN accounts a
                          ON a.sales_rep_id = s.id
                     JOIN orders o
                          ON o.account_id = a.id
                     JOIN region r
                          ON r.id = s.region_id
            GROUP BY 1, 2) t1
      GROUP BY 2) t2
         JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
               FROM sales_reps s
                        JOIN accounts a
                             ON a.sales_rep_id = s.id
                        JOIN orders o
                             ON o.account_id = a.id
                        JOIN region r
                             ON r.id = s.region_id
               GROUP BY 1, 2) t3
              ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

# For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
SELECT t1.region, t1.sum_sales, t2.total_count
FROM (SELECT r.name region, SUM(orders.total_amt_usd) sum_sales
      FROM orders
               JOIN accounts a on a.id = orders.account_id
               JOIN sales_reps sr on sr.id = a.sales_rep_id
               JOIN region r on r.id = sr.region_id
      GROUP BY 1) t1
         JOIN (SELECT r2.name region, COUNT(total_amt_usd) total_count
               FROM orders
                        JOIN accounts a on orders.account_id = a.id
                        JOIN sales_reps s on a.sales_rep_id = s.id
                        JOIN region r2 on s.region_id = r2.id
               GROUP BY 1) t2
              ON t1.region = t2.region;

SELECT t1.region, t1.sum_sales, t1.sum_count
FROM (SELECT r.name region, SUM(orders.total_amt_usd) sum_sales, COUNT(total_amt_usd) sum_count
      FROM orders
               JOIN accounts a on a.id = orders.account_id
               JOIN sales_reps sr on sr.id = a.sales_rep_id
               JOIN region r on r.id = sr.region_id
      GROUP BY 1) t1
HAVING t1.sum_sales = (SELECT MAX(sub.sum_sales)
                       FROM (SELECT r.name region, SUM(orders.total_amt_usd) sum_sales, COUNT(total_amt_usd) sum_count
                             FROM orders
                                      JOIN accounts a on a.id = orders.account_id
                                      JOIN sales_reps sr on sr.id = a.sales_rep_id
                                      JOIN region r on r.id = sr.region_id
                             GROUP BY 1) sub);

SELECT r.name, COUNT(o.total) total_orders
FROM sales_reps s
         JOIN accounts a
              ON a.sales_rep_id = s.id
         JOIN orders o
              ON o.account_id = a.id
         JOIN region r
              ON r.id = s.region_id
GROUP BY r.name
HAVING SUM(o.total_amt_usd) = (SELECT MAX(total_amt)
                               FROM (SELECT r.name region_name, SUM(o.total_amt_usd) total_amt
                                     FROM sales_reps s
                                              JOIN accounts a
                                                   ON a.sales_rep_id = s.id
                                              JOIN orders o
                                                   ON o.account_id = a.id
                                              JOIN region r
                                                   ON r.id = s.region_id
                                     GROUP BY r.name) sub);

# How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?

SELECT COUNT(*) count_more_than_most_standard_total
FROM (SELECT a.name, SUM(orders.total) account_total
      FROM orders
               JOIN accounts a on a.id = orders.account_id
      GROUP BY 1) t1
WHERE account_total >
      (SELECT total
       FROM (SELECT a.name, SUM(standard_qty) standard_total, SUM(orders.total) total
             FROM orders
                      JOIN accounts a on a.id = orders.account_id
             GROUP BY 1
             ORDER BY 2 DESC
             LIMIT 1) sub);

SELECT COUNT(*)
FROM (SELECT a.name
      FROM orders o
               JOIN accounts a
                    ON a.id = o.account_id
      GROUP BY 1
      HAVING SUM(o.total) > (SELECT total
                             FROM (SELECT a.name act_name, SUM(o.standard_qty) tot_std, SUM(o.total) total
                                   FROM accounts a
                                            JOIN orders o
                                                 ON o.account_id = a.id
                                   GROUP BY 1
                                   ORDER BY 2 DESC
                                   LIMIT 1) inner_tab)) counter_tab;

# For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
FROM orders o
         JOIN accounts a
              ON a.id = o.account_id
GROUP BY a.id, a.name
ORDER BY 3 DESC
LIMIT 1;

SELECT total_tab.name, we.channel, count(*)
FROM (SELECT a2.id id, a2.name name, SUM(orders.total_amt_usd) total_spent
      FROM orders
               JOIN accounts a2 on orders.account_id = a2.id
      GROUP BY 1, 2
      ORDER BY 3 DESC
      LIMIT 1) total_tab
         JOIN accounts a on a.id = total_tab.id
         JOIN web_events we on total_tab.id = we.account_id
GROUP BY 2
ORDER BY 3 DESC;

SELECT a.name, w.channel, COUNT(*)
FROM accounts a
         JOIN web_events w
              ON a.id = w.account_id AND a.id = (SELECT id
                                                 FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
                                                       FROM orders o
                                                                JOIN accounts a
                                                                     ON a.id = o.account_id
                                                       GROUP BY a.id, a.name
                                                       ORDER BY 3 DESC
                                                       LIMIT 1) inner_table)
GROUP BY 1, 2
ORDER BY 3 DESC;
# What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
SELECT AVG(temp.total_spent)
FROM (
SELECT account_id, SUM(total_amt_usd) total_spent
    FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10) temp
JOIN accounts ON account_id = accounts.id;

SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
         FROM orders o
         JOIN accounts a
         ON a.id = o.account_id
         GROUP BY a.id, a.name
         ORDER BY 3 DESC
          LIMIT 10) temp;

# What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
SELECT AVG(avg_amt)
FROM (SELECT o.account_id, AVG(o.total_amt_usd) avg_amt
       FROM orders o
       GROUP BY 1
       HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) avg_all
                                      FROM orders o)) temp_table;
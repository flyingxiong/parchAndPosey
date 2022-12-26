# each account who has a sales rep and each sales rep that has an account
# (all of the columns in these returned rows will be full)
# but also each account that does not have a sales rep and each sales rep
# that does not have an account (some of the columns in these returned rows will be empty)
SELECT *
  FROM accounts
LEFT OUTER JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
WHERE sales_reps.id IS NULL

UNION

SELECT *
  FROM accounts
RIGHT OUTER JOIN sales_reps ON accounts.sales_rep_id = sales_reps.id
WHERE accounts.sales_rep_id IS NULL

# 05 JOIN with Comparison Operators
SELECT orders.id,
       orders.occurred_at AS order_date,
       we.*
    FROM orders
LEFT JOIN web_events we on orders.account_id = we.account_id
AND we.occurred_at < orders.occurred_at
WHERE EXTRACT(MONTH FROM orders.occurred_at) = (
    SELECT EXTRACT(MONTH FROM MIN(orders.occurred_at)) FROM orders
    )
ORDER BY orders.account_id, orders.occurred_at;

# 06 quiz:
SELECT accounts.name,
       accounts.primary_poc,
        sr.name
    FROM accounts
LEFT JOIN sales_reps sr on accounts.sales_rep_id = sr.id
AND accounts.primary_poc < sr.name

SELECT accounts.name as account_name,
       accounts.primary_poc as poc_name,
       sales_reps.name as sales_rep_name
  FROM accounts
  LEFT JOIN sales_reps
    ON accounts.sales_rep_id = sales_reps.id
   AND accounts.primary_poc < sales_reps.name
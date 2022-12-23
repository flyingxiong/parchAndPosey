# DISTINCT
SELECT web_events.account_id,
       web_events.channel,
       COUNT(web_events.id) as events
    FROM web_events
GROUP BY web_events.account_id, web_events.channel
ORDER BY web_events.account_id, events;

# is the same as above, except the events column
SELECT DISTINCT web_events.account_id,
                channel
    FROM web_events
ORDER BY web_events.account_id;

# 20 distict quiz
# Use DISTINCT to test if there are any accounts associated with more than one region.
SELECT DISTINCT accounts.name, R.name
    FROM accounts
JOIN sales_reps sr on sr.id = accounts.sales_rep_id
JOIN region r on r.id = sr.region_id;

SELECT DISTINCT id, name
FROM accounts;
# Have any sales reps worked on more than one account?
SELECT s.id, s.name, COUNT(*) num_accounts
FROM accounts a
JOIN sales_reps s
ON s.id = a.sales_rep_id
GROUP BY s.id, s.name
ORDER BY num_accounts;

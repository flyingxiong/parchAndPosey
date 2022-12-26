# Find acounts that made most order in  the last 28 days
SELECT o1.id  AS o1_id,
       o1.account_id AS o1_account_id,
       o1.occurred_at AS o1_occurred_at,
       o2.id AS o2_id,
       o2.account_id AS o2_account_id,
       o2.occurred_at AS o2_occurred_at
    FROM orders o1
LEFT JOIN orders o2
ON o1.account_id = o2.account_id
AND o2.occurred_at > o1.occurred_at
AND o2.occurred_at <= o1.occurred_at + INTERVAL 28 DAY
ORDER BY o1.account_id, o1.occurred_at;

# 09: quiz
# Modify the query from the previous video, which is pre-populated in the SQL Explorer below,
# to perform the same interval analysis except for the web_events table. Also:

# change the interval to 1 day to find those web events that occurred after,
# but not more than 1 day after, another web event
SELECT o1.id  AS o1_id,
       o1.account_id AS o1_account_id,
       o1.occurred_at AS o1_occurred_at,
       o1.channel as o1_channel,
       o2.id AS o2_id,
       o2.account_id AS o2_account_id,
       o2.occurred_at AS o2_occurred_at,
       o2.channel AS o2_channel
    FROM web_events o1
LEFT JOIN web_events o2
ON o1.account_id = o2.account_id
AND o2.occurred_at > o1.occurred_at
AND o2.occurred_at <= o1.occurred_at + INTERVAL 1 DAY
ORDER BY o1.account_id, o2.occurred_at;

SELECT we1.id AS we_id,
       we1.account_id AS we1_account_id,
       we1.occurred_at AS we1_occurred_at,
       we1.channel AS we1_channel,
       we2.id AS we2_id,
       we2.account_id AS we2_account_id,
       we2.occurred_at AS we2_occurred_at,
       we2.channel AS we2_channel
  FROM web_events we1
 LEFT JOIN web_events we2
   ON we1.account_id = we2.account_id
  AND we1.occurred_at > we2.occurred_at
  AND we1.occurred_at <= we2.occurred_at + INTERVAL 1 DAY
ORDER BY we1.account_id, we2.occurred_at
# add a column for the channel variable in both instances of the table in your query
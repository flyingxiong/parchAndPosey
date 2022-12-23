SELECT channel,
       AVG(event_count) AS avg_event_count
    FROM
(SELECT EXTRACT(DAY FROM occurred_at) AS day,
       channel,
       COUNT(*) AS event_count
FROM web_events
GROUP BY day,channel
ORDER BY day) sub
GROUP BY channel
ORDER BY avg_event_count DESC;


SELECT channel,
       AVG(event_count) AS avg_event_count
    FROM
(SELECT EXTRACT(DAY FROM occurred_at) AS day,
       channel,
       COUNT(*) AS event_count
FROM web_events
GROUP BY 1,2
# ORDER BY 1
) sub
GROUP BY 1
ORDER BY 2 DESC;

# QUIZ 1:  On which day-channel pair did the most events occur.
SELECT day,
       channel
    FROM (SELECT DATE (occurred_at) AS day,
       channel,
       COUNT(*) AS event_count
    FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC) sub
WHERE event_count = 21;

SELECT DATE (occurred_at) AS day,
       channel, COUNT(*) as events
FROM web_events
GROUP BY 1,2
ORDER BY 3 DESC;

# quiz 2:
SELECT *
FROM (SELECT DATE(occurred_at) AS day,
                channel, COUNT(*) as events
          FROM web_events
          GROUP BY 1,2
          ORDER BY 3 DESC) sub;

# QUIZ 3:
SELECT channel, AVG(events) AS avg_event
FROM (SELECT DATE(occurred_at) AS day,
                channel, COUNT(*) as events
          FROM web_events
          GROUP BY 1,2) sub
GROUP BY 1
ORDER BY 2 DESC ;
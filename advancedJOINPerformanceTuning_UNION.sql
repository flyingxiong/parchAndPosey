

# Add a WHERE clause to each of the tables that you unioned in the query above,
# filtering the first table where name equals Walmart
#     and filtering the second table where name equals Disney.
#     Inspect the results then answer the subsequent quiz.
SELECT *
FROM accounts
WHERE name = 'Walmart'

UNION

SELECT *
FROM accounts
WHERE name = 'Disney';

# Perform the union in your first query (under the Appending Data via UNION header) in a common table expression and name it double_accounts. Then do a COUNT the number of times a name appears in the double_accou
# nts table. If you do this correctly, your query results should have a count of 2 for each name.

WITH union_all as ( SELECT *
FROM accounts

UNION ALL

SELECT *
FROM accounts )

SELECT name, COUNT(*)
FROM union_all
GROUP BY name
order by 2;
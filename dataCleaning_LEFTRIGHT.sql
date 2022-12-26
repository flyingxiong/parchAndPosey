SELECT first_name,
        last_name,
        phone_number,
        LEFT(phone_number, 3) AS area_code,
        RIGHT(phone_number, 8) AS phone_number_only,
        RIGHT(phone_number, LENGTH(phone_number) -4) AS phone_number_alt
    FROM customer_data


# In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. A list of extensions (and pricing) is provided here. Pull these extensions and provide how many of each website type exist in the accounts table.
SELECT RIGHT(website, 3) AS domain, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

# There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).
SELECT LEFT(name, 1) first_chars, COUNT(*) first_char_count
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

SELECT LEFT(UPPER(name), 1) AS first_letter, COUNT(*) num_companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

# Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?


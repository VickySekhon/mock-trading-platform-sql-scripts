/*

CP363 Assignment 5 - Advanced Queries and Views Using Sub-queries 
Authors: Vicky Sekhon and Christopher Ooi En Shen
Date: February 10th, 2025

*/
use database363;

-- Advanced queries
-- Advanced query 1. Find most popular account and the most common asset held within that account
select a.account_type_id, COUNT(*) As count, asst.symbol
from Accounts a
join Portfolios p on p.account_id = a.account_id
join Assets asst on p.asset_id = asst.asset_id
group by a.account_type_id
order by count desc
limit 1;

-- Advanced query 2. Most trending buy right now
select a.symbol, count(a.asset_id) as count from Carts c
join Assets a on a.asset_id = c.asset_id
group by a.asset_id
order by count desc
limit 1;

-- Advanced query 3. City of investors who are making the most transactions
SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(i.home_address, ',', 2), ',', -1) AS city, -- 1st substring_index gives ("street", "city"), 2nd gives ("city")
    COUNT(t.transaction_id) AS transaction_count,
    RANK() OVER (ORDER BY COUNT(t.transaction_id) DESC) AS transaction_rank
FROM Investors i
JOIN Accounts a ON a.investor_id = i.investor_id
JOIN Transactions t ON t.account_id = a.account_id
GROUP BY i.home_address, i.investor_id, a.account_id
ORDER BY transaction_rank;

-- Advanced query 4. Number of investors with accounts grouped by age and account_type
SELECT 
    TIMESTAMPDIFF(YEAR, i.date_of_birth, CURDATE()) AS age, 
    i.date_of_birth,
    atype.account_type,
    COUNT(*) AS num_investors
FROM Investors i
JOIN Accounts a ON a.investor_id = i.investor_id
JOIN Account_Types atype ON a.account_type_id = atype.account_type_id
GROUP BY age, atype.account_type
ORDER BY age DESC;

-- Advanced views

-- Advanced view 1. Investors with access to their portfolio returns (subquery in columns)
CREATE VIEW AdvancedInvestorView AS
SELECT 
    i.investor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS investor_name,
	CONCAT('$', FORMAT(ROUND(SUM(ip.initial_price), 2), 2)) AS total_initial_price, -- Use dollar string formatting
	CONCAT('$', FORMAT(ROUND(SUM(p.current_price), 2), 2)) AS total_current_price,
    CONCAT('$', FORMAT(SUM(p.current_price - ip.initial_price), 2)) AS total_profit,
    -- Case #1. Only show the returns when the total initial price and total current price are not the same
    CASE 
		WHEN SUM(ip.initial_price) < SUM(p.current_price)
		THEN CONCAT(FORMAT((SUM(p.current_price) / SUM(ip.initial_price)) * 100, 2), '%') 
    ELSE NULL 
	END AS returns_percentage,
    -- Case #2. Show increase/decrease based on current price compared to initial price
    CASE 
        WHEN SUM(p.current_price) >= SUM(ip.initial_price) THEN 'Increase'
        ELSE 'Decrease'
    END AS performance_trend
FROM Investors i
JOIN Accounts a ON i.investor_id = a.investor_id
JOIN Performances p ON a.account_id = p.account_id
JOIN Initial_Prices ip ON a.account_id = ip.account_id
GROUP BY i.investor_id, i.first_name, i.last_name;
-- Outputs
/*
+-------------+----------------+------------------+------------------+-------------+------------------+------------------+
| investor_id | investor_name  | total_initial_price | total_current_price | total_profit | returns_percentage | performance_trend |
+-------------+----------------+------------------+------------------+-------------+------------------+------------------+
| 1           | Paul Anderson  | $6,670.09        | $14,963.09       | $8,293.00   | 224.33%          | Increase         |
| 2           | Emily Johnson  | $1,382.17        | $1,382.17        | $0.00       | NULL             | Increase         |
| 3           | Michael Smith  | $4,756.98        | $4,756.98        | $0.00       | NULL             | Increase         |
| 4           | Sarah Brown    | $2,549.55        | $2,549.55        | $0.00       | NULL             | Increase         |
| 5           | David Lee      | $4,098.32        | $4,098.32        | $0.00       | NULL             | Increase         |
| 6           | Jessica Taylor | $1,657.20        | $1,657.20        | $0.00       | NULL             | Increase         |
| 7           | Daniel Wilson  | $3,211.67        | $3,211.67        | $0.00       | NULL             | Increase         |
| 8           | Laura Martinez | $7,127.02        | $7,127.02        | $0.00       | NULL             | Increase         |
| 9           | James Garcia   | $1,822.25        | $1,822.25        | $0.00       | NULL             | Increase         |
| 10          | Olivia Davis   | $1,000.51        | $1,000.51        | $0.00       | NULL             | Increase         |
+-------------+----------------+------------------+------------------+-------------+------------------+------------------+
*/

-- Advanced view 2. Brokers overiew of all investors and their total assets under management by account_type (subquery in From clause)
CREATE VIEW AdvancedBrokerView2 AS
SELECT 
    dt.account_type,
    COUNT(DISTINCT dt.account_id) AS total_accounts,
    CONCAT('$', FORMAT(ROUND(SUM(dt.asset_value), 2), 2)) AS assets_under_management, -- Format both computed values as currency amounts
    COUNT(dt.transaction_id) AS total_transactions,
    CONCAT('$', FORMAT(ROUND(SUM(dt.transaction_value), 2), 2)) AS total_transaction_volume
FROM (
    -- Use a derived table to find the pre-computed asset and transaction values
    -- Equivalent would be to do a joins outside the "From" clause
    SELECT 
        at.account_type,
        a.account_id,
        COALESCE(p.asset_quantity * ast.price_per_share, 0) AS asset_value,
        t.transaction_id,
        COALESCE(t.asset_quantity * ast_txn.price_per_share, 0) AS transaction_value
    FROM Account_Types at
    JOIN Accounts a ON at.account_type_id = a.account_type_id
    LEFT JOIN Portfolios p ON a.account_id = p.account_id
    LEFT JOIN Assets ast ON p.asset_id = ast.asset_id
    LEFT JOIN Transactions t ON a.account_id = t.account_id
    LEFT JOIN Assets ast_txn ON t.asset_id = ast_txn.asset_id
) AS dt
GROUP BY dt.account_type -- Group common accounts together
ORDER BY assets_under_management DESC;
-- Outputs
/*
+-------------+---------------+-------------------------+-------------------+------------------------+
| account_type | total_accounts | assets_under_management | total_transactions | total_transaction_volume |
+-------------+---------------+-------------------------+-------------------+------------------------+
| LIRA        | 2             | $8,949.27               | 2                 | $8,949.27              |
| RRSP        | 2             | $5,480.49               | 2                 | $5,480.49              |
| RESP        | 2             | $4,868.87               | 2                 | $4,868.87              |
| FHSA        | 3             | $3,550.06               | 2                 | $3,550.06              |
| TFSA        | 2             | $28,013.07              | 5                 | $28,013.07             |
+-------------+---------------+-------------------------+-------------------+------------------------+
*/
/*

CP363 Assignment 4 - Populating Tables, Designing Queries, and Creating Views
Authors: Vicky Sekhon and Christopher Ooi En Shen
Date: February 7th, 2025

*/

-- 13 Queries Total

-- Query 1. Find all investors to send updates to for when an asset falls below their target_price
select w.investor_id, a.symbol, w.target_price, a.price_per_share
from Watchlists w
join Assets a on a.asset_id = w.asset_id
where a.price_per_share <= w.target_price;

-- Query 2. (x,y) coordinates for an investors portfolio so that it can be plotted with chart.js
select distinct current_price as y,
	row_number() over (order by performance_date asc) as x 
from Performances where account_id = 1;

/*
Query 3. Application logic for when an investor presses "Buy"  

Steps to take:
1. Transaction table updated
2. Cart emptied
3. Portfolio quantity updated`
4. Performance table updated
*/
-- 1. Transaction table updated
insert into Transactions (account_id, asset_id, asset_quantity, transaction_time, transaction_type)
VALUES ('x', 'y', 'z', NOW(), 'w');

-- 2. Cart emptied
delete from Carts
where account_id = 'x' and asset_id = 'y';

-- 3. Portfolio quantity updated
INSERT INTO Portfolios (account_id, asset_id, asset_quantity)
VALUES ('x', 'y', 'z') 
ON DUPLICATE KEY UPDATE 
    asset_quantity = VALUES(asset_quantity);

-- 4. Performance table updated
INSERT INTO Performances (account_id, initial_price, current_price, performance_date) 
SELECT account_id, initial_price, current_price + ('a.price_per_share'*'z'), NOW()
FROM Performances
WHERE account_id = 1
ORDER BY performance_date DESC
LIMIT 1;

-- Query 4. The portfolio return for a single portfolio
SELECT CONCAT(FORMAT(ROUND((current_price / initial_price) * 100, 3), 3), '%') AS portfolio_returns
FROM Performances
WHERE account_id = 1
ORDER BY performance_date DESC
LIMIT 1;

-- Query 5. Total amount invested across all users
select CONCAT('$', FORMAT(ROUND(SUM(asset_quantity * price_per_share), 2), '###,###.##')) As total_amount_invested_across_all_portfolios
from Portfolios
join Assets on Portfolios.asset_id = Assets.asset_id;

-- Query 6. The highest amount invested across all portfolios
SELECT 
    CONCAT('$', FORMAT(ROUND(MAX(total_portfolio_value), 2), '###,###.##')) AS highest_portfolio_value
FROM (
    SELECT 
        account_id, 
        SUM(asset_quantity * price_per_share) AS total_portfolio_value
    FROM Portfolios
    JOIN Assets ON Portfolios.asset_id = Assets.asset_id
    GROUP BY account_id
) AS account_portfolios;

-- Query 7. Broker with the most accounts
SELECT broker_name, COUNT(account_type) AS account_count
FROM Brokers
GROUP BY broker_name
ORDER BY account_count DESC
LIMIT 1;

-- Query 8. Divide investors into 4 groups based on the amount of funds they have
SELECT investor_id, first_name, last_name, funds,
       NTILE(4) OVER (ORDER BY funds DESC) AS fund_quartile
FROM Investors;

-- Query 9. Investors whose have more funds than the average investor
SELECT investor_id, first_name, last_name, funds
FROM Investors
WHERE funds > (SELECT AVG(funds) FROM Investors)
ORDER BY funds DESC;

-- Query 10. Funds deposited into each investors account by occupation
SELECT occupation, funds AS total_funds
FROM Investors
GROUP BY occupation
ORDER BY total_funds DESC;

-- Query 11. CTE (common table expression) to get total amount of investors' portfolios and rank them based on the total value across all their portfolios
with Portfoliovalues as ( 
    SELECT 
        account_id, 
        SUM(asset_quantity * price_per_share) AS total_portfolio_value
    FROM Portfolios
    JOIN Assets ON Portfolios.asset_id = Assets.asset_id
    GROUP BY account_id
)
Select i.investor_id, i.first_name, i.last_name, CONCAT('$', FORMAT(ROUND(pv.total_portfolio_value, 2), '###,###.##')) as funds, 
       Rank() Over (order by pv.total_portfolio_value desc) As fund_rank
From Investors i
join Accounts a on a.investor_id = i.investor_id
join Portfoliovalues pv on pv.account_id = a.account_id
Order by fund_rank;

-- Query 12. Broker with the most accounts
SELECT broker_name, COUNT(account_type) AS account_count
FROM Brokers
GROUP BY broker_name
ORDER BY account_count DESC
LIMIT 1;

-- Query 13. Each broker along with the count of accounts associated with them
Select b.broker_name, COUNT(a.account_id) As num_accounts
From Brokers b
join Accounts a ON b.broker_id = a.broker_id
group by b.broker_name
order by num_accounts Desc;

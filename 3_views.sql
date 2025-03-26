/*

CP363 Assignment 4 - Populating Tables, Designing Queries, and Creating Views
Authors: Vicky Sekhon and Christopher Ooi En Shen
Date: February 7th, 2025

*/

-- View #1 - Investors
CREATE VIEW InvestorView AS
SELECT 
    i.investor_id,
    CONCAT(i.first_name, ' ', i.last_name) AS investor_name,
    ROUND(SUM(ip.initial_price), 2) AS total_initial_price,
    ROUND(SUM(p.current_price), 2) AS total_current_price,
    ROUND(SUM(p.current_price - ip.initial_price), 2) AS total_profit,
    CASE 
        WHEN SUM(p.current_price) >= SUM(ip.initial_price) THEN 'Increase'
        ELSE 'Decrease'
    END AS performance_trend
FROM Investors i
JOIN Accounts a ON i.investor_id = a.investor_id
JOIN Performance_Prices p ON a.account_id = p.account_id
JOIN Initial_Prices ip ON a.account_id = ip.account_id
GROUP BY i.investor_id, i.first_name, i.last_name;

-- Outputs
/*
Combines investor data with account performance details, calculating profit and indicating performance trends.

investor_id  | investor_name    | total_initial_price | total_current_price | total_profit | performance_trend
---------------------------------------------------------------------------------------------------------------
1            | Paul Anderson    | 6670.09             | 14963.09            | 8293         | Increase
2            | Emily Johnson    | 1382.17             | 1382.17             | 0            | Increase
3            | Michael Smith    | 4756.98             | 4756.98             | 0            | Increase
4            | Sarah Brown      | 2549.55             | 2549.55             | 0            | Increase
5            | David Lee        | 4098.32             | 4098.32             | 0            | Increase
6            | Jessica Taylor   | 1657.2              | 1657.2              | 0            | Increase
7            | Daniel Wilson    | 3211.67             | 3211.67             | 0            | Increase
8            | Laura Martinez   | 7127.02             | 7127.02             | 0            | Increase
9            | James Garcia     | 1822.25             | 1822.25             | 0            | Increase
10           | Olivia Davis     | 1000.51             | 1000.51             | 0            | Increase
*/

-- View #2 - Brokers
CREATE VIEW BrokerView AS
SELECT
    at.account_type,
    COUNT(DISTINCT a.account_id) AS total_accounts,
    ROUND(SUM(p.asset_quantity * ast.price_per_share), 2) AS assets_under_management,
    COUNT(t.transaction_id) AS total_transactions,
    ROUND(SUM(t.asset_quantity * ast.price_per_share), 2) AS total_transaction_volume
FROM Account_Types at
JOIN Accounts a ON at.account_type_id = a.account_type_id
LEFT JOIN Portfolios p ON a.account_id = p.account_id
LEFT JOIN Asset_Prices ast ON p.asset_id = ast.asset_id
LEFT JOIN Transactions t ON a.account_id = t.account_id
GROUP BY at.account_type
ORDER BY assets_under_management DESC;

-- Outputs
/*
Help brokers monitor client assets under management (AUM) and transaction volumes using live asset prices.

account_type | total_accounts | assets_under_management | total_transactions | total_transaction_volume
------------------------------------------------------------------------------------------------------
TFSA         | 2             | 28013.07                | 5                  | 28013.07
LIRA         | 2             | 8949.27                 | 2                  | 8949.27
RRSP         | 2             | 5480.49                 | 2                  | 5480.49
RESP         | 2             | 4868.87                 | 2                  | 4868.87
FHSA         | 2             | 3550.06                 | 2                  | 3550.06

! Latest:
account_type | total_accounts | assets_under_management | total_transactions | total_transaction_volume
------------------------------------------------------------------------------------------------------
TFSA         | 2             | 25924.13                | 5                  | 28013.07
LIRA         | 2             | 8949.27                 | 2                  | 8949.27
RRSP         | 2             | 5480.49                 | 2                  | 5480.49
RESP         | 2             | 4868.87                 | 2                  | 4868.87
FHSA         | 2             | 3550.06                 | 2                  | 3550.06

*/

-- View #3 - Brokers
CREATE VIEW AdminView AS
SELECT 
    I.investor_id,
    I.first_name,
    I.last_name,
    I.date_of_birth,
    E.email,
    PN.phone,
    I.home_address,
    I.occupation,
    I.funds,
    AType.account_type,
    A.account_id,
    P.asset_id,
    P.asset_quantity,
    ASST.symbol,
    ASSTP.price_per_share,
    ASSTP.time_updated,
    T.transaction_id,
    T.transaction_time,
    T.transaction_type
FROM Investors I
JOIN Emails E on E.investor_id = I.investor_id
JOIN Phone_Numbers PN on PN.investor_id = I.investor_id
JOIN Accounts A ON I.investor_id = A.investor_id
JOIN Account_Types AType ON AType.account_type_id = A.account_type_id
JOIN Portfolios P ON A.account_id = P.account_id
JOIN Assets ASST ON P.asset_id = ASST.asset_id
JOIN Asset_Prices ASSTP ON ASSTP.asset_id = ASST.asset_id
LEFT JOIN Transactions T ON A.account_id = T.account_id;
-- Outputs
/*
Enables administrators to monitor client and broker behavior
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|   investor_id | first_name   | last_name   | date_of_birth   | email                      |      phone | home_address                           | occupation        |   funds | account_type   |   account_id |   asset_id |   asset_quantity | symbol   |   price_per_share | time_updated        |   transaction_id | transaction_time    | transaction_type   |
+===============+==============+=============+=================+============================+============+========================================+===================+=========+================+==============+============+==================+==========+===================+=====================+==================+=====================+====================+
|             1 | Paul         | Anderson    | 1982-10-23      | paul_anderson114@gmail.com | 9053349304 | 1 Stanwood Cres, Toronto, ON M9M 1Z8   | Contractor        |   20000 | TFSA           |            1 |          1 |               10 | AAPL     |           333.505 | 2024-02-06 19:17:00 |                1 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             1 | Paul         | Anderson    | 1982-10-23      | paul_anderson114@gmail.com | 9053349304 | 1 Stanwood Cres, Toronto, ON M9M 1Z8   | Contractor        |   20000 | TFSA           |            1 |          1 |               10 | AAPL     |           333.505 | 2024-02-06 19:17:00 |               11 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|            10 | Olivia       | Davis       | 1998-04-22      | olivia_davis98@gmail.com   | 9055552345 | 70 University Ave, Toronto, ON M5J 2M4 | Student           |   15000 | FHSA           |           10 |          1 |                3 | AAPL     |           333.505 | 2024-02-06 19:17:00 |               10 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             1 | Paul         | Anderson    | 1982-10-23      | paul_anderson114@gmail.com | 9053349304 | 1 Stanwood Cres, Toronto, ON M9M 1Z8   | Contractor        |   20000 | TFSA           |            1 |          2 |               30 | GOOG     |           276.433 | 2024-02-06 19:14:00 |                1 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             1 | Paul         | Anderson    | 1982-10-23      | paul_anderson114@gmail.com | 9053349304 | 1 Stanwood Cres, Toronto, ON M9M 1Z8   | Contractor        |   20000 | TFSA           |            1 |          2 |               30 | GOOG     |           276.433 | 2024-02-06 19:14:00 |               11 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             2 | Emily        | Johnson     | 1990-05-15      | emily_johnson22@gmail.com  | 4165551234 | 25 Yonge St, Toronto, ON M5E 1E5       | Software Engineer |   35000 | RRSP           |            2 |          2 |                5 | GOOG     |           276.433 | 2024-02-06 19:14:00 |                2 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             4 | Sarah        | Brown       | 1978-03-25      | sarah_brown78@gmail.com    | 9055559876 | 200 Bay St, Toronto, ON M5J 2J5        | Marketing Manager |   28000 | FHSA           |            4 |          3 |               15 | SHOP     |           169.97  | 2024-02-06 16:00:00 |                4 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             3 | Michael      | Smith       | 1985-12-10      | michael_smith89@gmail.com  | 6475556789 | 100 Queen St W, Toronto, ON M5H 2N2    | Financial Analyst |   50000 | TFSA           |            3 |          4 |                8 | MSFT     |           594.623 | 2024-02-06 19:17:00 |                3 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             5 | David        | Lee         | 1995-07-30      | david_lee95@gmail.com      | 4165554321 | 150 King St W, Toronto, ON M5H 1J9     | Data Scientist    |   42000 | RRSP           |            5 |          5 |               12 | AMZN     |           341.527 | 2024-02-06 19:17:00 |                5 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             6 | Jessica      | Taylor      | 1988-09-12      | jessica_taylor88@gmail.com | 6475558765 | 55 Bloor St W, Toronto, ON M4W 1A5     | Graphic Designer  |   31000 | RESP           |            6 |          6 |               20 | TD       |            82.86  | 2024-02-06 16:00:00 |                6 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             7 | Daniel       | Wilson      | 1980-11-20      | daniel_wilson80@gmail.com  | 9055553210 | 10 Dundas St E, Toronto, ON M5B 2G9    | Teacher           |   25000 | RESP           |            7 |          7 |                6 | TSLA     |           535.278 | 2024-02-06 19:15:00 |                7 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             8 | Laura        | Martinez    | 1992-02-18      | laura_martinez92@gmail.com | 4165556543 | 30 St. Patrick St, Toronto, ON M5T 3A3 | Nurse             |   38000 | LIRA           |            8 |          8 |                7 | META     |          1018.15  | 2024-02-06 19:01:00 |                8 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
|             9 | James        | Garcia      | 1987-06-05      | james_garcia87@gmail.com   | 6475557890 | 40 College St, Toronto, ON M5G 2J3     | Architect         |   45000 | LIRA           |            9 |          9 |               25 | BNS      |            72.89  | 2024-02-06 16:00:00 |                9 | 2024-02-06 19:00:00 | Buy                |
+---------------+--------------+-------------+-----------------+----------------------------+------------+----------------------------------------+-------------------+---------+----------------+--------------+------------+------------------+----------+-------------------+---------------------+------------------+---------------------+--------------------+
*/
USE database363;

-- Insert Investors
INSERT INTO Investors (first_name, last_name, date_of_birth, email, phone, home_address, occupation, funds)
VALUES
('Paul', 'Anderson', '1982-10-23', 'paul_anderson114@gmail.com', '9053349304', '1 Stanwood Cres, Toronto, ON M9M 1Z8', 'Contractor', 20000.0),
('Emily', 'Johnson', '1990-05-15', 'emily_johnson22@gmail.com', '4165551234', '25 Yonge St, Toronto, ON M5E 1E5', 'Software Engineer', 35000.0),
('Michael', 'Smith', '1985-12-10', 'michael_smith89@gmail.com', '6475556789', '100 Queen St W, Toronto, ON M5H 2N2', 'Financial Analyst', 50000.0),
('Sarah', 'Brown', '1978-03-25', 'sarah_brown78@gmail.com', '9055559876', '200 Bay St, Toronto, ON M5J 2J5', 'Marketing Manager', 28000.0),
('David', 'Lee', '1995-07-30', 'david_lee95@gmail.com', '4165554321', '150 King St W, Toronto, ON M5H 1J9', 'Data Scientist', 42000.0),
('Jessica', 'Taylor', '1988-09-12', 'jessica_taylor88@gmail.com', '6475558765', '55 Bloor St W, Toronto, ON M4W 1A5', 'Graphic Designer', 31000.0),
('Daniel', 'Wilson', '1980-11-20', 'daniel_wilson80@gmail.com', '9055553210', '10 Dundas St E, Toronto, ON M5B 2G9', 'Teacher', 25000.0),
('Laura', 'Martinez', '1992-02-18', 'laura_martinez92@gmail.com', '4165556543', '30 St. Patrick St, Toronto, ON M5T 3A3', 'Nurse', 38000.0),
('James', 'Garcia', '1987-06-05', 'james_garcia87@gmail.com', '6475557890', '40 College St, Toronto, ON M5G 2J3', 'Architect', 45000.0),
('Olivia', 'Davis', '1998-04-22', 'olivia_davis98@gmail.com', '9055552345', '70 University Ave, Toronto, ON M5J 2M4', 'Student', 15000.0);

-- Insert Brokers UPDATED
INSERT INTO Brokers (broker_name, account_type)
VALUES
('Wealthsimple', 'TFSA'),
('Wealthsimple', 'RRSP'),
('Wealthsimple', 'FHSA'),
('Wealthsimple', 'RRIF'),
('Wealthsimple', 'LIRA'),
('Wealthsimple', 'RESP'),
('Wealthsimple', 'Cash'),
('Wealthsimple', 'Business'),
('Questrade', 'TFSA'),
('Questrade', 'RRSP'),
('Questrade', 'FHSA'),
('Questrade', 'RESP'),
('Questrade', 'LIRA'),
('Questrade', 'Cash'),
('Questrade', 'LIF'),
('Questrade', 'RIF');

-- Insert Accounts
INSERT INTO Accounts (investor_id, broker_id)
VALUES
(1, 1),  -- Paul Anderson, Wealthsimple TFSA
(2, 2),  -- Emily Johnson, Wealthsimple RRSP
(3, 9),  -- Michael Smith, Questrade TFSA
(4, 3),  -- Sarah Brown, Wealthsimple FHSA
(5, 10), -- David Lee, Questrade RRSP
(6, 6),  -- Jessica Taylor, Wealthsimple RESP
(7, 12), -- Daniel Wilson, Questrade RESP
(8, 5),  -- Laura Martinez, Wealthsimple LIRA
(9, 13), -- James Garcia, Questrade LIRA
(10, 11); -- Olivia Davis, Questrade FHSA

-- Insert Exchanges UPDATED
INSERT INTO Exchanges (exchange_name, broker_name)
VALUES
('TSX', 'Wealthsimple'),
('TSXV', 'Wealthsimple'),
('NYSE', 'Wealthsimple'),
('NASDAQ', 'Wealthsimple'),
('NEO', 'Wealthsimple'),
('CSE', 'Wealthsimple'),
('BATS', 'Wealthsimple'),
('NYSE', 'Questrade'),
('NASDAQ', 'Questrade'),
('TSX', 'Questrade'),
('TSXV', 'Questrade'),
('CNSX', 'Questrade'),
('MX', 'Questrade'),
('NYSEAM', 'Questrade'),
('ARCA', 'Questrade'),
('OPRA', 'Questrade'),
('PinkSheets', 'Questrade'),
('OTCBB', 'Questrade');

-- Insert Assets (Prices converted to CAD)
INSERT INTO Assets (exchange_id, symbol, price_per_share, time_updated)
VALUES
(1, 'AAPL', 233.22 * 1.43, '2024-02-06 19:17:00'),  -- Apple Inc. (NYSE) in CAD
(2, 'GOOG', 193.31 * 1.43, '2024-02-06 19:14:00'),  -- Alphabet Inc. (NASDAQ) in CAD
(3, 'SHOP', 169.97, '2024-02-06 16:00:00'),   -- Shopify Inc. (TSX)
(4, 'MSFT', 415.82 * 1.43, '2024-02-06 19:17:00'),  -- Microsoft Corp. (NYSE) in CAD
(5, 'AMZN', 238.83 * 1.43, '2024-02-06 19:17:00'),  -- Amazon.com Inc. (NASDAQ) in CAD
(6, 'TD', 82.86, '2024-02-06 16:00:00'),     -- TD Bank (TSX)
(7, 'TSLA', 374.32 * 1.43, '2024-02-06 19:15:00'),  -- Tesla Inc. (NYSE) in CAD
(8, 'META', 711.99 * 1.43, '2024-02-06 19:01:00'),  -- Meta Platforms Inc. (NASDAQ) in CAD
(9, 'BNS', 72.89, '2024-02-06 16:00:00');    -- Bank of Nova Scotia (TSX)

-- Insert Portfolios
INSERT INTO Portfolios (account_id, asset_id, asset_quantity)
VALUES
(1, 1, 10),  -- Paul Anderson owns 10 shares of AAPL
(2, 2, 5),   -- Emily Johnson owns 5 shares of GOOG
(3, 4, 8),   -- Michael Smith owns 8 shares of MSFT
(4, 3, 15),  -- Sarah Brown owns 15 shares of SHOP
(5, 5, 12),  -- David Lee owns 12 shares of AMZN
(6, 6, 20),  -- Jessica Taylor owns 20 shares of TD
(7, 7, 6),   -- Daniel Wilson owns 6 shares of TSLA
(8, 8, 7),   -- Laura Martinez owns 7 shares of META
(9, 9, 25),  -- James Garcia owns 25 shares of BNS
(10, 1, 3);  -- Olivia Davis owns 3 shares of AAPL

-- Insert Transactions
INSERT INTO Transactions (account_id, asset_id, asset_quantity, transaction_time, transaction_type)
VALUES
(1, 1, 10, '2024-02-06 19:00:00', 1),  -- Paul Anderson bought 10 shares of AAPL
(2, 2, 5, '2024-02-06 19:00:00', 1),   -- Emily Johnson bought 5 shares of GOOG
(3, 4, 8, '2024-02-06 19:00:00', 1),   -- Michael Smith bought 8 shares of MSFT
(4, 3, 15, '2024-02-06 19:00:00', 1),  -- Sarah Brown bought 15 shares of SHOP
(5, 5, 12, '2024-02-06 19:00:00', 1),  -- David Lee bought 12 shares of AMZN
(6, 6, 20, '2024-02-06 19:00:00', 1),  -- Jessica Taylor bought 20 shares of TD
(7, 7, 6, '2024-02-06 19:00:00', 1),   -- Daniel Wilson bought 6 shares of TSLA
(8, 8, 7, '2024-02-06 19:00:00', 1),   -- Laura Martinez bought 7 shares of META
(9, 9, 25, '2024-02-06 19:00:00', 1),  -- James Garcia bought 25 shares of BNS
(10, 1, 3, '2024-02-06 19:00:00', 1);  -- Olivia Davis bought 3 shares of AAPL

-- Insert Watchlists
INSERT INTO Watchlists (investor_id, asset_id, target_price)
VALUES
(1, 2, 150.00),  -- Paul Anderson is watching GOOG with a target price of $150 USD
(2, 1, 180.00),  -- Emily Johnson is watching AAPL
(3, 5, 200.00),  -- Michael Smith is watching AMZN
(4, 4, 130.00),  -- Sarah Brown is watching MSFT
(5, 3, 160.00),   -- David Lee is watching SHOP
(6, 6, 82.00),   -- Jessica Taylor is watching TD
(7, 7, 355.00),  -- Daniel Wilson is watching TSLA
(8, 8, 680.00),  -- Laura Martinez is watching META
(9, 9, 71.00),   -- James Garcia is watching BNS
(10, 1, 230.00); -- Olivia Davis is watching AAPL

-- Insert Carts
INSERT INTO Carts (account_id, asset_id, asset_quantity, transaction_type)
VALUES
(1, 2, 2, 1),  -- Paul Anderson has 2 shares of GOOG in their cart (Buy)
(2, 1, 3, 1),  -- Emily Johnson has 3 shares of AAPL in their cart (Buy)
(3, 5, 1, 1),  -- Michael Smith has 1 share of AMZN in their cart (Buy)
(4, 4, 2, 1),  -- Sarah Brown has 2 shares of MSFT in their cart (Buy)
(5, 3, 5, 1),  -- David Lee has 5 shares of SHOP in their cart (Buy)
(6, 6, 10, 1), -- Jessica Taylor has 10 shares of TD in their cart (Buy)
(7, 7, 4, 1),  -- Daniel Wilson has 4 shares of TSLA in their cart (Buy)
(8, 8, 3, 1),  -- Laura Martinez has 3 shares of META in their cart (Buy)
(9, 9, 8, 1),  -- James Garcia has 8 shares of BNS in their cart (Buy)
(10, 1, 1, 1); -- Olivia Davis has 1 share of AAPL in their cart (Buy)

-- Insert Performances (Calculated based on updated asset prices and shares)
INSERT INTO Performances (account_id, initial_price, current_price, performance_date)
VALUES
-- Paul Anderson (Account 1): 10 shares of AAPL
(1, 10 * 233.22 * 1.43, 10 * 233.22 * 1.43, '2024-02-06 19:27:00'),
-- Emily Johnson (Account 2): 5 shares of GOOG
(2, 5 * 193.31 * 1.43, 5 * 193.31 * 1.43, '2024-02-06 19:27:00'),
-- Michael Smith (Account 3): 8 shares of MSFT
(3, 8 * 415.82 * 1.43, 8 * 415.82 * 1.43, '2024-02-06 19:27:00'),
-- Sarah Brown (Account 4): 15 shares of SHOP
(4, 15 * 169.97, 15 * 169.97, '2024-02-06 19:27:00'),  -- SHOP is already in CAD
-- David Lee (Account 5): 12 shares of AMZN
(5, 12 * 238.83 * 1.43, 12 * 238.83 * 1.43, '2024-02-06 19:27:00'),
-- Jessica Taylor (Account 6): 20 shares of TD
(6, 20 * 82.86, 20 * 82.86, '2024-02-06 19:27:00'),  -- TD is already in CAD
-- Daniel Wilson (Account 7): 6 shares of TSLA
(7, 6 * 374.32 * 1.43, 6 * 374.32 * 1.43, '2024-02-06 19:27:00'),
-- Laura Martinez (Account 8): 7 shares of META
(8, 7 * 711.99 * 1.43, 7 * 711.99 * 1.43, '2024-02-06 19:27:00'),
-- James Garcia (Account 9): 25 shares of BNS
(9, 25 * 72.89, 25 * 72.89, '2024-02-06 19:27:00'),  -- BNS is already in CAD
-- Olivia Davis (Account 10): 3 shares of AAPL
(10, 3 * 233.22 * 1.43, 3 * 233.22 * 1.43, '2024-02-06 19:27:00');
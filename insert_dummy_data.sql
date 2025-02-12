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
('Olivia', 'Davis', '1998-04-22', 'olivia_davis98@gmail.com', '9055552345', '70 University Ave, Toronto, ON M5J 2M4', 'Student', 15000.0),
('Vicky', 'Sekhon', '1998-09-27', 'vickyrocks@gmail.com', '9053990200', '75 University Ave, Toronto, ON M5J 2M4', 'Student', 18000.0);

-- Insert Account_Types
INSERT INTO Account_Types (account_type)
VALUES
     ('TFSA'),
     ('RRSP'),
     ('FHSA'),
     ('RRIF'),
     ('LIRA'),
     ('RESP'),
     ('Cash'),
     ('Business'),
     ('LIF'),
     ('RIF');

-- Insert Accounts
INSERT INTO Accounts (investor_id, account_type_id)
VALUES
(1, 1),  -- Paul Anderson, TFSA
(2, 2),  -- Emily Johnson, RRSP
(3, 1),  -- Michael Smith, TFSA
(4, 3),  -- Sarah Brown, FHSA
(5, 2),  -- David Lee, RRSP
(6, 6),  -- Jessica Taylor, RESP
(7, 6),  -- Daniel Wilson, RESP
(8, 5),  -- Laura Martinez, LIRA
(9, 5),  -- James Garcia, LIRA
(10, 3), -- Olivia Davis, FHSA
(11, 3); -- Vicky Sekhon, FHSA

-- Insert Exchanges
INSERT INTO Exchanges (exchange_symbol)
VALUES
('TSX'),
('TSXV'),
('NYSE'),
('NASDAQ'),
('NEO'),
('CSE'),
('BATS'),
('CNSX'),
('MX'),
('NYSEAM'),
('ARCA'),
('OPRA'),
('PinkSheets'),
('OTCBB');

-- Insert Assets (Prices in CAD)
INSERT INTO Assets (exchange_id, symbol, price_per_share, time_updated)
VALUES
(3, 'AAPL', 233.22 * 1.43, '2024-02-06 19:17:00'),  -- Apple Inc. (NYSE) in CAD
(4, 'GOOG', 193.31 * 1.43, '2024-02-06 19:14:00'),  -- Alphabet Inc. (NASDAQ) in CAD
(1, 'SHOP', 169.97, '2024-02-06 16:00:00'),   -- Shopify Inc. (TSX)
(3, 'MSFT', 415.82 * 1.43, '2024-02-06 19:17:00'),  -- Microsoft Corp. (NYSE) in CAD
(4, 'AMZN', 238.83 * 1.43, '2024-02-06 19:17:00'),  -- Amazon.com Inc. (NASDAQ) in CAD
(1, 'TD', 82.86, '2024-02-06 16:00:00'),     -- TD Bank (TSX)
(3, 'TSLA', 374.32 * 1.43, '2024-02-06 19:15:00'),  -- Tesla Inc. (NYSE) in CAD
(4, 'META', 711.99 * 1.43, '2024-02-06 19:01:00'),  -- Meta Platforms Inc. (NASDAQ) in CAD
(1, 'BNS', 72.89, '2024-02-06 16:00:00');    -- Bank of Nova Scotia (TSX)

-- Insert Portfolios
INSERT INTO Portfolios (account_id, asset_id, asset_quantity)
VALUES
(1, 1, 10),  -- Paul Anderson owns 10 shares of AAPL
(1, 2, 30),  -- Paul Anderson owns 30 shares of GOOG
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
(1, 1, 10, '2024-02-06 19:00:00', 'Buy'),  -- Paul Anderson bought 10 shares of AAPL
(2, 2, 5, '2024-02-06 19:00:00', 'Buy'),   -- Emily Johnson bought 5 shares of GOOG
(3, 4, 8, '2024-02-06 19:00:00', 'Buy'),   -- Michael Smith bought 8 shares of MSFT
(4, 3, 15, '2024-02-06 19:00:00', 'Buy'),  -- Sarah Brown bought 15 shares of SHOP
(5, 5, 12, '2024-02-06 19:00:00', 'Buy'),  -- David Lee bought 12 shares of AMZN
(6, 6, 20, '2024-02-06 19:00:00', 'Buy'),  -- Jessica Taylor bought 20 shares of TD
(7, 7, 6, '2024-02-06 19:00:00', 'Buy'),   -- Daniel Wilson bought 6 shares of TSLA
(8, 8, 7, '2024-02-06 19:00:00', 'Buy'),   -- Laura Martinez bought 7 shares of META
(9, 9, 25, '2024-02-06 19:00:00', 'Buy'),  -- James Garcia bought 25 shares of BNS
(10, 1, 3, '2024-02-06 19:00:00', 'Buy'),  -- Olivia Davis bought 3 shares of AAPL
(1, 2, 30, '2024-02-06 19:00:00', 'Buy');  -- Paul Anderson bought 30 shares of GOOG

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
(1, 2, 2, 'Buy'),  -- Paul Anderson has 2 shares of GOOG in their cart (Buy)
(2, 1, 3, 'Buy'),  -- Emily Johnson has 3 shares of AAPL in their cart (Buy)
(3, 5, 1, 'Buy'),  -- Michael Smith has 1 share of AMZN in their cart (Buy)
(4, 4, 2, 'Buy'),  -- Sarah Brown has 2 shares of MSFT in their cart (Buy)
(5, 3, 5, 'Buy'),  -- David Lee has 5 shares of SHOP in their cart (Buy)
(6, 6, 10, 'Buy'), -- Jessica Taylor has 10 shares of TD in their cart (Buy)
(7, 7, 4, 'Buy'),  -- Daniel Wilson has 4 shares of TSLA in their cart (Buy)
(8, 8, 3, 'Buy'),  -- Laura Martinez has 3 shares of META in their cart (Buy)
(9, 9, 8, 'Buy'),  -- James Garcia has 8 shares of BNS in their cart (Buy)
(10, 1, 1, 'Buy'); -- Olivia Davis has 1 share of AAPL in their cart (Buy)

-- Insert Initial_Prices
INSERT INTO Initial_Prices (account_id, initial_price)
VALUES
(1, 10 * 233.22 * 1.43),  -- Paul Anderson (Account 1): 10 shares of AAPL
(2, 5 * 193.31 * 1.43),   -- Emily Johnson (Account 2): 5 shares of GOOG
(3, 8 * 415.82 * 1.43),   -- Michael Smith (Account 3): 8 shares of MSFT
(4, 15 * 169.97),         -- Sarah Brown (Account 4): 15 shares of SHOP
(5, 12 * 238.83 * 1.43),  -- David Lee (Account 5): 12 shares of AMZN
(6, 20 * 82.86),          -- Jessica Taylor (Account 6): 20 shares of TD
(7, 6 * 374.32 * 1.43),   -- Daniel Wilson (Account 7): 6 shares of TSLA
(8, 7 * 711.99 * 1.43),   -- Laura Martinez (Account 8): 7 shares of META
(9, 25 * 72.89),          -- James Garcia (Account 9): 25 shares of BNS
(10, 3 * 233.22 * 1.43);  -- Olivia Davis (Account 10): 3 shares of AAPL

-- Insert Performances
INSERT INTO Performances (account_id, current_price, performance_date)
VALUES
(1, 10 * 233.22 * 1.43, '2024-02-06 19:27:00'),  -- Paul Anderson (Account 1): 10 shares of AAPL
(2, 5 * 193.31 * 1.43, '2024-02-06 19:27:00'),   -- Emily Johnson (Account 2): 5 shares of GOOG
(3, 8 * 415.82 * 1.43, '2024-02-06 19:27:00'),   -- Michael Smith (Account 3): 8 shares of MSFT
(4, 15 * 169.97, '2024-02-06 19:27:00'),        -- Sarah Brown (Account 4): 15 shares of SHOP
(5, 12 * 238.83 * 1.43, '2024-02-06 19:27:00'),  -- David Lee (Account 5): 12 shares of AMZN
(6, 20 * 82.86, '2024-02-06 19:27:00'),          -- Jessica Taylor (Account 6): 20 shares of TD
(7, 6 * 374.32 * 1.43, '2024-02-06 19:27:00'),   -- Daniel Wilson (Account 7): 6 shares of TSLA
(8, 7 * 711.99 * 1.43, '2024-02-06 19:27:00'),   -- Laura Martinez (Account 8): 7 shares of META
(9, 25 * 72.89, '2024-02-06 19:27:00'),          -- James Garcia (Account 9): 25 shares of BNS
(10, 3 * 233.22 * 1.43, '2024-02-06 19:27:00'),  -- Olivia Davis (Account 10): 3 shares of AAPL
(1, (10 * 233.22 * 1.43) + (30 * 193.31 * 1.43), '2024-02-06 19:27:00'),  -- Paul Anderson (Account 1): 30 shares of GOOG
(11, 0, '2024-02-11 13:41:00');
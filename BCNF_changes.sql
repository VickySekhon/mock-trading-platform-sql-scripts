/*
!Last_edited: March 26th, 2025
*/
use database363;

-- * Investors table *
-- Check results
select * from Investors;
select * from Emails;
select * from Phone_Numbers;

-- new tables
CREATE TABLE Emails (
	email VARCHAR(100) PRIMARY KEY, 
    investor_id INT NOT NULL, -- Link to the Investors table
    foreign key (investor_id) references Investors(investor_id) on delete cascade
);

INSERT INTO Emails (email, investor_id)
VALUES
('paul_anderson114@gmail.com', 1),
('emily_johnson22@gmail.com', 2),
('michael_smith89@gmail.com', 3),
('sarah_brown78@gmail.com', 4),
('david_lee95@gmail.com', 5),
('jessica_taylor88@gmail.com', 6),
('daniel_wilson80@gmail.com', 7),
('laura_martinez92@gmail.com', 8),
('james_garcia87@gmail.com', 9),
('olivia_davis98@gmail.com', 10),
('vickyrocks@gmail.com', 11);


CREATE TABLE Phone_Numbers (
	phone VARCHAR(20) PRIMARY KEY, 
    investor_id INT NOT NULL, -- Link to the Investors table
    foreign key (investor_id) references Investors(investor_id) on delete cascade
);

INSERT INTO Phone_Numbers (phone, investor_id)
VALUES
('9053349304', 1),
('4165551234', 2),
('6475556789', 3),
('9055559876', 4),
('4165554321', 5),
('6475558765', 6),
('9055553210', 7),
('4165556543', 8),
('6475557890', 9),
('9055552345', 10),
('9053990200', 11);

-- Drop old columns
alter table Investors drop column phone;
alter table Investors drop column email;



-- * Performances Table *
-- Add uniqueness to account_id and performance_date so that they can be used as a foreign key in Performance_Price
ALTER TABLE Performances ADD CONSTRAINT UNIQUE(account_id,performance_date);

-- Create table
create table Performance_Price (
    account_id INT NOT NULL, -- Account ids will repeat so that we can show historic performance
    performance_date DATETIME NOT NULL, -- Timestamp for when the performance was recorded
    current_price FLOAT NOT NULL CHECK (current_price > 0), -- Updated periodically
    PRIMARY KEY (account_id, performance_date),
    FOREIGN KEY (account_id, performance_date) REFERENCES Performances(account_id, performance_date)
);

INSERT INTO Performance_Price (account_id, performance_date, current_price)
VALUES
(1, '2024-02-06 19:27:00', 10 * 233.22 * 1.43),  -- Paul Anderson (Account 1): 10 shares of AAPL
(2, '2024-02-06 19:27:00', 5 * 193.31 * 1.43),   -- Emily Johnson (Account 2): 5 shares of GOOG
(3, '2024-02-06 19:27:00', 8 * 415.82 * 1.43),   -- Michael Smith (Account 3): 8 shares of MSFT
(4, '2024-02-06 19:27:00', 15 * 169.97),        -- Sarah Brown (Account 4): 15 shares of SHOP
(5, '2024-02-06 19:27:00', 12 * 238.83 * 1.43),  -- David Lee (Account 5): 12 shares of AMZN
(6, '2024-02-06 19:27:00', 20 * 82.86),          -- Jessica Taylor (Account 6): 20 shares of TD
(7, '2024-02-06 19:27:00', 6 * 374.32 * 1.43),   -- Daniel Wilson (Account 7): 6 shares of TSLA
(8, '2024-02-06 19:27:00', 7 * 711.99 * 1.43),   -- Laura Martinez (Account 8): 7 shares of META
(9, '2024-02-06 19:27:00', 25 * 72.89),          -- James Garcia (Account 9): 25 shares of BNS
(10,'2024-02-06 19:27:00', 3 * 233.22 * 1.43),  -- Olivia Davis (Account 10): 3 shares of AAPL
(1, '2024-03-25 11:23:00', (10 * 233.22 * 1.43) + (30 * 193.31 * 1.43));  -- Paul Anderson (Account 1): 30 shares of GOOG

-- Remove duplicate column
alter table Performances drop current_price;

select * from Performances;
select * from Performance_Price;



-- * Price_History decomposition *

-- Check output
select * from Price_History;
select * from Asset_Prices;

-- Add uniqueness to asset_id and time_updated so that they can be used as a foreign key in Asset_Prices
alter table Price_History add constraint unique(asset_id, time_updated);

-- Create and populate new table
CREATE TABLE Asset_Prices (
    asset_id INT NOT NULL,
    time_updated DATETIME NOT NULL,
    price_per_share FLOAT NOT NULL CHECK (price_per_share > 0),
    primary key (asset_id, time_updated),
    foreign key (asset_id, time_updated) references Price_History(asset_id, time_updated)
);

INSERT INTO Asset_Prices (asset_id, time_updated, price_per_share)
VALUES
(1, '2024-02-06 19:17:00', 233.22 * 1.43),  -- Apple Inc. (NYSE) in CAD
(2, '2024-02-06 19:14:00', 193.31 * 1.43),  -- Alphabet Inc. (NASDAQ) in CAD
(3, '2024-02-06 16:00:00', 169.97),   -- Shopify Inc. (TSX)
(4, '2024-02-06 19:17:00', 415.82 * 1.43),  -- Microsoft Corp. (NYSE) in CAD
(5, '2024-02-06 19:17:00', 238.83 * 1.43),  -- Amazon.com Inc. (NASDAQ) in CAD
(6, '2024-02-06 16:00:00', 82.86),     -- TD Bank (TSX)
(7, '2024-02-06 19:15:00', 374.32 * 1.43),  -- Tesla Inc. (NYSE) in CAD
(8, '2024-02-06 19:01:00', 711.99 * 1.43),  -- Meta Platforms Inc. (NASDAQ) in CAD
(9, '2024-02-06 16:00:00', 72.89);    -- Bank of Nova Scotia (TSX)

-- Remove redundnant column
alter table Price_History drop price_per_share;
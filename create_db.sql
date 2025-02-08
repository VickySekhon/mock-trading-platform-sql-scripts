CREATE DATABASE database363;

USE database363;

CREATE TABLE Investors (
    investor_id INT AUTO_INCREMENT PRIMARY KEY, -- Primary key implies that it is unique and not null
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE, 
    phone VARCHAR(20) NOT NULL UNIQUE, 
    home_address VARCHAR(255) NOT NULL,
    occupation VARCHAR(100),
    funds FLOAT NOT NULL CHECK (funds >= 0)
);

CREATE TABLE Brokers (
    broker_id INT AUTO_INCREMENT PRIMARY KEY,
    broker_name VARCHAR(25) NOT NULL,
    account_type VARCHAR(25) NOT NULL,
    UNIQUE (broker_name, account_type) -- A Broker will not have duplicate account types
);

CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    investor_id INT NOT NULL, -- The ONLY link an investor has to the rest of the system
    broker_id INT NOT NULL, -- Broker id will give this table access to broker_name and account_type, no need to store those separately
    FOREIGN KEY (investor_id) REFERENCES Investors(investor_id) ON DELETE CASCADE,
    FOREIGN KEY (broker_id) REFERENCES Brokers(broker_id) ON DELETE CASCADE
);

CREATE TABLE Assets (
    asset_id INT AUTO_INCREMENT PRIMARY KEY,
    exchange_id INT NOT NULL, -- An asset can be listed on multiple exchanges
    symbol VARCHAR(50) NOT NULL, -- The symbol is a unique identifier e.g. "AMZN"
    price_per_share FLOAT NOT NULL CHECK (price_per_share > 0),
    time_updated DATETIME NOT NULL,
    FOREIGN KEY (exchange_id) REFERENCES Exchanges(exchange_id) ON DELETE CASCADE
);

-- Doesn't have it's own id
CREATE TABLE Portfolios (
    account_id INT NOT NULL, -- One account = one portfolio < many assets
    asset_id INT NOT NULL, 
    asset_quantity FLOAT NOT NULL CHECK (asset_quantity >= 0),
    UNIQUE (account_id, asset_id), -- One account cannot have 2 of the same assets 
    PRIMARY KEY (account_id, asset_id), -- Composite primary key, more-so to create some uniqueness
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE, 
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL, -- Tells us what portfolio to update and who's funds to deduct from
    asset_id INT NOT NULL, -- Gives us the asset symbol and exchange if needed
    asset_quantity FLOAT NOT NULL,
    transaction_time DATETIME NOT NULL,
    transaction_type BOOLEAN NOT NULL, -- 1 = Buy or 0 = Sell
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

-- Doesn't have it's own id
CREATE TABLE Watchlists (
	investor_id INT NOT NULL,
    asset_id INT NOT NULL,
    target_price FLOAT NOT NULL CHECK (target_price > 0), -- Compare to Assets.price_per_share for a match
    PRIMARY KEY (investor_id, asset_id), -- An investor_id will uniquely identify a watch-list which can have multiple assets
    FOREIGN KEY (investor_id) REFERENCES Investors(investor_id) ON DELETE CASCADE,
    FOREIGN KEY (asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);

CREATE TABLE Exchanges (
    exchange_id INT AUTO_INCREMENT PRIMARY KEY, -- An exchange_id will uniquely represent an exchange and broker
    exchange_name VARCHAR(10) NOT NULL,
    broker_name VARCHAR(25) NOT NULL,
);

-- Multiple rows will have the same account_id to represent all the assets in their cart
CREATE TABLE Carts (
	account_id INT NOT NULL,
    asset_id INT NOT NULL,
    asset_quantity FLOAT NOT NULL,
    transaction_type BOOLEAN NOT NULL, -- 1 = Buy or 0 = Sell
    PRIMARY KEY(account_id, asset_id), -- One account has one cart which has many assets
    FOREIGN KEY(asset_id) REFERENCES Assets(asset_id) ON DELETE CASCADE
);


CREATE TABLE Performances (
	performance_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL, -- Account ids will repeat so that we can show historic performance
    current_price FLOAT NOT NULL CHECK (current_price > 0), -- Updated periodically
    performance_date DATETIME NOT NULL, -- Timestamp for when the performance was recorded
	FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);

CREATE TABLE Initial_Prices (
    account_id INT PRIMARY KEY, -- One row per account
    initial_price FLOAT NOT NULL CHECK (initial_price > 0),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);

-- Avoid "derived" fields
-- Prices and Accounts will be Canadian for simplicity
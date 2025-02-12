# Mock Trading Platform SQL Scripts

### This repository holds all SQL queries required to create, populate, manage, and retrieve the data in a mock trading platform.
The mock trading platform is separate and is not part of this repository

### Main Functionalities: 
Transactions, Portfolios, Performances, and Investor.funds

## Entities:
Investors
Accounts
Performances
Carts
Account Types
Exchanges
...

### Dummy Database Records:
Investor:
1
Paul
Anderson
October 23, 1982
paul_anderson114@gmail.com
905 334 9304
1 Stanwood Cres, Toronto, ON M9M 1Z8
Contractor
20000.0

Broker:
1
Wealthsimple
TFSA,
2
Wealthsimple
RRSP,
3
Wealthsimple
FHSA,
4
Wealthsimple
RESP,
5 Wealthsimple
HISA,
6
Charles Schwab
TFSA

Account:
1
1
2

Asset:
1
1 (exchange_id)
AAPL
223.22
Feb 6, 6:03 p.m

2
1 (exchange_id)
GOOG
193.31
Feb 6, 6:03 p.m

Portfolio:
1
1
5

Transactions:
1
1
1
5
Feb 6, 6:10 p.m
1 (Buy)

Watchlist:
1
2
200.00

Exchange:
1
TSX
Wealthsimple

Cart:
1
2
1
B

Performance:
1
1
1116.1
1116.1
Feb 6, 6:15 p.m



# Assignment-6 Script

## Authors
* Vicky Sekhon
* Christopher En Ooi Shen

## File structure
```assignment-6``` --
                    |
                    ---```requirements.txt```
                    |
                    ---```script.py```

## Running
1. install ```python```
2. ```pip install -r requirements.txt``` (this will install all required libraries to run this script)
3. ```venv\Scripts\activate``` (activate the virtual environment where all the dependencies live)
3. ```python script.py```

* NOTE: Our database is hosted on AWS RDS and therefore to form a connection, you will need access to our username and password credentials. Since this is a **huge** security concern, you will not be able to run the script because you will need access to a .env file with the necessary credentials. I have attached the inputs and outputs below for your reference.

## Technologies/Libraries Used
**Technologies**
* Python
* MySQL Database

**Libraries**
* Mysql.connector
* Tabulate
* Dotenv

## Test
==========================================
Mock Trading Platform Database Connection
==========================================
Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: 1

Output:
-  ---  --  -----
9  BNS  73  72.89
-  ---  --  -----

Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: 2

Output:
--------  -
 3335.05  1
11628     2
--------  -

Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: 3

Output:
--------
100.000%
--------

Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: 4

Output:
-------
$37,145
-------

Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: 5

Output:
-  -------  --------  -----
3  Michael  Smith     50000
9  James    Garcia    45000
5  David    Lee       42000
8  Laura    Martinez  38000
2  Emily    Johnson   35000
-  -------  --------  -----

Select a query to run:
1. Find all investors to send updates to for when an asset falls below their target_price
2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
3. The portfolio return for a single portfolio
4. Total amount invested across all users
5. Investors who have more funds than the average investor
'q' to quit

Your input: q
Database connection closed.

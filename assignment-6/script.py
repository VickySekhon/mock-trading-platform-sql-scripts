import mysql.connector
import os
from dotenv import load_dotenv
from tabulate import tabulate

class Queries:
     # Query 1. Find all investors to send updates to for when an asset falls below their target_price
     def query1(self):
          return """
          SELECT w.investor_id, a.symbol, w.target_price, ph.price_per_share
          FROM Watchlists w
          JOIN Assets a ON a.asset_id = w.asset_id
          JOIN Price_History ph ON ph.asset_id = a.asset_id
          WHERE ph.price_per_share <= w.target_price;
          """
          
     # Query 2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js
     def query2(self):
          return """
          SELECT DISTINCT current_price AS y,
          ROW_NUMBER() OVER (ORDER BY performance_date ASC) AS x 
          FROM Performances WHERE account_id = 1;
          """
     
     # Query 3. The portfolio return for a single portfolio
     def query3(self):
          return """
          SELECT CONCAT(FORMAT(ROUND((p.current_price / ip.initial_price) * 100, 3), 3), '%') AS portfolio_returns
          FROM Performances p
          JOIN Initial_Prices ip ON ip.account_id = p.account_id
          WHERE p.account_id = 1
          ORDER BY p.performance_date DESC
          LIMIT 1;
          """

     # Query 4. Total amount invested across all users
     def query4(self):
          return """
          SELECT CONCAT('$', FORMAT(ROUND(SUM(p.asset_quantity * ph.price_per_share), 2), '###,###.##')) 
          AS total_amount_invested_across_all_portfolios
          FROM Portfolios p
          JOIN Assets a ON p.asset_id = a.asset_id
          JOIN Price_History ph ON ph.asset_id = a.asset_id;
          """

     # Query 5. Investors who have more funds than the average investor
     def query5(self):
          return """
          SELECT investor_id, first_name, last_name, funds
          FROM Investors
          WHERE funds > (SELECT AVG(funds) FROM Investors)
          ORDER BY funds DESC;
          """

class Connection:
     def __init__(self, host, database, userName, password):
          self.host = host
          self.database = database
          self.userName = userName
          self.password = password
          self.connection = None

     def connect(self):
          try:
               self.connection = mysql.connector.connect(
                    host=self.host,
                    database=self.database,
                    user=self.userName,
                    password=self.password
               )
               if self.connection.is_connected():
                    return True
          except Error as e:
               print(f"Error connecting to MySQL database: {e}")
               return False
          return False
     
     def disconnect(self):
          if self.connection and self.connection.is_connected():
               self.connection.close()
               print("Database connection closed.")
     
     def executeQuery(self, query):
          cursor = self.connection.cursor(dictionary=True)
          cursor.execute(query)
          result = cursor.fetchall()
          cursor.close()
          return tabulate(result) if result else "No results found."

def main():
     load_dotenv()
     
     connection = Connection(
          os.getenv("DB_HOST"),
          os.getenv("DB_NAME"),
          os.getenv("DB_USER"),
          os.getenv("DB_PASSWORD")
     )

     if not connection.connect():
          return  # Exit if connection fails

     queries = Queries()
     
     menu = "Select a query to run:\n1. Find all investors to send updates to for when an asset falls below their target_price\n2. (x,y) coordinates for an investor's portfolio so that it can be plotted with Chart.js\n3. The portfolio return for a single portfolio\n4. Total amount invested across all users\n5. Investors who have more funds than the average investor\n'q' to quit"
     
     print("==========================================")
     print("Mock Trading Platform Database Connection")
     print("==========================================")
     while True:
          print(f"{menu.strip()}\n")
          action = input("Your input: ")
          if action.lower() == "q":
               connection.disconnect()
               return

          try:
               action = int(action)
          except ValueError:
               print("Invalid input. Please enter a number between 1 and 5.")
               continue

          if action == 1:
               output = connection.executeQuery(queries.query1())
          elif action == 2:
               output = connection.executeQuery(queries.query2())
          elif action == 3:
               output = connection.executeQuery(queries.query3())
          elif action == 4:
               output = connection.executeQuery(queries.query4())
          elif action == 5:
               output = connection.executeQuery(queries.query5())
          else:
               print("Invalid choice. Please select a number between 1 and 5.")
               continue

          print(f"\nOutput:\n{output}\n")

if __name__ == "__main__":
     main()

import pandas as pd

# Load the CSV file
file_path = "./csv/test.csv"
df = pd.read_csv(file_path)

# Convert DataFrame to a text-based table format
table_text = df.to_markdown(index=False, tablefmt="grid")

output_path = "./txt/output.txt"

# Open the file in write mode
with open(output_path, "w", encoding="utf-8") as f:  # Ensure correct encoding
    f.write(table_text)  # Write data to the file


print(f"Table saved to {output_path}")

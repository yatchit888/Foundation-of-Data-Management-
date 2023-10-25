import pandas as pd

# Read Excel file
xlsx = pd.ExcelFile('GBC_Superstore.xlsx')
# Get a list of sheet names
sheet_names = xlsx.sheet_names

# Iterate through each sheet and save it as a CSV file
for sheet_name in sheet_names:
    df = pd.read_excel(xlsx, sheet_name)  # Read the sheet into a DataFrame
    df.to_csv(f'{sheet_name}.csv', index=False)  # Save as a CSV file
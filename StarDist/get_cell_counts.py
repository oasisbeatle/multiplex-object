import pandas as pd
from pandasql import sqldf
from openpyxl import load_workbook

# Load the thresholds from the Excel File
wb = load_workbook("thresholds.xlsx")
ws = wb['thresholds']

# Define the threshold and average threshold dictionaries
thresholds = {}
average_thresholds = {}

# Assign the thresholds and average thresholds
for row in ws.iter_rows(min_row=2, min_col= 1, max_col=11, max_row=21):
    try:
        thresholds[key] = values
        average_thresholds[key] = [sum(values[0:5])/5, sum(values[5:])/5]
    except NameError:
        print("Variable 'key' does not exist. Initializing an empty dictionary.")
    values = []
    for cell in row:
        if type(cell.value) is str:
            key = cell.value
        else:
            values.append(cell.value)

# Close the workbook
wb.close()


# Define the celldatabases to run SQL queries on
df = pd.read_excel("ibd_cells.xlsx", sheet_name="Unfiltered")
df_control = pd.read_excel("control_cells.xlsx", sheet_name="Unfiltered")

# Load the cell counts excel file to be filled
wb = load_workbook("cell_counts.xlsx")
ws = wb['Sheet1']

# Calculate the IBD cell counts
for row in ws.iter_rows(min_row=2, min_col=1, max_col=6, max_row=49):
    cell_types = row[0].value
    try:
        cell_types = cell_types.split("+")
    except AttributeError:
        "End of Excel Sheet Reached"
        break
    if len(cell_types) == 1:
        for n, cell in enumerate(row[1:]):
            q1 = f"SELECT COUNT(*) as count FROM df WHERE Parent == '{"IBD" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n]} AND DAPI > {thresholds['DAPI'][n]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif len(cell_types) == 2:
        for n, cell in enumerate(row[1:]):
            q1 = f"SELECT COUNT(*) as count FROM df WHERE Parent == '{"IBD" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n]} AND {cell_types[1]} > {thresholds[cell_types[1]][n]} AND DAPI > {thresholds['DAPI'][n]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif len(cell_types) == 3:
        for n, cell in enumerate(row[1:]):
            q1 = f"SELECT COUNT(*) as count FROM df WHERE Parent == '{"IBD" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n]} AND {cell_types[1]} > {thresholds[cell_types[1]][n]} AND {cell_types[2]} > {thresholds[cell_types[2]][n]} AND DAPI > {thresholds['DAPI'][n]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif(len(cell_types) == 4):
        for n, cell in enumerate(row[1:]):
            q1 = f"SELECT COUNT(*) as count FROM df WHERE Parent == '{"IBD" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n]} AND {cell_types[1]} > {thresholds[cell_types[1]][n]} AND {cell_types[2]} > {thresholds[cell_types[2]][n]} AND {cell_types[3]} > {thresholds[cell_types[3]][n]} AND DAPI > {thresholds['DAPI'][n]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
      
wb.save("cell_counts.xlsx")

# Calculate the control cell counts
for row in ws.iter_rows(min_row=2, min_col=1, max_col=11, max_row=49):
    cell_types = row[0].value
    try:
        cell_types = cell_types.split("+")
    except AttributeError:
        print("End of Excel Sheet Reached")
        break
    if len(cell_types) == 1:
        for n, cell in enumerate(row[6:]):
            q1 = f"SELECT COUNT(*) as count FROM df_control WHERE Parent == '{"CONTROL" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n + 5]} AND DAPI > {thresholds['DAPI'][n + 5]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif len(cell_types) == 2:
        for n, cell in enumerate(row[6:]):
            q1 = f"SELECT COUNT(*) as count FROM df_control WHERE Parent == '{"CONTROL" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n + 5]} AND {cell_types[1]} > {thresholds[cell_types[1]][n + 5]} AND DAPI > {thresholds['DAPI'][n + 5]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif len(cell_types) == 3:
        for n, cell in enumerate(row[6:]):
            q1 = f"SELECT COUNT(*) as count FROM df_control WHERE Parent == '{"CONTROL" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n + 5]} AND {cell_types[1]} > {thresholds[cell_types[1]][n + 5]} AND {cell_types[2]} > {thresholds[cell_types[2]][n + 5]} AND DAPI > {thresholds['DAPI'][n + 5]}"
            result = sqldf(q1)
            cell.value = result['count'][0]
    elif(len(cell_types) == 4):
        for n, cell in enumerate(row[6:]):
            q1 = f"SELECT COUNT(*) as count FROM df_control WHERE Parent == '{"CONTROL" + str(n + 1)}' AND {cell_types[0]} > {thresholds[cell_types[0]][n + 5]} AND {cell_types[1]} > {thresholds[cell_types[1]][n + 5]} AND {cell_types[2]} > {thresholds[cell_types[2]][n + 5]} AND {cell_types[3]} > {thresholds[cell_types[3]][n + 5]} AND DAPI > {thresholds['DAPI'][n + 5]}"
            result = sqldf(q1)
            cell.value = result['count'][0]

# Save and close the updated workbook
wb.save("cell_counts.xlsx")
wb.close()

# Save the file as CSV for further processing in R or Python Scripts
df_counts = pd.read_excel("cell_counts.xlsx", sheet_name="Sheet1")
df_counts.to_csv("cell_counts.csv", index=False)


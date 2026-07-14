import pandas as pd
import numpy as np
from datetime import datetime

# Reproducible random numbers
np.random.seed(42)
departments = pd.DataFrame({
    "DepartmentID": [
        "D001","D002","D003","D004",
        "D005","D006","D007","D008"
    ],
    "DepartmentName": [
        "Sales",
        "Marketing",
        "Finance",
        "Human Resources",
        "Operations",
        "Information Technology",
        "Customer Support",
        "Research & Development"
    ],
    "DepartmentHead": [
        "Daniel Johnson",
        "Sophia Williams",
        "Michael Brown",
        "Emma Davis",
        "James Wilson",
        "David Miller",
        "Olivia Moore",
        "Ethan Taylor"
    ],
    "EmployeeCount": [
        82,34,25,18,
        96,41,57,29
    ],
    "Location": [
        "Lagos",
        "Lagos",
        "Lagos",
        "Lagos",
        "Abuja",
        "Lagos",
        "Abuja",
        "Port Harcourt"
    ]
})
departments.to_csv(
    "Data/Raw Data/departments.csv",
    index=False
)

departments.to_excel(
    "Data/Raw Data/departments.xlsx",
    index=False
)

print("Departments created successfully!")

# ==========================
# Generate Calendar
# ==========================

calendar = pd.date_range(
    start="2023-01-01",
    end="2025-12-01",
    freq="MS"
)

calendar_df = pd.DataFrame({
    "Date": calendar,
    "Year": calendar.year,
    "Quarter": "Q" + calendar.quarter.astype(str),
    "MonthNumber": calendar.month,
    "MonthName": calendar.strftime("%B")
})
calendar_df.to_csv(
    "Data/Raw Data/calendar.csv",
    index=False
)

calendar_df.to_excel(
    "Data/Raw Data/calendar.xlsx",
    index=False
)

print("Calendar created successfully!")
# ==========================
# Generate Revenue
# ==========================

revenue_ranges = {
    "D001": (45000000, 70000000),  # Sales
    "D002": (8000000, 18000000),   # Marketing
    "D003": (5000000, 10000000),   # Finance
    "D004": (1000000, 3000000),    # HR
    "D005": (25000000, 45000000),  # Operations
    "D006": (6000000, 12000000),   # IT
    "D007": (4000000, 9000000),    # Customer Support
    "D008": (3000000, 8000000)     # R&D
}

revenue_sources = {
    "D001": "Product Sales",
    "D002": "Marketing Services",
    "D003": "Financial Services",
    "D004": "Internal Services",
    "D005": "Operations Revenue",
    "D006": "Technology Services",
    "D007": "Customer Services",
    "D008": "Research Contracts"
}
revenue_data = []

record = 1

for date in calendar_df["Date"]:

    year = date.year

    if year == 2023:
        growth = 1.00
    elif year == 2024:
        growth = 1.10
    else:
        growth = 1.22

    month = date.month

    if month in [11, 12]:
        season = 1.20
    elif month in [6, 9]:
        season = 1.10
    elif month == 1:
        season = 0.90
    else:
        season = 1.00

    for dept in revenue_ranges:

        low, high = revenue_ranges[dept]

        revenue = np.random.randint(low, high)

        revenue = int(revenue * growth * season)

        revenue_data.append([
            f"REV{record:04}",
            date,
            dept,
            revenue,
            revenue_sources[dept]
        ])

        record += 1
        revenue_df = pd.DataFrame(
    revenue_data,
    columns=[
        "RevenueID",
        "Date",
        "DepartmentID",
        "RevenueAmount",
        "RevenueSource"
    ]
)
        revenue_df.to_csv(
    "Data/Raw Data/revenue.csv",
    index=False
)

revenue_df.to_excel(
    "Data/Raw Data/revenue.xlsx",
    index=False
)

print("Revenue created successfully!")

# ==========================
# Generate Expense Categories
# ==========================

expense_categories = pd.DataFrame({
    "ExpenseCategoryID": [
        "EC001",
        "EC002",
        "EC003",
        "EC004",
        "EC005",
        "EC006",
        "EC007",
        "EC008"
    ],
    "ExpenseCategory": [
        "Salaries",
        "Marketing",
        "Utilities",
        "Office Supplies",
        "Rent",
        "Travel",
        "Software",
        "Maintenance"
    ]
})
expense_categories.to_csv(
    "Data/Raw Data/expense_categories.csv",
    index=False
)

expense_categories.to_excel(
    "Data/Raw Data/expense_categories.xlsx",
    index=False
)

print("Expense Categories created successfully!")
# ==========================
# Generate Expenses
# ==========================

expense_ranges = {
    "D001": (18000000, 28000000),   # Sales
    "D002": (4000000, 9000000),     # Marketing
    "D003": (3000000, 7000000),     # Finance
    "D004": (800000, 2500000),      # HR
    "D005": (12000000, 22000000),   # Operations
    "D006": (3500000, 8000000),     # IT
    "D007": (2500000, 6000000),     # Customer Support
    "D008": (2000000, 5000000)      # R&D
}
expense_data = []

expense_record = 1

expense_ids = expense_categories["ExpenseCategoryID"].tolist()

for date in calendar_df["Date"]:

    month = date.month

    if month in [11, 12]:
        seasonal_factor = 1.10
    elif month == 1:
        seasonal_factor = 0.95
    else:
        seasonal_factor = 1.00

    for dept in expense_ranges:

        low, high = expense_ranges[dept]

        expense = np.random.randint(low, high)

        expense = int(expense * seasonal_factor)

        category = np.random.choice(expense_ids)

        expense_data.append([
            f"EXP{expense_record:04}",
            date,
            dept,
            category,
            expense
        ])

        expense_record += 1
        expenses_df = pd.DataFrame(
    expense_data,
    columns=[
        "ExpenseID",
        "Date",
        "DepartmentID",
        "ExpenseCategoryID",
        "ExpenseAmount"
    ]
)
        expenses_df.to_csv(
    "Data/Raw Data/expenses.csv",
    index=False
)

expenses_df.to_excel(
    "Data/Raw Data/expenses.xlsx",
    index=False
)

print("Expenses created successfully!")
# ==========================
# Generate Budget
# ==========================

budget_ranges = {
    "D001": (22000000, 30000000),
    "D002": (5000000, 9000000),
    "D003": (3500000, 7000000),
    "D004": (1000000, 2500000),
    "D005": (15000000, 24000000),
    "D006": (4000000, 8500000),
    "D007": (3000000, 6500000),
    "D008": (2500000, 6000000)
}
budget_data = []

budget_record = 1

for date in calendar_df["Date"]:

    for dept in budget_ranges:

        low, high = budget_ranges[dept]

        budget = np.random.randint(low, high)

        budget_data.append([
            f"BUD{budget_record:04}",
            date,
            dept,
            budget
        ])

        budget_record += 1
        budget_df = pd.DataFrame(
    budget_data,
    columns=[
        "BudgetID",
        "Date",
        "DepartmentID",
        "BudgetAmount"
    ]
)
        budget_df.to_csv(
    "Data/Raw Data/budget.csv",
    index=False
)

budget_df.to_excel(
    "Data/Raw Data/budget.xlsx",
    index=False
)

print("Budget created successfully!")
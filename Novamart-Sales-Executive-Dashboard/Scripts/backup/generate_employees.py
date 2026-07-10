# ============================================================
# SALES REVENUE ANALYTICS PROJECT
# Employee Data Generator
# ============================================================


# ============================================================
# IMPORTS
# ============================================================

import random
import pandas as pd
import os
from datetime import datetime, timedelta


# ============================================================
# PROJECT PATHS
# ============================================================

script_dir = os.path.dirname(__file__)
raw_data_folder = os.path.join(script_dir, "..", "Data", "Raw Data")


# ============================================================
# CONFIGURATION
# ============================================================

employee_count = 30


# Hire date range
start_date = datetime(2018, 1, 1)
end_date = datetime(2025, 12, 31)
# ============================================================
# LOOKUP LISTS
# ============================================================

# Male First Names
male_names = [
    "Chinedu",
    "Emeka",
    "Ibrahim",
    "David",
    "Samuel",
    "Tunde"
]

# Female First Names
female_names = [
    "Aisha",
    "Blessing",
    "Mary",
    "Esther"
]

# Last Names
last_names = [
    "Okafor",
    "Bello",
    "Adeyemi",
    "Eze",
    "Ojo",
    "Adebayo",
    "Mohammed",
    "Nwosu",
    "Ibrahim",
    "Ogunleye"
]

# Gender Options
genders = [
    "Male",
    "Female"
]

# Departments
departments = [
    "Sales",
    "Marketing",
    "Finance",
    "Human Resources",
    "Operations",
    "IT"
]

# Job Titles by Department
job_titles = {
    "Sales": [
        "Sales Associate",
        "Senior Sales Associate",
        "Store Manager"
    ],
    "Marketing": [
        "Marketing Executive",
        "Digital Marketing Specialist"
    ],
    "Finance": [
        "Accountant",
        "Finance Analyst"
    ],
    "Human Resources": [
        "HR Officer",
        "Recruiter"
    ],
    "Operations": [
        "Operations Officer",
        "Inventory Coordinator"
    ],
    "IT": [
        "IT Support Specialist",
        "Systems Administrator"
    ]
}


# ============================================================
# EMPLOYEE GENERATION
# ============================================================

employees = []

for i in range(employee_count):

    # Select Gender
    gender = random.choice(genders)

    # Select First Name Based on Gender
    if gender == "Male":
        random_name = random.choice(male_names)
    else:
        random_name = random.choice(female_names)

    # Select Other Employee Information
    random_surname = random.choice(last_names)
    department = random.choice(departments)
    job_title = random.choice(job_titles[department])
   
    random_days = random.randint(0, (end_date - start_date).days)
    hire_date = start_date + timedelta(days=random_days)
    hire_date = hire_date.strftime("%Y-%m-%d")

    # Create Employee Record
    employee = {
    "EmployeeID": i + 1,
    "FirstName": random_name,
    "LastName": random_surname,
    "Gender": gender,
    "Department": department,
    "JobTitle": job_title,
    "HireDate": hire_date
}

    employees.append(employee)


# ============================================================
# CREATE DATAFRAME
# ============================================================

df = pd.DataFrame(employees)


# ============================================================
# DISPLAY DATA
# ============================================================

print(df)


# ============================================================
# EXPORT FILES
# ============================================================

# Excel
excel_file = os.path.join(raw_data_folder, "employees.xlsx")
df.to_excel(excel_file, index=False)

# CSV
csv_file = os.path.join(raw_data_folder, "employees.csv")
df.to_csv(csv_file, index=False)


# ============================================================
# SUCCESS MESSAGE
# ============================================================

print("\n===================================")
print("Employee files created successfully!")
print("===================================")
print(f"Excel : {excel_file}")
print(f"CSV   : {csv_file}")
import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_EMPLOYEES
from helpers import save_files, random_date

male_names = ["Chinedu", "Emeka", "Ibrahim", "David", "Samuel", "Tunde"]
female_names = ["Aisha", "Blessing", "Mary", "Esther"]
last_names = ["Okafor", "Bello", "Adeyemi", "Eze", "Ojo", "Adebayo"]

departments = ["Sales", "Marketing", "Finance", "HR", "Operations", "IT"]

job_titles = {
    "Sales": ["Sales Associate", "Senior Sales Associate"],
    "Marketing": ["Marketing Executive", "Digital Marketing Specialist"],
    "Finance": ["Accountant", "Finance Analyst"],
    "HR": ["HR Officer", "Recruiter"],
    "Operations": ["Operations Officer", "Inventory Coordinator"],
    "IT": ["IT Support Specialist", "Systems Admin"]
}

employees = []

for i in range(NUM_EMPLOYEES):

    gender = random.choice(["Male", "Female"])

    first_name = random.choice(male_names if gender == "Male" else female_names)
    last_name = random.choice(last_names)
    department = random.choice(departments)

    employees.append({
        "EmployeeID": i + 1,
        "FirstName": first_name,
        "LastName": last_name,
        "Gender": gender,
        "Department": department,
        "JobTitle": random.choice(job_titles[department]),
        "HireDate": random_date(2018, 2024),
        "Salary": random.randint(80000, 500000),
        "Email": f"{first_name.lower()}.{last_name.lower()}{i}@company.com",
        "PhoneNumber": f"080{random.randint(10000000,99999999)}",
        "EmploymentStatus": "Active",
        "StoreID": random.randint(1, 10)
    })

df = pd.DataFrame(employees)

save_files(df, "employees", RAW_DATA_FOLDER)
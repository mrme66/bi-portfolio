import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_CUSTOMERS
from helpers import save_files, random_date

first_names = ["John", "Mary", "James", "Aisha", "David", "Sarah"]
last_names = ["Okafor", "Bello", "Eze", "Adebayo", "Ojo"]

customers = []

for i in range(NUM_CUSTOMERS):

    first = random.choice(first_names)
    last = random.choice(last_names)

    customers.append({
        "CustomerID": i + 1,
        "FirstName": first,
        "LastName": last,
        "Gender": random.choice(["Male", "Female"]),
        "Email": f"{first.lower()}{i}@mail.com",
        "PhoneNumber": f"080{random.randint(10000000,99999999)}",
        "City": random.choice(["Lagos", "Abuja", "Ibadan", "Port Harcourt"]),
        "State": random.choice(["Lagos", "FCT", "Oyo", "Rivers"]),
        "RegistrationDate": random_date(2020, 2024),
        "LoyaltyLevel": random.choice(["Bronze", "Silver", "Gold", "Platinum"]),
        "IsSubscribed": random.choice([True, False])
    })

df = pd.DataFrame(customers)

save_files(df, "customers", RAW_DATA_FOLDER)
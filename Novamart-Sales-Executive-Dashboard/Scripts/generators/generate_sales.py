import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_SALES
from helpers import save_files, random_date

payment_methods = ["Cash", "Card", "Transfer", "POS", "Online"]

sales = []

for i in range(NUM_SALES):

    sales.append({
        "SaleID": i + 1,
        "CustomerID": random.randint(1, 500),
        "EmployeeID": random.randint(1, 30),
        "StoreID": random.randint(1, 10),
        "SaleDate": random_date(2023, 2025),
        "PaymentMethod": random.choice(payment_methods),
        "TotalAmount": round(random.uniform(500, 50000), 2),
        "TransactionStatus": random.choice(["Completed", "Cancelled", "Pending"])
    })

df = pd.DataFrame(sales)

save_files(df, "sales", RAW_DATA_FOLDER)
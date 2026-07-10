import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_SUPPLIERS
from helpers import save_files

companies = [
    "Dangote",
    "Nestle",
    "Unilever",
    "PZ",
    "Indomie",
    "Honeywell",
    "Promasidor",
    "Chi",
    "Cadbury",
    "Peak"
]

cities = [
    "Lagos",
    "Abuja",
    "Ibadan",
    "Port Harcourt",
    "Benin",
    "Kano"
]

suppliers = []

for i in range(NUM_SUPPLIERS):

    company = random.choice(companies)

    suppliers.append({

        "SupplierID": i + 1,

        "SupplierName": f"{company} Supplier {i+1}",

        "ContactEmail": f"supplier{i+1}@gmail.com",

        "PhoneNumber": f"080{random.randint(10000000,99999999)}"

    })

df = pd.DataFrame(suppliers)

save_files(df, "suppliers", RAW_DATA_FOLDER)
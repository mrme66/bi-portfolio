import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_PRODUCTS
from helpers import save_files, random_date

inventory = []

for product_id in range(1, NUM_PRODUCTS + 1):

    for store_id in range(1, 11):

        inventory.append({
            "InventoryID": len(inventory) + 1,
            "StoreID": store_id,
            "ProductID": product_id,
            "Quantity": random.randint(0, 200),
            "LastUpdated": random_date(2024, 2025)
        })

df = pd.DataFrame(inventory)

save_files(df, "inventory", RAW_DATA_FOLDER)
import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_SALES
from helpers import save_files

orderdetails = []

order_id = 1

for sale_id in range(1, NUM_SALES + 1):

    num_items = random.randint(1, 5)

    for _ in range(num_items):

        quantity = random.randint(1, 5)
        unit_price = round(random.uniform(100, 10000), 2)
        discount = round(random.uniform(0, 500), 2)

        orderdetails.append({
            "OrderDetailID": order_id,
            "SaleID": sale_id,
            "ProductID": random.randint(1, 300),
            "Quantity": quantity,
            "UnitPrice": unit_price,
            "Discount": discount,
            "LineTotal": round((quantity * unit_price) - discount, 2)
        })

        order_id += 1

df = pd.DataFrame(orderdetails)

save_files(df, "orderdetails", RAW_DATA_FOLDER)
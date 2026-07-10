import sys
import random
from pathlib import Path

import pandas as pd

sys.path.append(str(Path(__file__).resolve().parent.parent))

from config import RAW_DATA_FOLDER, NUM_PRODUCTS
from helpers import save_files, random_date
from product_catalog import PRODUCT_CATALOG


products = []

SKU_PREFIX = {
    1: "GRO",
    2: "BEV",
    3: "PER",
    4: "HOM",
    5: "SNK",
    6: "FRZ",
    7: "DAI",
    8: "BAK"
}

PERISHABLE_CATEGORIES = {1, 2, 5, 6, 7, 8}

SUPPLIER_MAP = {
    "Mama Gold": 1,
    "Royal Stallion": 2,
    "Golden Penny": 3,
    "Honeywell": 4,
    "Dangote": 5,
    "Power Oil": 6,
    "Devon Kings": 7,
    "Indomie": 8,
    "Coca-Cola": 9,
    "Pepsi": 10,
    "Nestle": 11,
    "Peak": 12,
    "Cowbell": 13,
    "Three Crowns": 14,
    "Dano": 15,
    "NovaMart Bakery": 16,
    "NovaMart Fresh": 17
}

DEFAULT_SUPPLIER = 40


# Flatten the catalog into one list
catalog = []

for category_id, items in PRODUCT_CATALOG.items():
    for product_name, brand in items:
        catalog.append({
            "CategoryID": category_id,
            "ProductName": product_name,
            "Brand": brand
        })


# Duplicate products with realistic pack variations until we reach NUM_PRODUCTS
sizes = [
    "",
    "Small",
    "Large",
    "500g",
    "1kg",
    "2kg",
    "5kg"
]

expanded_catalog = []

for item in catalog:

    for size in sizes:

        product = item.copy()

        if size != "":
            product["ProductName"] = f"{product['ProductName']} {size}"

        expanded_catalog.append(product)


expanded_catalog = expanded_catalog[:NUM_PRODUCTS]


for i, product in enumerate(expanded_catalog, start=1):

    category = product["CategoryID"]

    brand = product["Brand"]

    cost_price = round(random.uniform(200, 4500), 2)

    markup = random.uniform(0.20, 0.45)

    unit_price = round(cost_price * (1 + markup), 2)

    supplier = SUPPLIER_MAP.get(brand, DEFAULT_SUPPLIER)

    perishable = category in PERISHABLE_CATEGORIES

    products.append({

    "ProductID": i,

    "ProductName": product["ProductName"],

    "CategoryID": category,

    "Brand": brand,

    "UnitPrice": unit_price,

    "CostPrice": cost_price,

    "SupplierID": supplier,

    "Status": "Active",

    "ManufactureDate": random_date(2023, 2025),

    "ExpiryDate": random_date(2026, 2028) if perishable else None,

    "IsPerishable": perishable,

    "Barcode": str(random.randint(100000000000, 999999999999)),

    "SKU": f"{SKU_PREFIX[category]}-{i:04d}"

})


df = pd.DataFrame(products)

save_files(df, "products", RAW_DATA_FOLDER)
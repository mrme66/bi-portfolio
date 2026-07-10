import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import pandas as pd

from config import RAW_DATA_FOLDER
from helpers import save_files

categories = [
    {
        "CategoryID": 1,
        "CategoryName": "Groceries",
        "Description": "Everyday food and household essentials"
    },
    {
        "CategoryID": 2,
        "CategoryName": "Beverages",
        "Description": "Soft drinks, water and juices"
    },
    {
        "CategoryID": 3,
        "CategoryName": "Personal Care",
        "Description": "Body care and hygiene products"
    },
    {
        "CategoryID": 4,
        "CategoryName": "Home Care",
        "Description": "Cleaning supplies"
    },
    {
        "CategoryID": 5,
        "CategoryName": "Snacks",
        "Description": "Biscuits, sweets and chips"
    },
    {
        "CategoryID": 6,
        "CategoryName": "Frozen Foods",
        "Description": "Frozen meat and vegetables"
    },
    {
        "CategoryID": 7,
        "CategoryName": "Dairy",
        "Description": "Milk, yoghurt and cheese"
    },
    {
        "CategoryID": 8,
        "CategoryName": "Bakery",
        "Description": "Bread and pastries"
    }
]

df = pd.DataFrame(categories)

save_files(df, "categories", RAW_DATA_FOLDER)
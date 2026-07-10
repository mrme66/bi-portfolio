import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parent.parent))
import random
import pandas as pd

from config import RAW_DATA_FOLDER, NUM_STORES
from helpers import save_files, random_date

cities = [
    ("Lagos","Lagos","South West"),
    ("Ibadan","Oyo","South West"),
    ("Akure","Ondo","South West"),
    ("Abuja","FCT","North Central"),
    ("Benin","Edo","South South"),
    ("Port Harcourt","Rivers","South South"),
    ("Enugu","Enugu","South East"),
    ("Owerri","Imo","South East"),
    ("Kano","Kano","North West"),
    ("Kaduna","Kaduna","North West")
]

stores=[]

for i in range(NUM_STORES):

    city,state,region = cities[i]

    stores.append({

        "StoreID":i+1,

        "StoreName":f"{city} Store",

        "City":city,

        "State":state,

        "Region":region,

        "OpeningDate":random_date(2016,2023),

        "ManagerEmployeeID":None

    })

df=pd.DataFrame(stores)

save_files(df,"stores",RAW_DATA_FOLDER)
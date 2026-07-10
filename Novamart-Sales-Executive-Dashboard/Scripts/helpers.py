import random
import pandas as pd

from pathlib import Path


def save_files(df, file_name, output_folder):
    """
    Saves a dataframe as both Excel and CSV.
    """

    excel_path = output_folder / f"{file_name}.xlsx"
    csv_path = output_folder / f"{file_name}.csv"

    df.to_excel(excel_path, index=False)
    df.to_csv(csv_path, index=False)

    print(f"\n✅ {file_name} saved successfully!")
    print(excel_path)
    print(csv_path)


def random_date(start_year=2020, end_year=2025):
    """
    Returns a random date between two years.
    """

    year = random.randint(start_year, end_year)
    month = random.randint(1, 12)

    if month == 2:
        day = random.randint(1, 28)

    elif month in [4, 6, 9, 11]:
        day = random.randint(1, 30)

    else:
        day = random.randint(1, 31)

    return pd.Timestamp(year, month, day)
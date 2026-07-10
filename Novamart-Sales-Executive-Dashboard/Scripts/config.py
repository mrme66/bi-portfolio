from pathlib import Path

# ==========================================
# PROJECT PATHS
# ==========================================

PROJECT_ROOT = Path(__file__).resolve().parent.parent

DATA_FOLDER = PROJECT_ROOT / "Data"
RAW_DATA_FOLDER = DATA_FOLDER / "Raw Data"
PROCESSED_DATA_FOLDER = DATA_FOLDER / "Processed Data"

# ==========================================
# NUMBER OF RECORDS
# ==========================================

NUM_EMPLOYEES = 30
NUM_STORES = 10
NUM_CUSTOMERS = 500
NUM_PRODUCTS = 300
NUM_SALES = 5000
NUM_SUPPLIERS = 40

# ==========================================
# RANDOM SEED
# ==========================================

RANDOM_SEED = 42
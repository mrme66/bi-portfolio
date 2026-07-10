print("=" * 50)
print("RETAIL BI DATA GENERATION")
print("=" * 50)

print("\nStarting data generation...\n")

# Import generators
from generators import generate_categories
from generators import generate_suppliers
from generators import generate_stores
from generators import generate_employees
from generators import generate_customers
from generators import generate_products
from generators import generate_sales
from generators import generate_orderdetails
from generators import generate_inventory

print("\n")
print("=" * 50)
print("ALL DATA GENERATED SUCCESSFULLY!")
print("=" * 50)
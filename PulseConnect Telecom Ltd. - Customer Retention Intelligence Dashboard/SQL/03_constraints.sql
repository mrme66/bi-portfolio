-- ==========================================================
-- FOREIGN KEY CONSTRAINTS
-- ==========================================================

ALTER TABLE Customers
ADD CONSTRAINT fk_customers_region
FOREIGN KEY (RegionID)
REFERENCES Regions(RegionID);

ALTER TABLE Customers
ADD CONSTRAINT fk_customers_subscription
FOREIGN KEY (SubscriptionID)
REFERENCES SubscriptionPlans(SubscriptionID);

ALTER TABLE Transactions
ADD CONSTRAINT fk_transactions_customer
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID);

ALTER TABLE Transactions
ADD CONSTRAINT fk_transactions_calendar
FOREIGN KEY (BillingMonth)
REFERENCES Calendar(BillingMonth);
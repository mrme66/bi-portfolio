-- ==========================================================
-- INDEXES
-- PulseConnect Telecom Ltd.
-- ==========================================================

CREATE INDEX idx_customers_customerid
ON Customers(CustomerID);

CREATE INDEX idx_customers_subscription
ON Customers(SubscriptionID);

CREATE INDEX idx_calendar_billingmonth
ON Calendar(BillingMonth);
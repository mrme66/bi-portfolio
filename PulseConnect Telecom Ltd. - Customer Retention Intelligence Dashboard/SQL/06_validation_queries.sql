-- ==========================================================
-- PulseConnect Telecom Ltd.
-- Data Validation Queries
-- Author: Martins Oriabure
-- Purpose:
-- Verify data integrity before analysis and dashboard creation.
-- ==========================================================

------------------------------------------------------------
-- 1. Total Customers
------------------------------------------------------------

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

------------------------------------------------------------
-- 2. Total Transactions
------------------------------------------------------------

SELECT COUNT(*) AS TotalTransactions
FROM Transactions;

------------------------------------------------------------
-- 3. Total Regions
------------------------------------------------------------

SELECT COUNT(*) AS TotalRegions
FROM Regions;

------------------------------------------------------------
-- 4. Total Subscription Plans
------------------------------------------------------------

SELECT COUNT(*) AS TotalPlans
FROM SubscriptionPlans;

------------------------------------------------------------
-- 5. Total Calendar Records
------------------------------------------------------------

SELECT COUNT(*) AS TotalCalendarRecords
FROM Calendar;

------------------------------------------------------------
-- 6. Payment Status Distribution
------------------------------------------------------------

SELECT
    PaymentStatus,
    COUNT(*) AS Transactions
FROM Transactions
GROUP BY PaymentStatus
ORDER BY Transactions DESC;

------------------------------------------------------------
-- 7. Revenue Validation
------------------------------------------------------------

SELECT
    SUM(Amount) AS GrossRevenue,
    SUM(Discount) AS TotalDiscount,
    SUM(Tax) AS TotalTax,
    SUM(NetAmount) AS NetRevenue
FROM Transactions;

------------------------------------------------------------
-- 8. Missing Customer IDs
------------------------------------------------------------

SELECT *
FROM Transactions
WHERE CustomerID IS NULL;

------------------------------------------------------------
-- 9. Missing Billing Dates
------------------------------------------------------------

SELECT *
FROM Transactions
WHERE BillingMonth IS NULL;

------------------------------------------------------------
-- 10. Duplicate Transaction IDs
------------------------------------------------------------

SELECT
    TransactionID,
    COUNT(*)
FROM Transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;

------------------------------------------------------------
-- 11. Customers Without Transactions
------------------------------------------------------------

SELECT COUNT(*) AS CustomersWithoutTransactions
FROM Customers c
LEFT JOIN Transactions t
ON c.CustomerID = t.CustomerID
WHERE t.CustomerID IS NULL;

------------------------------------------------------------
-- 12. Revenue by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    SUM(t.NetAmount) AS Revenue
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 13. Revenue by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    SUM(t.NetAmount) AS Revenue
FROM Transactions t
JOIN Customers c
ON t.CustomerID = c.CustomerID
JOIN Regions r
ON c.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 14. Monthly Revenue Trend
------------------------------------------------------------

SELECT
    BillingMonth,
    SUM(NetAmount) AS Revenue
FROM Transactions
GROUP BY BillingMonth
ORDER BY BillingMonth;
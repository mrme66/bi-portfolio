-- ==========================================================
-- SECTION 2 : CUSTOMER ANALYSIS
-- ==========================================================

------------------------------------------------------------
-- Customer Status Distribution
------------------------------------------------------------

SELECT
    CustomerStatus,
    COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY CustomerStatus
ORDER BY TotalCustomers DESC;

------------------------------------------------------------
-- Customers by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(c.CustomerID) AS TotalCustomers
FROM Customers c
JOIN Regions r
ON c.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY TotalCustomers DESC;

------------------------------------------------------------
-- Customers by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(c.CustomerID) AS TotalCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY TotalCustomers DESC;

------------------------------------------------------------
-- Customers Added Per Year
------------------------------------------------------------

SELECT
    EXTRACT(YEAR FROM JoinDate) AS JoinYear,
    COUNT(*) AS CustomersJoined
FROM Customers
GROUP BY JoinYear
ORDER BY JoinYear;

------------------------------------------------------------
-- Customers Added Per Month
------------------------------------------------------------

SELECT
    DATE_TRUNC('month', JoinDate) AS Month,
    COUNT(*) AS CustomersJoined
FROM Customers
GROUP BY Month
ORDER BY Month;

------------------------------------------------------------
-- Active Customers by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(*) AS ActiveCustomers
FROM Customers c
JOIN Regions r
ON c.RegionID = r.RegionID
WHERE CustomerStatus='Active'
GROUP BY r.RegionName
ORDER BY ActiveCustomers DESC;

------------------------------------------------------------
-- Churned Customers by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(*) AS ChurnedCustomers
FROM Customers c
JOIN Regions r
ON c.RegionID = r.RegionID
WHERE CustomerStatus='Churned'
GROUP BY r.RegionName
ORDER BY ChurnedCustomers DESC;

------------------------------------------------------------
-- Suspended Customers by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(*) AS SuspendedCustomers
FROM Customers c
JOIN Regions r
ON c.RegionID = r.RegionID
WHERE CustomerStatus='Suspended'
GROUP BY r.RegionName
ORDER BY SuspendedCustomers DESC;

-- ==========================================================
-- SECTION 3 : REVENUE ANALYSIS
-- ==========================================================

------------------------------------------------------------
-- Monthly Revenue Trend
------------------------------------------------------------

SELECT
    c.BillingMonth,
    SUM(t.NetAmount) AS Revenue
FROM Transactions t
JOIN Calendar c
ON t.BillingMonth = c.BillingMonth
GROUP BY c.BillingMonth
ORDER BY c.BillingMonth;

------------------------------------------------------------
-- Quarterly Revenue
------------------------------------------------------------

SELECT
    c.Year,
    c.Quarter,
    SUM(t.NetAmount) AS Revenue
FROM Transactions t
JOIN Calendar c
ON t.BillingMonth = c.BillingMonth
GROUP BY c.Year, c.Quarter
ORDER BY c.Year, c.Quarter;

------------------------------------------------------------
-- Yearly Revenue
------------------------------------------------------------

SELECT
    c.Year,
    SUM(t.NetAmount) AS Revenue
FROM Transactions t
JOIN Calendar c
ON t.BillingMonth = c.BillingMonth
GROUP BY c.Year
ORDER BY c.Year;

------------------------------------------------------------
-- Revenue by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    ROUND(SUM(t.NetAmount),2) AS Revenue
FROM Transactions t
JOIN Customers c
ON t.CustomerID = c.CustomerID
JOIN Regions r
ON c.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- Revenue by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    ROUND(SUM(t.NetAmount),2) AS Revenue
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- Gross Revenue vs Discount vs Tax
------------------------------------------------------------

SELECT
    ROUND(SUM(Amount),2) AS GrossRevenue,
    ROUND(SUM(Discount),2) AS TotalDiscount,
    ROUND(SUM(Tax),2) AS TotalTax,
    ROUND(SUM(NetAmount),2) AS NetRevenue
FROM Transactions;

------------------------------------------------------------
-- Average Monthly Revenue
------------------------------------------------------------

SELECT
    ROUND(AVG(MonthRevenue),2) AS AverageMonthlyRevenue
FROM
(
    SELECT
        BillingMonth,
        SUM(NetAmount) AS MonthRevenue
    FROM Transactions
    GROUP BY BillingMonth
) RevenueTable;

------------------------------------------------------------
-- Highest Revenue Month
------------------------------------------------------------

SELECT
    c.BillingMonth,
    ROUND(SUM(t.NetAmount),2) AS Revenue
FROM Transactions t
JOIN Calendar c
ON t.BillingMonth = c.BillingMonth
GROUP BY c.BillingMonth
ORDER BY Revenue DESC
LIMIT 1;

-- ==========================================================
-- SECTION 4 : PAYMENT ANALYSIS
-- ==========================================================

------------------------------------------------------------
-- Payment Method Distribution
------------------------------------------------------------

SELECT
    PaymentMethod,
    COUNT(*) AS TotalTransactions
FROM Transactions
GROUP BY PaymentMethod
ORDER BY TotalTransactions DESC;

------------------------------------------------------------
-- Payment Status Distribution
------------------------------------------------------------

SELECT
    PaymentStatus,
    COUNT(*) AS TotalTransactions
FROM Transactions
GROUP BY PaymentStatus
ORDER BY TotalTransactions DESC;

------------------------------------------------------------
-- Revenue by Payment Method
------------------------------------------------------------

SELECT
    PaymentMethod,
    ROUND(SUM(NetAmount),2) AS Revenue
FROM Transactions
GROUP BY PaymentMethod
ORDER BY Revenue DESC;

------------------------------------------------------------
-- Revenue by Payment Status
------------------------------------------------------------

SELECT
    PaymentStatus,
    ROUND(SUM(NetAmount),2) AS Revenue
FROM Transactions
GROUP BY PaymentStatus
ORDER BY Revenue DESC;

------------------------------------------------------------
-- Monthly Payment Success Rate
------------------------------------------------------------

SELECT
    BillingMonth,
    ROUND(
        100.0 * SUM(CASE WHEN PaymentStatus='Successful' THEN 1 ELSE 0 END)
        / COUNT(*),
    2) AS SuccessRate
FROM Transactions
GROUP BY BillingMonth
ORDER BY BillingMonth;

------------------------------------------------------------
-- Failed Transactions by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(*) AS FailedTransactions
FROM Transactions t
JOIN Customers c
ON t.CustomerID = c.CustomerID
JOIN Regions r
ON c.RegionID = r.RegionID
WHERE t.PaymentStatus='Failed'
GROUP BY r.RegionName
ORDER BY FailedTransactions DESC;

------------------------------------------------------------
-- Pending Transactions by Region
------------------------------------------------------------

SELECT
    r.RegionName,
    COUNT(*) AS PendingTransactions
FROM Transactions t
JOIN Customers c
ON t.CustomerID = c.CustomerID
JOIN Regions r
ON c.RegionID = r.RegionID
WHERE t.PaymentStatus='Pending'
GROUP BY r.RegionName
ORDER BY PendingTransactions DESC;

------------------------------------------------------------
-- Average Transaction Amount by Payment Method
------------------------------------------------------------

SELECT
    PaymentMethod,
    ROUND(AVG(NetAmount),2) AS AverageTransaction
FROM Transactions
GROUP BY PaymentMethod
ORDER BY AverageTransaction DESC;

-- ==========================================================
-- SECTION 5 : SUBSCRIPTION ANALYSIS
-- ==========================================================

------------------------------------------------------------
-- Customers per Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(c.CustomerID) AS TotalCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY TotalCustomers DESC;

------------------------------------------------------------
-- Revenue by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    ROUND(SUM(t.NetAmount),2) AS Revenue
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- Average Revenue per Customer by Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    ROUND(AVG(t.NetAmount),2) AS AvgRevenuePerCustomer
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY AvgRevenuePerCustomer DESC;

------------------------------------------------------------
-- Active Customers by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(*) AS ActiveCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
WHERE c.CustomerStatus = 'Active'
GROUP BY sp.PlanName
ORDER BY ActiveCustomers DESC;

------------------------------------------------------------
-- Churned Customers by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(*) AS ChurnedCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
WHERE c.CustomerStatus = 'Churned'
GROUP BY sp.PlanName
ORDER BY ChurnedCustomers DESC;

------------------------------------------------------------
-- Suspended Customers by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(*) AS SuspendedCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
WHERE c.CustomerStatus = 'Suspended'
GROUP BY sp.PlanName
ORDER BY SuspendedCustomers DESC;

------------------------------------------------------------
-- Percentage of Customers by Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    COUNT(*) AS TotalCustomers,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Customers),
        2
    ) AS PercentageOfCustomers
FROM Customers c
JOIN SubscriptionPlans sp
ON c.SubscriptionID = sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY PercentageOfCustomers DESC;


-- ==========================================================
-- SECTION 6 : ADVANCED SQL
-- Window Functions, Ranking & Running Totals
-- ==========================================================

------------------------------------------------------------
-- Top 10 Highest Revenue Customers
------------------------------------------------------------

SELECT
    CustomerID,
    ROUND(SUM(NetAmount),2) AS Revenue
FROM Transactions
GROUP BY CustomerID
ORDER BY Revenue DESC
LIMIT 10;

------------------------------------------------------------
-- Customer Revenue Ranking
------------------------------------------------------------

SELECT
    CustomerID,
    ROUND(SUM(NetAmount),2) AS Revenue,
    RANK() OVER(
        ORDER BY SUM(NetAmount) DESC
    ) AS RevenueRank
FROM Transactions
GROUP BY CustomerID;

------------------------------------------------------------
-- Top 5 Revenue Regions
------------------------------------------------------------

SELECT
    RegionName,
    Revenue,
    DENSE_RANK() OVER(
        ORDER BY Revenue DESC
    ) AS RegionRank
FROM
(
    SELECT
        r.RegionName,
        SUM(t.NetAmount) AS Revenue
    FROM Transactions t
    JOIN Customers c
        ON t.CustomerID = c.CustomerID
    JOIN Regions r
        ON c.RegionID = r.RegionID
    GROUP BY r.RegionName
) x;

------------------------------------------------------------
-- Running Monthly Revenue
------------------------------------------------------------

SELECT
    BillingMonth,
    MonthlyRevenue,
    SUM(MonthlyRevenue)
        OVER(
            ORDER BY BillingMonth
        ) AS RunningRevenue
FROM
(
    SELECT
        BillingMonth,
        SUM(NetAmount) AS MonthlyRevenue
    FROM Transactions
    GROUP BY BillingMonth
) m
ORDER BY BillingMonth;

------------------------------------------------------------
-- Previous Month Revenue (LAG)
------------------------------------------------------------

SELECT
    BillingMonth,
    MonthlyRevenue,
    LAG(MonthlyRevenue)
        OVER(
            ORDER BY BillingMonth
        ) AS PreviousMonthRevenue
FROM
(
    SELECT
        BillingMonth,
        SUM(NetAmount) AS MonthlyRevenue
    FROM Transactions
    GROUP BY BillingMonth
) m;

------------------------------------------------------------
-- Month-on-Month Revenue Growth
------------------------------------------------------------

SELECT
    BillingMonth,
    MonthlyRevenue,
    ROUND(
        MonthlyRevenue
        -
        LAG(MonthlyRevenue)
        OVER(ORDER BY BillingMonth),
        2
    ) AS RevenueGrowth
FROM
(
    SELECT
        BillingMonth,
        SUM(NetAmount) AS MonthlyRevenue
    FROM Transactions
    GROUP BY BillingMonth
) m;

------------------------------------------------------------
-- Revenue Quartiles (NTILE)
------------------------------------------------------------

SELECT
    CustomerID,
    ROUND(SUM(NetAmount),2) AS Revenue,
    NTILE(4)
        OVER(
            ORDER BY SUM(NetAmount) DESC
        ) AS RevenueQuartile
FROM Transactions
GROUP BY CustomerID;


-- ==========================================================
-- SECTION 7 : BUSINESS SCENARIO QUERIES
-- ==========================================================

------------------------------------------------------------
-- 1. Average Revenue Per User (ARPU)
------------------------------------------------------------

SELECT
ROUND(
    SUM(NetAmount) /
    COUNT(DISTINCT CustomerID),
2) AS ARPU
FROM Transactions;

------------------------------------------------------------
-- 2. Customer Lifetime Value (Top 20)
------------------------------------------------------------

SELECT
    CustomerID,
    ROUND(SUM(NetAmount),2) AS CustomerLifetimeValue
FROM Transactions
GROUP BY CustomerID
ORDER BY CustomerLifetimeValue DESC
LIMIT 20;

------------------------------------------------------------
-- 3. Revenue Lost From Failed Payments
------------------------------------------------------------

SELECT
ROUND(SUM(NetAmount),2) AS LostRevenue
FROM Transactions
WHERE PaymentStatus='Failed';

------------------------------------------------------------
-- 4. Discount Given By Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    ROUND(SUM(t.Discount),2) AS TotalDiscount
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID=sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY TotalDiscount DESC;

------------------------------------------------------------
-- 5. Revenue Contribution Percentage By Region
------------------------------------------------------------

SELECT
    r.RegionName,
    ROUND(SUM(t.NetAmount),2) AS Revenue,
    ROUND(
        SUM(t.NetAmount)*100.0/
        (SELECT SUM(NetAmount) FROM Transactions),
    2) AS RevenueContributionPercent
FROM Transactions t
JOIN Customers c
ON t.CustomerID=c.CustomerID
JOIN Regions r
ON c.RegionID=r.RegionID
GROUP BY r.RegionName
ORDER BY Revenue DESC;

------------------------------------------------------------
-- 6. Top 10 Highest Paying Customers
------------------------------------------------------------

SELECT
    CustomerID,
    ROUND(SUM(NetAmount),2) AS TotalPaid
FROM Transactions
GROUP BY CustomerID
ORDER BY TotalPaid DESC
LIMIT 10;

------------------------------------------------------------
-- 7. Monthly Failed Payment Rate
------------------------------------------------------------

SELECT
    BillingMonth,
    COUNT(*) FILTER(
        WHERE PaymentStatus='Failed'
    ) AS FailedPayments,
    COUNT(*) AS TotalTransactions,
    ROUND(
        COUNT(*) FILTER(
            WHERE PaymentStatus='Failed'
        )*100.0/
        COUNT(*),
    2) AS FailureRate
FROM Transactions
GROUP BY BillingMonth
ORDER BY BillingMonth;

------------------------------------------------------------
-- 8. Best Performing Subscription Plan
------------------------------------------------------------

SELECT
    sp.PlanName,
    ROUND(SUM(NetAmount),2) AS Revenue
FROM Transactions t
JOIN SubscriptionPlans sp
ON t.SubscriptionID=sp.SubscriptionID
GROUP BY sp.PlanName
ORDER BY Revenue DESC
LIMIT 1;
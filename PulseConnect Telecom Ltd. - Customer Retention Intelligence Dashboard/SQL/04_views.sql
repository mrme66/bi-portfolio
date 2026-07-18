-- ==========================================================
-- VIEW: CUSTOMER BILLING ENGINE
-- PulseConnect Telecom Ltd.
-- ==========================================================

CREATE OR REPLACE VIEW vw_customer_billing AS
SELECT
    c.CustomerID,
    c.SubscriptionID,
    c.CustomerStatus,
    c.JoinDate,
    cal.BillingMonth
FROM Customers c
CROSS JOIN (
    SELECT BillingMonth
    FROM Calendar
    WHERE EXTRACT(DAY FROM BillingMonth) = 1
) cal
WHERE cal.BillingMonth >= DATE_TRUNC('month', c.JoinDate)
AND cal.BillingMonth <= DATE '2025-12-01';

-- ==========================================================
-- VIEW: TRANSACTION SOURCE
-- Generates eligible monthly bills
-- ==========================================================

CREATE OR REPLACE VIEW vw_transaction_source AS
SELECT
    vb.CustomerID,
    vb.BillingMonth,
    vb.SubscriptionID,
    vb.CustomerStatus,
    c.ChurnDate,
    sp.MonthlyFee AS Amount
FROM vw_customer_billing vb
JOIN Customers c
    ON vb.CustomerID = c.CustomerID
JOIN SubscriptionPlans sp
    ON vb.SubscriptionID = sp.SubscriptionID
WHERE
    vb.CustomerStatus IN ('Active','Suspended')
    OR
    (
        vb.CustomerStatus = 'Churned'
        AND vb.BillingMonth <= c.ChurnDate
    );
INSERT INTO Transactions (
    TransactionID,
    CustomerID,
    BillingMonth,
    SubscriptionID,
    Amount,
    PaymentMethod,
    PaymentStatus,
    Discount,
    Tax,
    NetAmount,
    PaymentDate
)
SELECT
    'TXN' || LPAD(
        ROW_NUMBER() OVER (
            ORDER BY CustomerID, BillingMonth
        )::TEXT,
        8,
        '0'
    )                                   AS TransactionID,

    CustomerID,
    BillingMonth,
    SubscriptionID,

    Amount,

    CASE
        WHEN r1 < 0.45 THEN 'Card'
        WHEN r1 < 0.70 THEN 'Bank Transfer'
        WHEN r1 < 0.85 THEN 'USSD'
        ELSE 'Mobile Wallet'
    END                                 AS PaymentMethod,

    CASE
        WHEN CustomerStatus='Suspended' AND r2 < 0.25 THEN 'Failed'
        WHEN r2 < 0.97 THEN 'Successful'
        ELSE 'Pending'
    END                                 AS PaymentStatus,

    CASE
        WHEN r3 < 0.15
            THEN ROUND((Amount*0.10)::numeric,2)
        ELSE 0
    END                                 AS Discount,

    ROUND((Amount*0.075)::numeric,2)    AS Tax,

    ROUND(
        (
            Amount
            -
            CASE
                WHEN r3 < 0.15 THEN Amount*0.10
                ELSE 0
            END
            +
            Amount*0.075
        )::numeric,
        2
    )                                   AS NetAmount,

    BillingMonth
        + (FLOOR(r4*10)::INT)
                                    AS PaymentDate

FROM
(
    SELECT *,
           random() AS r1,
           random() AS r2,
           random() AS r3,
           random() AS r4
    FROM vw_transaction_source
) s;
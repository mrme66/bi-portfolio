CREATE TABLE Transactions (
    TransactionID VARCHAR(15) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    BillingMonth DATE NOT NULL,
    SubscriptionID INT NOT NULL,
    Amount NUMERIC(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    PaymentStatus VARCHAR(20) NOT NULL,
    Discount NUMERIC(10,2) DEFAULT 0,
    Tax NUMERIC(10,2) DEFAULT 0,
    NetAmount NUMERIC(10,2),
    PaymentDate DATE,

    CONSTRAINT fk_transaction_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT fk_transaction_calendar
        FOREIGN KEY (BillingMonth)
        REFERENCES Calendar(BillingMonth),

    CONSTRAINT fk_transaction_subscription
        FOREIGN KEY (SubscriptionID)
        REFERENCES SubscriptionPlans(SubscriptionID)
);
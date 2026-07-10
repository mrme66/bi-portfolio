-- SQL
CREATE TABLE Stores (
    storeID SERIAL PRIMARY KEY,
    StoreName VARCHAR(50) NOT NULL,
    City VARCHAR(50),
    State VARCHAR(50),
    Region VARCHAR(50)
);
-- SQL
CREATE TABLE Customers (
    customerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Gender VARCHAR(10),
    Email VARCHAR(100) Unique,
    Phone VARCHAR(20),
    City VARCHAR(50),
    State VARCHAR(50),
    Country VARCHAR(50),
    DateJoined DATE
);
-- SQL
CREATE TABLE Employees (
    employeeID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50),
    JobTitle VARCHAR(100),
    HireDate DATE
);
-- SQL
CREATE TABLE Categories (
    categoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL,
    Department VARCHAR(100)
);
-- SQL
CREATE TABLE Products (
    productID SERIAL PRIMARY KEY,
    SKU VARCHAR(20) UNIQUE NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CostPrice DECIMAL(10, 2) NOT NULL,
    Brand VARCHAR(50),
    CONSTRAINT fk_product_category
    FOREIGN KEY (CategoryID) 
    REFERENCES Categories(categoryID)
);
-- SQL
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INTEGER NOT NULL,
    StoreID INTEGER NOT NULL,
    EmployeeID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    PaymentMethod VARCHAR(30),

    CONSTRAINT fk_order_customer
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),

    CONSTRAINT fk_order_store
        FOREIGN KEY (StoreID)
        REFERENCES Stores(StoreID),

    CONSTRAINT fk_order_employee
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
-- SQL
CREATE TABLE Calendar (
    Date DATE PRIMARY KEY,
    Day INTEGER,
    Month INTEGER,
    Quarter INTEGER,
    Year INTEGER,
    Weekday VARCHAR(20)
);
-- SQL
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INTEGER NOT NULL,
    ProductID INTEGER NOT NULL,
    Date DATE NOT NULL,
    Quantity INTEGER NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) DEFAULT 0,
    SalesAmount DECIMAL(10,2),
    Profit DECIMAL(10,2),
    CONSTRAINT fk_orderdetails_order
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT fk_orderdetails_product
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID),

    CONSTRAINT fk_orderdetails_calendar
        FOREIGN KEY (Date)
        REFERENCES Calendar(Date)
);
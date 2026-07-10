/*=============================================================================

                           NOVAMART
                 BUSINESS INTELLIGENCE DEPARTMENT

                      BUSINESS ANALYSIS REPORT

Project:
Retail Sales Revenue Analytics

Prepared By:
Martins Oriabure
Business Intelligence Analyst

Description:
This document contains SQL analyses developed to answer key
business questions for NovaMart's executive management. Each
analysis includes the business objective, SQL query, business
insights, recommendations, and the most suitable visualization
for reporting and dashboard development.

=============================================================================*/
/*=============================================================================

BUSINESS ANALYSIS 01

Title:
Customer Distribution Analysis

Business Question:
Which cities have the highest number of registered customers?

Business Objective:
Understand the geographical distribution of customers in order
to support marketing campaigns, customer acquisition strategies,
and future store expansion decisions.

=============================================================================*/

SELECT
    City,
    COUNT(CustomerID) AS NumberOfCustomers
FROM Customers
GROUP BY City
ORDER BY NumberOfCustomers DESC;

/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

Port Harcourt recorded the highest number of registered
customers among all cities, indicating that it represents
NovaMart's strongest customer market during the reporting
period. This suggests a high level of customer penetration and
provides evidence that existing marketing and customer
acquisition strategies in the city have been effective.

BUSINESS VALUE

Understanding customer distribution enables management to
allocate marketing budgets effectively, identify underserved
markets, and make informed expansion decisions.

RECOMMENDED VISUALIZATION

Chart Type:
Horizontal Bar Chart

X-Axis:
Number of Customers

Y-Axis:
City

RECOMMENDATION

Maintain customer engagement initiatives in high-performing
cities while increasing marketing efforts in locations with
lower customer acquisition to achieve more balanced growth.

-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 02

Title:
Monthly Revenue Trend Analysis

Business Question:
How has monthly revenue changed over time?

Business Objective:
Monitor monthly revenue performance to identify business growth,
seasonal trends, and periods requiring management attention.

=============================================================================*/

SELECT
    TO_CHAR(DATE_TRUNC('month', s.SaleDate), 'Month YYYY') AS Month,
    SUM(od.LineTotal) AS MonthlyRevenue
FROM Sales s
INNER JOIN OrderDetails od
    ON s.SaleID = od.SaleID
GROUP BY DATE_TRUNC('month', s.SaleDate)
ORDER BY DATE_TRUNC('month', s.SaleDate);

/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

NovaMart generated relatively stable monthly revenue throughout
the three-year reporting period, with monthly sales consistently
ranging between approximately ₦5.0 million and ₦7.3 million.

The highest monthly revenue was recorded in September 2023
(₦7.31 million), followed by February 2025 (₦7.01 million) and
August 2025 (₦6.96 million). Conversely, January 2025 recorded
the lowest monthly revenue (₦4.99 million), indicating a period
of comparatively weaker sales performance.

Overall, the revenue trend suggests a stable business with
periodic fluctuations that may be influenced by seasonality,
customer demand, promotional campaigns, or inventory
availability.

BUSINESS VALUE

Monitoring monthly revenue enables executive management to
measure business performance, identify seasonal sales patterns,
improve financial forecasting, support budgeting decisions, and
evaluate the effectiveness of sales and marketing initiatives
over time.

RECOMMENDED VISUALIZATION

Chart Type:
Line Chart

X-Axis:
Month

Y-Axis:
Monthly Revenue

RECOMMENDATION

Management should investigate the business activities that
contributed to the exceptional performance recorded in September
2023 and February 2025, with the objective of replicating those
successful strategies in future periods. Similarly, the decline
observed in January 2025 should be analysed to determine whether
it resulted from seasonal demand, inventory shortages, pricing
strategies, or operational challenges requiring corrective
action.


-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 03

Title:
Revenue by Product Category Analysis

Business Question:
Which product categories generate the highest total revenue?

Business Objective:
Determine which product categories contribute the most to overall
sales revenue in order to support inventory planning, purchasing
decisions, merchandising strategies, and category performance
management.

=============================================================================*/

SELECT
    c.CategoryName,
    ROUND(SUM(od.LineTotal), 2) AS TotalRevenue,
    COUNT(DISTINCT s.SaleID) AS NumberOfSales,
    COUNT(DISTINCT od.ProductID) AS ProductsSold
FROM OrderDetails od
INNER JOIN Products p
    ON od.ProductID = p.ProductID
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID
INNER JOIN Sales s
    ON od.SaleID = s.SaleID
GROUP BY c.CategoryName
ORDER BY TotalRevenue DESC;

/*-----------------------------------------------------------------------------


BUSINESS INSIGHT

During the reporting period, revenue was generated from three
product categories. Beverages recorded the highest total revenue,
generating approximately ₦103.78 million from 3,881 sales
transactions. Groceries closely followed with approximately
₦102.38 million generated from 3,893 transactions, while
Personal Care contributed approximately ₦14.71 million from
929 sales transactions.

The analysis indicates that Beverages and Groceries are the
strongest-performing product categories, together contributing
the majority of NovaMart's recorded sales revenue.

BUSINESS VALUE

Category-level revenue analysis enables management to identify
high-performing product groups, optimise inventory investment,
improve merchandising decisions, prioritise supplier management,
and allocate marketing resources where they generate the greatest
business impact.

RECOMMENDED VISUALIZATION

Chart Type:
Horizontal Bar Chart

X-Axis:
Total Revenue (₦)

Y-Axis:
Product Category

RECOMMENDATION

Maintain adequate inventory levels and continue promotional
activities for Beverages and Groceries to sustain revenue
growth. Review the performance of the Personal Care category to
identify opportunities for improved product assortment, pricing,
or targeted marketing campaigns that could increase category
sales and overall profitability.

-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 04

Title:
Payment Method Performance Analysis

Business Question:
Which payment methods generate the highest revenue and
transaction volume?

Business Objective:
Evaluate customer payment preferences by analysing transaction
volume, total revenue generated, and average transaction value
for each payment method. The findings will support payment
strategy decisions, customer convenience initiatives, and future
investment in payment infrastructure.

=============================================================================*/

SELECT
    s.PaymentMethod,
    COUNT(DISTINCT s.SaleID) AS NumberOfTransactions,
    ROUND(SUM(od.LineTotal), 2) AS TotalRevenue,
    ROUND(AVG(od.LineTotal), 2) AS AverageTransactionValue
FROM Sales s
INNER JOIN OrderDetails od
    ON s.SaleID = od.SaleID
GROUP BY s.PaymentMethod
ORDER BY TotalRevenue DESC;

/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

NovaMart customers utilised all five available payment methods
throughout the reporting period, indicating broad adoption of
both traditional and digital payment channels.

Bank Transfer generated the highest revenue, contributing
approximately ₦45.21 million from 1,012 transactions, followed
closely by Online Payments (₦44.39 million), Cash (₦44.31
million), Card (₦43.82 million), and POS (₦43.14 million).

Although Cash ranked third in total revenue, it recorded the
highest average transaction value at approximately ₦15,327.68,
suggesting that customers paying with cash tend to make higher-
value purchases than those using other payment methods.

BUSINESS VALUE

Analysing payment method performance enables management to
understand customer payment preferences, optimise payment
processing strategies, negotiate service provider costs, improve
checkout efficiency, and support investment decisions relating
to payment infrastructure.

RECOMMENDED VISUALIZATION

Chart Type:
Clustered Bar Chart

X-Axis:
Payment Method

Y-Axis:
Total Revenue (₦)

RECOMMENDATION

Continue supporting all available payment methods to maintain
customer convenience while monitoring transaction trends over
time. Given that Bank Transfer generated the highest revenue and
Cash produced the highest average transaction value, management
should ensure these payment channels remain reliable and explore
opportunities to encourage greater adoption of high-performing
digital payment options.

-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 05

Title:
Top Customers by Revenue Contribution

Business Question:
Which customers contribute the highest revenue to NovaMart?

Business Objective:
Identify NovaMart's highest-value customers based on total
purchase value. The findings will support customer retention
strategies, loyalty programme development, personalised
marketing, and customer relationship management.

=============================================================================*/

SELECT
    c.CustomerID,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.City,
    COUNT(DISTINCT s.SaleID) AS NumberOfPurchases,
    ROUND(SUM(od.LineTotal), 2) AS TotalRevenue,
    ROUND(
        SUM(od.LineTotal) / COUNT(DISTINCT s.SaleID),
        2
    ) AS AveragePurchaseValue
FROM Customers c
INNER JOIN Sales s
    ON c.CustomerID = s.CustomerID
INNER JOIN OrderDetails od
    ON s.SaleID = od.SaleID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.City
ORDER BY TotalRevenue DESC
LIMIT 10;
/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

NovaMart's highest revenue-generating customer during the
reporting period was David Eze (Customer ID: 496), who generated
approximately ₦935,696.37 across 17 purchases. James Eze
(Customer ID: 481) and David Bello (Customer ID: 378) ranked
second and third respectively, demonstrating a relatively even
distribution of revenue among the company's highest-value
customers.

Although Aisha Ojo completed only 13 purchases, she recorded the
highest average purchase value of approximately ₦68,230.14 per
transaction. This suggests that customer value should be assessed
using both total revenue contribution and average basket size
rather than purchase frequency alone.

BUSINESS VALUE

Identifying high-value customers enables management to develop
targeted retention strategies, strengthen customer relationships,
design effective loyalty programmes, and personalise promotional
campaigns for customers with the greatest revenue potential.
Monitoring average purchase value also helps identify customers
who consistently make larger purchases and may represent premium
customer segments.

RECOMMENDED VISUALIZATION

Chart Type:
Horizontal Bar Chart

X-Axis:
Total Revenue (₦)

Y-Axis:
Customer Name

RECOMMENDATION

Implement a tiered customer loyalty programme that recognises
both high-revenue customers and customers with consistently high
average purchase values. Target these customer segments with
exclusive offers, personalised promotions, and early access to
new products in order to increase customer lifetime value and
encourage long-term loyalty.
-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 06

Title:
Store Performance Analysis

Business Question:
Which NovaMart stores generate the highest total revenue?

Business Objective:
Evaluate revenue performance across all NovaMart stores in order
to identify top-performing locations, support operational
decision-making, and optimise resource allocation.

=============================================================================*/

SELECT
    st.StoreID,
    st.StoreName,
    st.City,
    COUNT(DISTINCT s.SaleID) AS NumberOfSales,
    ROUND(SUM(od.LineTotal),2) AS TotalRevenue,
    ROUND(
        SUM(od.LineTotal) /
        COUNT(DISTINCT s.SaleID),2
    ) AS AverageSaleValue
FROM Stores st
INNER JOIN Sales s
    ON st.StoreID = s.StoreID
INNER JOIN OrderDetails od
    ON s.SaleID = od.SaleID
GROUP BY
    st.StoreID,
    st.StoreName,
    st.City
ORDER BY TotalRevenue DESC;

/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

Store performance analysis revealed that Owerri Store generated
the highest total revenue during the reporting period,
contributing approximately ₦24.11 million from 533 completed
sales. Abuja Store ranked second with approximately ₦23.71
million, while Ibadan Store recorded the highest average sale
value among the top three stores at approximately ₦46,144.08 per
transaction.

Conversely, Akure Store generated the lowest revenue of
approximately ₦18.94 million and also recorded the lowest average
sale value, indicating potential opportunities to improve sales
performance within that location.

BUSINESS VALUE

Evaluating store performance enables management to identify
high-performing branches, allocate operational resources more
effectively, improve inventory distribution, benchmark successful
stores, and implement targeted strategies to improve
underperforming locations.

RECOMMENDED VISUALIZATION

Chart Type:
Horizontal Bar Chart

X-Axis:
Total Revenue (₦)

Y-Axis:
Store Name

RECOMMENDATION

Analyse the operational strategies, product assortment, and
customer engagement practices implemented at Owerri and Abuja
Stores to identify best practices that can be replicated across
other branches. Additionally, conduct a performance review of
Akure Store to determine whether staffing, inventory
availability, pricing, or local market conditions are limiting
its revenue potential.

-----------------------------------------------------------------------------*/
/*=============================================================================

BUSINESS ANALYSIS 07

Title:
Salesperson Performance Analysis

Business Question:
Which employees generate the highest sales revenue?

Business Objective:
Evaluate employee sales performance to identify top-performing
sales staff, support performance management, and recognise
employees contributing the greatest business value.

=============================================================================*/

SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName AS EmployeeName,
    e.JobTitle,
    COUNT(DISTINCT s.SaleID) AS NumberOfSales,
    ROUND(SUM(od.LineTotal),2) AS TotalRevenue,
    ROUND(
        SUM(od.LineTotal) /
        COUNT(DISTINCT s.SaleID),2
    ) AS AverageSaleValue
FROM Employees e
INNER JOIN Sales s
    ON e.EmployeeID = s.EmployeeID
INNER JOIN OrderDetails od
    ON s.SaleID = od.SaleID
GROUP BY
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    e.JobTitle
ORDER BY TotalRevenue DESC
LIMIT 10;

/*-----------------------------------------------------------------------------

BUSINESS INSIGHT

Employee sales performance analysis revealed that Aisha Ojo
(Employee ID: 24) generated the highest total sales revenue
during the reporting period, contributing approximately
₦8.17 million across 170 completed sales. Blessing Bello and
Emeka Eze ranked second and third respectively, demonstrating
consistent revenue generation among NovaMart's top-performing
employees.

Although Esther Bello completed fewer sales transactions than
most of the top-performing employees, she recorded the highest
average sale value of approximately ₦49,351.07 per transaction,
indicating a strong ability to generate higher-value sales.

BUSINESS VALUE

Evaluating employee sales performance enables management to
identify top-performing staff, measure individual productivity,
recognise outstanding performance, support performance appraisal
processes, and design targeted coaching programmes that improve
overall sales effectiveness across the organisation.

RECOMMENDED VISUALIZATION

Chart Type:
Horizontal Bar Chart

X-Axis:
Total Revenue (₦)

Y-Axis:
Employee Name

RECOMMENDATION

Recognise and reward high-performing employees through
performance-based incentives while analysing the sales
techniques, customer engagement practices, and product knowledge
demonstrated by the highest-performing staff. These best
practices should be incorporated into employee training
programmes to improve sales performance across the wider sales
team.

-----------------------------------------------------------------------------*/

/*=============================================================================
END OF REPORT
=============================================================================*/
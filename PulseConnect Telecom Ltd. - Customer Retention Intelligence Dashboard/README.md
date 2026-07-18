# PulseConnect Telecom Ltd. Executive Business Intelligence Dashboard

## Overview

This project simulates a real-world Business Intelligence solution developed for a telecommunications company. Rather than using a downloaded dataset, the data was engineered from scratch using advanced Microsoft Excel techniques before being imported into PostgreSQL for relational database design and SQL analysis. The final executive dashboard was developed in Microsoft Power BI to provide insights into revenue performance, customer acquisition, subscription performance, regional performance, billing behaviour, and customer intelligence.

The project demonstrates the complete Business Intelligence workflow from data generation and preparation to database design, SQL analysis, data modeling, DAX calculations, and executive dashboard development.

---

## Business Objectives

The dashboard was designed to answer key business questions such as:

- Which subscription plans generate the highest revenue?
- Which regions contribute the most revenue?
- How is revenue changing over time?
- Which payment methods are most frequently used?
- What is the customer churn rate?
- Which regions experience the highest customer losses?
- How does ARPU vary across subscription plans?

---

## Tools Used

- Microsoft Excel (Advanced Data Generation & Validation)
- PostgreSQL
- SQL
- Microsoft Power BI
- Power Query
- DAX
- Star Schema Data Modeling

---

## Data Engineering

Unlike most portfolio projects that rely on publicly available datasets, this project's dataset was created from scratch using advanced Microsoft Excel.

### Data Generation Process

The dataset was generated using:

- Advanced Excel formulas
- Dynamic lookup functions
- Conditional logic
- Controlled random data generation
- Cross-table validation
- Data integrity checks

The generated tables include:

- Customers
- Transactions
- Billing
- Subscription Plans
- Regions

The completed dataset was then imported into PostgreSQL where it was normalized into a relational database for analysis.

---

## Data Model

The dashboard is built using a Star Schema consisting of:

### Fact Table

- Transactions

### Dimension Tables

- Customers
- Calendar
- Subscription Plans
- Regions

---

## Dashboard Pages

### Executive Overview

Provides a high-level summary of overall business performance through KPIs and revenue trends.

**Key Metrics**

- Total Revenue
- Active Customers
- Total Transactions
- Average Revenue per Transaction
- ARPU

**Visuals**

- Monthly Revenue Trend
- Revenue by Region
- Revenue by Subscription Plan

---

### Revenue Analysis

Provides deeper insights into revenue performance across different business dimensions.

**Visuals**

- Quarterly Revenue
- Yearly Revenue
- Revenue by Payment Method
- Monthly Revenue Matrix
- Average Revenue by Subscription Plan
- ARPU by Subscription Plan

---

### Customer & Subscription Intelligence

Focuses on customer acquisition, retention, subscription distribution, and churn analysis.

**Visuals**

- Customer Acquisition Trend
- Customer Status Distribution
- Customers by Region
- Customers by Subscription Plan
- Churned Customers by Region
- Churn Rate KPI
- ARPU by Subscription Plan

---

## Dashboard Preview

### Executive Overview

![Executive Overview](Images/01%20Executive%20Overview.png)

### Revenue Analysis

![Revenue Analysis](Images/02%20Revenue%20Analysis.png)

### Customer & Subscription Intelligence

![Customer Intelligence](Images/03%20Customer%20Intelligence.png)

---

## Skills Demonstrated

- Data Engineering
- Advanced Microsoft Excel
- Data Generation & Validation
- SQL Data Analysis
- PostgreSQL Database Design
- ETL Concepts
- Data Cleaning & Transformation
- Data Modeling
- Star Schema Design
- DAX Measures
- Power Query
- Power BI Dashboard Development
- Executive KPI Reporting
- Business Intelligence
- Data Storytelling

---

## Project Outcome

This project demonstrates an end-to-end Business Intelligence workflow by engineering a realistic telecommunications dataset from scratch, designing a normalized PostgreSQL database, performing SQL analysis, building a Star Schema data model, and developing an interactive executive Power BI dashboard that supports data-driven business decision-making.
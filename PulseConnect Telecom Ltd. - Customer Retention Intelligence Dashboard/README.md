# PulseConnect Telecom Ltd. Executive Business Intelligence Dashboard

## Overview

This project simulates a real-world Business Intelligence solution developed for a telecommunications company. Using PostgreSQL and Microsoft Power BI, raw transactional data was transformed into an interactive executive dashboard that provides insights into revenue performance, customer acquisition, subscription performance, regional performance, and customer intelligence.

The project demonstrates the complete BI workflow from database design and SQL analysis to data modeling, DAX calculations, and dashboard development.

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

- PostgreSQL
- SQL
- Microsoft Power BI
- Power Query
- DAX
- Star Schema Data Modeling

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

![Executive Overview](Imagess/01%20Executive%20Overview.png)

### Revenue Analysis

![Revenue Analysis](Images/02%20Revenue%20Analysis.png)

### Customer & Subscription Intelligence

![Customer Intelligence](Images/03%20Customer%20Intelligence.png)

---

## Skills Demonstrated

- SQL Data Analysis
- PostgreSQL Database Design
- Data Cleaning & Validation
- Star Schema Modeling
- DAX Measures
- Power BI Dashboard Development
- Executive KPI Reporting
- Business Intelligence
- Data Storytelling

---

## Project Outcome

This project demonstrates an end-to-end Business Intelligence workflow, from designing a relational database and performing SQL analysis to developing an executive dashboard that enables data-driven business decisions.
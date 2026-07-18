-- ==========================================================
-- Apex Finance Ltd.
-- Executive Financial Performance Dashboard
-- Business Analysis Queries
-- Author: Martins Oriabure
-- ==========================================================
-- 1. Total Revenue
SELECT
    SUM(revenue_amount) AS total_revenue
FROM revenue;


-- 2. Total Expenses
SELECT
    SUM(expense_amount) AS total_expenses
FROM expenses;


-- 3. Net Profit

WITH RevenueSummary AS (
    SELECT
        department_id,
        date,
        SUM(revenue_amount) AS total_revenue
    FROM revenue
    GROUP BY department_id, date
),

ExpenseSummary AS (
    SELECT
        department_id,
        date,
        SUM(expense_amount) AS total_expense
    FROM expenses
    GROUP BY department_id, date
)

SELECT
    SUM(rs.total_revenue) AS total_revenue,
    SUM(es.total_expense) AS total_expense,
    SUM(rs.total_revenue - es.total_expense) AS net_profit
FROM RevenueSummary rs
JOIN ExpenseSummary es
    ON rs.department_id = es.department_id
   AND rs.date = es.date;


   -- 4. Profit Margin

WITH RevenueSummary AS (
    SELECT
        department_id,
        date,
        SUM(revenue_amount) AS total_revenue
    FROM revenue
    GROUP BY department_id, date
),

ExpenseSummary AS (
    SELECT
        department_id,
        date,
        SUM(expense_amount) AS total_expense
    FROM expenses
    GROUP BY department_id, date
)

SELECT
ROUND(
(
SUM(rs.total_revenue - es.total_expense)
/
SUM(rs.total_revenue)
) * 100
,2) AS profit_margin
FROM RevenueSummary rs
JOIN ExpenseSummary es
ON rs.department_id = es.department_id
AND rs.date = es.date;


-- 5. Monthly Revenue vs Expenses
SELECT
    c.year,
    c.month_number,
    c.month_name,

    SUM(r.revenue_amount) AS revenue,
    SUM(e.expense_amount) AS expenses

FROM calendar c

LEFT JOIN revenue r
ON c.date = r.date

LEFT JOIN expenses e
ON c.date = e.date

GROUP BY
c.year,
c.month_number,
c.month_name

ORDER BY
c.year,
c.month_number;


-- 6. Department Profitability
SELECT

d.department_name,

SUM(r.revenue_amount) AS revenue,

SUM(e.expense_amount) AS expenses,

SUM(r.revenue_amount)-SUM(e.expense_amount) AS net_profit

FROM departments d

LEFT JOIN revenue r
ON d.department_id=r.department_id

LEFT JOIN expenses e
ON d.department_id=e.department_id

GROUP BY d.department_name

ORDER BY net_profit DESC;


-- 7. Budget vs Actual

WITH BudgetSummary AS (

SELECT
    department_id,
    date,
    SUM(budget_amount) AS total_budget
FROM budget
GROUP BY department_id, date

),

ExpenseSummary AS (

SELECT
    department_id,
    date,
    SUM(expense_amount) AS total_actual
FROM expenses
GROUP BY department_id, date

)

SELECT

d.department_name,

SUM(bs.total_budget) AS budget,

SUM(es.total_actual) AS actual_expense,

SUM(bs.total_budget - es.total_actual) AS budget_variance

FROM departments d

LEFT JOIN BudgetSummary bs
ON d.department_id = bs.department_id

LEFT JOIN ExpenseSummary es
ON bs.department_id = es.department_id
AND bs.date = es.date

GROUP BY d.department_name

ORDER BY budget_variance DESC;


-- 8. Expense Distribution
SELECT

ec.expense_category,

SUM(e.expense_amount) AS total_expense

FROM expense_categories ec

LEFT JOIN expenses e
ON ec.expense_category_id=e.expense_category_id

GROUP BY ec.expense_category

ORDER BY total_expense DESC;


-- 9. Top 5 Performing Departments
SELECT

d.department_name,

SUM(r.revenue_amount)-SUM(e.expense_amount) AS net_profit

FROM departments d

LEFT JOIN revenue r
ON d.department_id=r.department_id

LEFT JOIN expenses e
ON d.department_id=e.department_id

GROUP BY d.department_name

ORDER BY net_profit DESC

LIMIT 5;


-- 10. Revenue Sources
SELECT

revenue_source,

SUM(revenue_amount) AS total_revenue

FROM revenue

GROUP BY revenue_source

ORDER BY total_revenue DESC;
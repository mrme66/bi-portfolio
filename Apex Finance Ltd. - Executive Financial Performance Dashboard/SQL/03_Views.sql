-- View: public.vw_budget_variance

-- DROP VIEW public.vw_budget_variance;

CREATE OR REPLACE VIEW public.vw_budget_variance
 AS
 SELECT c.year,
    c.month_number,
    c.month_name,
    sum(b.budget_amount) AS total_budget,
    sum(e.expense_amount) AS actual_expense,
    sum(b.budget_amount) - sum(e.expense_amount) AS variance,
    round((sum(b.budget_amount) - sum(e.expense_amount)) / sum(b.budget_amount) * 100::numeric, 2) AS variance_percent
   FROM calendar c
     JOIN budget b ON c.date = b.date
     JOIN expenses e ON c.date = e.date AND b.department_id::text = e.department_id::text
  GROUP BY c.year, c.month_number, c.month_name
  ORDER BY c.year, c.month_number;

ALTER TABLE public.vw_budget_variance
    OWNER TO postgres;


-- View: public.vw_department_performance

-- DROP VIEW public.vw_department_performance;

CREATE OR REPLACE VIEW public.vw_department_performance
 AS
 SELECT d.department_id,
    d.department_name,
    sum(r.revenue_amount) AS total_revenue,
    sum(e.expense_amount) AS total_expenses,
    sum(r.revenue_amount) - sum(e.expense_amount) AS total_profit,
    round((sum(r.revenue_amount) - sum(e.expense_amount)) / sum(r.revenue_amount) * 100::numeric, 2) AS profit_margin
   FROM departments d
     JOIN revenue r ON d.department_id::text = r.department_id::text
     JOIN expenses e ON d.department_id::text = e.department_id::text AND d.department_id::text = e.department_id::text AND r.date = e.date
  GROUP BY d.department_id, d.department_name
  ORDER BY (sum(r.revenue_amount) - sum(e.expense_amount)) DESC;

ALTER TABLE public.vw_department_performance
    OWNER TO postgres;


-- View: public.vw_kpi_summary

-- DROP VIEW public.vw_kpi_summary;

CREATE OR REPLACE VIEW public.vw_kpi_summary
 AS
 SELECT ( SELECT sum(revenue.revenue_amount) AS sum
           FROM revenue) AS total_revenue,
    ( SELECT sum(expenses.expense_amount) AS sum
           FROM expenses) AS total_expenses,
    (( SELECT sum(revenue.revenue_amount) AS sum
           FROM revenue)) - (( SELECT sum(expenses.expense_amount) AS sum
           FROM expenses)) AS total_profit,
    round(((( SELECT sum(revenue.revenue_amount) AS sum
           FROM revenue)) - (( SELECT sum(expenses.expense_amount) AS sum
           FROM expenses))) / (( SELECT sum(revenue.revenue_amount) AS sum
           FROM revenue)) * 100::numeric, 2) AS profit_margin;

ALTER TABLE public.vw_kpi_summary
    OWNER TO postgres;


-- View: public.vw_monthly_financials

-- DROP VIEW public.vw_monthly_financials;

CREATE OR REPLACE VIEW public.vw_monthly_financials
 AS
 SELECT c.year,
    c.month_number,
    c.month_name,
    sum(r.revenue_amount) AS total_revenue,
    sum(e.expense_amount) AS total_expenses,
    sum(r.revenue_amount) - sum(e.expense_amount) AS total_profit
   FROM calendar c
     JOIN revenue r ON c.date = r.date
     JOIN expenses e ON c.date = e.date AND r.department_id::text = e.department_id::text
  GROUP BY c.year, c.month_number, c.month_name
  ORDER BY c.year, c.month_number;

ALTER TABLE public.vw_monthly_financials
    OWNER TO postgres;


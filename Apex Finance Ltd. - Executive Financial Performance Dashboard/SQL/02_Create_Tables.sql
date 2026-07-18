-- Table: public.budget

-- DROP TABLE IF EXISTS public.budget;

CREATE TABLE IF NOT EXISTS public.budget
(
    budget_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    date date,
    department_id character varying(10) COLLATE pg_catalog."default",
    budget_amount numeric(18,2),
    CONSTRAINT budget_pkey PRIMARY KEY (budget_id),
    CONSTRAINT fk_budget_calendar FOREIGN KEY (date)
        REFERENCES public.calendar (date) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_budget_department FOREIGN KEY (department_id)
        REFERENCES public.departments (department_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.budget
    OWNER to postgres;
    -- Table: public.calendar

-- DROP TABLE IF EXISTS public.calendar;

CREATE TABLE IF NOT EXISTS public.calendar
(
    date date NOT NULL,
    year integer,
    quarter character varying(2) COLLATE pg_catalog."default",
    month_number integer,
    month_name character varying(20) COLLATE pg_catalog."default",
    CONSTRAINT calendar_pkey PRIMARY KEY (date)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.calendar
    OWNER to postgres;
    -- Table: public.departments

-- DROP TABLE IF EXISTS public.departments;

CREATE TABLE IF NOT EXISTS public.departments
(
    department_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    department_name character varying(100) COLLATE pg_catalog."default",
    department_head character varying(100) COLLATE pg_catalog."default",
    employee_count integer,
    location character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT departments_pkey PRIMARY KEY (department_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.departments
    OWNER to postgres;
    -- Table: public.expense_categories

-- DROP TABLE IF EXISTS public.expense_categories;

CREATE TABLE IF NOT EXISTS public.expense_categories
(
    expense_category_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    expense_category character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT expense_categories_pkey PRIMARY KEY (expense_category_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.expense_categories
    OWNER to postgres;
    -- Table: public.expenses

-- DROP TABLE IF EXISTS public.expenses;

CREATE TABLE IF NOT EXISTS public.expenses
(
    expense_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    date date,
    department_id character varying(10) COLLATE pg_catalog."default",
    expense_category_id character varying(10) COLLATE pg_catalog."default",
    expense_amount numeric(18,2),
    CONSTRAINT expenses_pkey PRIMARY KEY (expense_id),
    CONSTRAINT fk_expense_calendar FOREIGN KEY (date)
        REFERENCES public.calendar (date) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_expense_category FOREIGN KEY (expense_category_id)
        REFERENCES public.expense_categories (expense_category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_expense_department FOREIGN KEY (department_id)
        REFERENCES public.departments (department_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.expenses
    OWNER to postgres;
    -- Table: public.revenue

-- DROP TABLE IF EXISTS public.revenue;

CREATE TABLE IF NOT EXISTS public.revenue
(
    revenue_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    date date,
    department_id character varying(10) COLLATE pg_catalog."default",
    revenue_amount numeric(18,2),
    revenue_source character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT revenue_pkey PRIMARY KEY (revenue_id),
    CONSTRAINT fk_revenue_calendar FOREIGN KEY (date)
        REFERENCES public.calendar (date) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_revenue_department FOREIGN KEY (department_id)
        REFERENCES public.departments (department_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.revenue
    OWNER to postgres;
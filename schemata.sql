-- Drop tables if exists
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS titles;
DROP TABLE IF EXISTS employees;

-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/pEkBXb
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.

-- Create tables (in order to avoid dependency errors) and check for duplicates.
-- Change data type to Composite Keys if duplicates are found in PK.

-- DEPARTMENTS
CREATE TABLE "departments" (
    "dept_no" VARCHAR(40)   NOT NULL,
    "dept_name" VARCHAR(40)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

select dept_no, count(*)
from departments
group by dept_no
HAVING count(*) > 1

SELECT * FROM departments;

-- TITLES
CREATE TABLE "titles" (
    "title_id" VARCHAR(40)   NOT NULL,
    "title" VARCHAR(40)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

select title_id, count(*)
from titles
group by title_id
HAVING count(*) > 1

SELECT * FROM titles;

-- EMPLOYEES
CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR(40)   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(40)   NOT NULL,
    "last_name" VARCHAR(40)   NOT NULL,
    "sex" VARCHAR(2)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

select emp_no, count(*)
from employees
group by emp_no
HAVING count(*) > 1

SELECT * FROM employees;

-- DEPT_EMP (junction)
CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR(40)   NOT NULL
);

SELECT * FROM dept_emp;

-- DEPT_MANAGER (junction)
CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(40)   NOT NULL,
    "emp_no" INT   NOT NULL
);

SELECT * FROM dept_manager;

-- SALARIES (junction)
CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
	PRIMARY KEY(salary,emp_no));

SELECT * FROM salaries;

-- Create FK dependencies between tables
ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");


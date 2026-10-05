# SQL Analysis

The SQL analysis answers practical business questions using the same synthetic data shown in the Power BI dashboard. Queries are intentionally kept at a Business Analyst / Business Systems Analyst level so they are easy to explain and relate to a business need.

## Business Questions Covered

- Request distribution by status
- Leave activity by department
- Employees with no requests
- Departments with higher request volumes
- Longer approved Vacation or Sick requests
- Unique departments
- Leave-balance summary and categories
- Pending requests requiring follow-up
- Approved leave by type
- Monthly request trends
- Leave-balance exceptions
- Employees below the average remaining balance
- Employees with pending requests
- Missing approval-date handling

## SQL Concepts Demonstrated

`INNER JOIN`, `LEFT JOIN`, `WHERE`, `AND`, `OR`, `IN`, `DISTINCT`, `GROUP BY`, `HAVING`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `CASE`, `COALESCE`, `IS NULL`, SQLite `strftime` date grouping, and simple subqueries.

RIGHT JOIN and FULL OUTER JOIN are not forced into the project because the analysis is SQLite-based and the same business needs can be handled with the joins shown here. They remain useful concepts to understand for interviews.

## Full Query Set

See [leave_analysis.sql](leave_analysis.sql).

## Why This Matters for a BA

The purpose is not advanced SQL development. It demonstrates how SQL can be used to validate data, investigate exceptions, answer stakeholder questions and support reporting decisions.

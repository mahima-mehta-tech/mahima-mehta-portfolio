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

`INNER JOIN`, `LEFT JOIN`, `WHERE`, `AND`, `OR`, `IN`, `DISTINCT`, `GROUP BY`, `HAVING`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `CASE`, `COALESCE`, `NULLIF`, `IS NULL`, SQLite `strftime` date grouping, and simple subqueries.

RIGHT JOIN and FULL OUTER JOIN are not forced into the project because the analysis is SQLite-based and the same business needs can be handled with the joins shown here. They remain useful concepts to understand for interviews.

## SQL Learning Notes

The purpose of this section is to make each query easy to review later. For every query, focus on three things: **business question, syntax, and why the syntax was chosen**.

### 1. Request distribution by status

```SQL
SELECT Status, COUNT(*) AS RequestCount
FROM LeaveRequests
GROUP BY Status
ORDER BY RequestCount DESC;
```

- `SELECT` chooses the fields/results to return.
- `COUNT(*)` counts rows.
- `AS RequestCount` gives the calculated result a readable alias.
- `GROUP BY Status` creates one group for each status.
- `ORDER BY ... DESC` sorts from highest to lowest.

### 2. Leave activity by department

```SQL
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;
```

- `Employees e` and `LeaveRequests lr` use short table aliases.
- `INNER JOIN ... ON` combines matching employee and request records using EmployeeID.
- `COUNT` counts requests and `SUM` totals requested days.
- `GROUP BY Department` produces one result per department.

### 3. Employees with no leave requests

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM Employees e
LEFT JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.LeaveRequestID IS NULL
ORDER BY e.EmployeeID;
```

- `LEFT JOIN` keeps every employee even when there is no matching request.
- For employees with no match, request-side fields are NULL.
- `WHERE ... IS NULL` therefore isolates employees with no leave requests.

### 4. Departments with more than 20 requests

```SQL
SELECT e.Department, COUNT(*) AS RequestCount
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
HAVING COUNT(*) > 20
ORDER BY RequestCount DESC;
```

- `GROUP BY` first creates department groups.
- `HAVING` filters the grouped/aggregated results.
- Use `WHERE` to filter rows before grouping; use `HAVING` to filter aggregate groups after grouping.

### 5. Approved Vacation or Sick requests longer than 3 days

```SQL
SELECT lr.LeaveRequestID, e.EmployeeName, e.Department,
       lt.LeaveType, lr.RequestedDays
FROM LeaveRequests lr
INNER JOIN Employees e ON lr.EmployeeID = e.EmployeeID
INNER JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID
WHERE lr.Status = 'Approved'
  AND lt.LeaveType IN ('Vacation', 'Sick')
  AND lr.RequestedDays > 3
ORDER BY lr.RequestedDays DESC;
```

- Two `INNER JOIN` operations bring employee and leave-type information into the request analysis.
- `WHERE` applies row-level conditions.
- `AND` means all listed conditions must be true.
- `IN (...)` is a concise way to match one of several allowed values.

### 6. Unique departments

```SQL
SELECT DISTINCT Department
FROM Employees
ORDER BY Department;
```

- `DISTINCT` removes duplicate result values.
- `DISTINCT` is different from a `UNIQUE` database constraint. DISTINCT affects query output; UNIQUE controls what values may be stored.

### 7. Average, minimum and maximum remaining balance

```SQL
SELECT ROUND(AVG(RemainingBalanceDays), 2) AS AvgRemainingBalance,
       MIN(RemainingBalanceDays) AS MinRemainingBalance,
       MAX(RemainingBalanceDays) AS MaxRemainingBalance
FROM LeaveBalances;
```

- `AVG`, `MIN` and `MAX` are aggregate functions.
- `ROUND(..., 2)` displays the average to two decimal places.

### 8. Group remaining balances into review categories

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.RemainingBalanceDays,
       CASE
         WHEN lb.RemainingBalanceDays = 0 THEN 'No Balance'
         WHEN lb.RemainingBalanceDays <= 5 THEN 'Low Balance'
         WHEN lb.RemainingBalanceDays <= 10 THEN 'Moderate Balance'
         ELSE 'Healthy Balance'
       END AS BalanceCategory
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
ORDER BY lb.RemainingBalanceDays, e.EmployeeID;
```

General pattern:

```SQL
CASE
  WHEN condition THEN result
  WHEN condition THEN result
  ELSE result
END
```

SQL evaluates the WHEN conditions in order and returns the first matching category.

### 9. Pending requests requiring follow-up

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.RequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;
```

This combines employee and request data, then uses `WHERE` to return only pending requests.

### 10. Approved leave by type

```SQL
SELECT lt.LeaveType,
       COUNT(lr.LeaveRequestID) AS ApprovedRequests,
       SUM(lr.RequestedDays) AS ApprovedDays
FROM LeaveTypes lt
INNER JOIN LeaveRequests lr ON lt.LeaveTypeID = lr.LeaveTypeID
WHERE lr.Status = 'Approved'
GROUP BY lt.LeaveType
ORDER BY ApprovedDays DESC;
```

The query first limits the rows to approved requests, then groups them by leave type and calculates both request count and requested-day total.

### 11. Monthly request trend

```SQL
SELECT strftime('%Y-%m', RequestDate) AS RequestMonth,
       COUNT(*) AS RequestCount,
       SUM(RequestedDays) AS RequestedDays
FROM LeaveRequests
GROUP BY strftime('%Y-%m', RequestDate)
ORDER BY RequestMonth;
```

- SQLite `strftime('%Y-%m', RequestDate)` converts a date into a year-month value for grouping.
- The same expression is used in `SELECT` and `GROUP BY`.
- `COUNT` and `SUM` then summarize each month.

### 12. Leave-balance exceptions

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays
   OR lb.RemainingBalanceDays < 0
ORDER BY lb.ApprovedDaysUsed DESC;
```

- `INNER JOIN` adds employee details to the balance records.
- `WHERE` defines the exception rules.
- `OR` means a record is returned if either exception condition is true.
- These are records for investigation, not automatically errors.

### 13. Employees below the average remaining balance

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.RemainingBalanceDays
FROM Employees e
INNER JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.RemainingBalanceDays < (
    SELECT AVG(RemainingBalanceDays)
    FROM LeaveBalances
)
ORDER BY lb.RemainingBalanceDays;
```

The inner query calculates one value: the overall average balance. The outer query then returns employees whose balance is below that value. This is a simple subquery.

### 14. Employees with a pending request

```SQL
SELECT EmployeeID, EmployeeName, Department
FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM LeaveRequests
    WHERE Status = 'Pending'
)
ORDER BY EmployeeID;
```

The inner query produces a list of EmployeeIDs with pending requests. The outer query uses `IN` to return the corresponding employee details.

### 15. Readable fallback for missing approval dates

```SQL
SELECT LeaveRequestID, EmployeeID, Status,
       COALESCE(NULLIF(ApprovalDate, ''), 'Not yet approved') AS ApprovalStatusDate
FROM LeaveRequests
ORDER BY LeaveRequestID;
```

Read from the inside outward:

1. `NULLIF(ApprovalDate, '')` converts an empty string to NULL.
2. `COALESCE(value, fallback)` returns the first non-NULL value.
3. If the approval date is missing or blank, the output becomes **Not yet approved**.

## Field Meaning: Requested vs Approved vs Remaining

The case study deliberately distinguishes:

- **RequestedDays**: days submitted in a leave request.
- **ApprovedDaysUsed**: approved days recorded as consumed against the relevant leave balance.
- **RemainingBalanceDays**: entitlement still available after recorded usage.

Pending and rejected requests do not reduce annual vacation entitlement in this simplified case study. An unapproved request is therefore not consumed leave, but it is clearer to describe the available entitlement as **remaining/unused balance**, rather than describing the unapproved request itself as "unused leave."

## Full Query Set

See [leave_analysis.sql](leave_analysis.sql).

## Why This Matters for a BA

The purpose is not advanced SQL development. It demonstrates how SQL can be used to validate data, investigate exceptions, answer stakeholder questions and support reporting decisions.

# SQL Analysis

The SQL analysis uses the same synthetic Employee Leave Management data shown in the Power BI dashboard.

The purpose is **not to demonstrate advanced SQL development**. It is to show that SQL can be used by a Business Analyst / Business Systems Analyst to answer business questions, validate data and investigate exceptions.

Each section contains:

**Business question → SQL query → syntax explanation → actual output**

This also makes the project useful as revision material for interviews.

## SQL Concepts Demonstrated

`SELECT`, `WHERE`, `INNER JOIN`, `LEFT JOIN`, `IS NULL`, `DISTINCT`, `GROUP BY`, `HAVING`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `CASE`, `AND/OR`.

The project deliberately avoids advanced SQL such as nested subqueries, CTEs, window functions and complex date expressions because they are not necessary for the business questions in this case study.

---

## 1. Request distribution by status

**Business question:** How many requests are Approved, Pending, Rejected or Cancelled?

```SQL
SELECT Status, COUNT(*) AS RequestCount
FROM LeaveRequests
GROUP BY Status
ORDER BY RequestCount DESC;
```

### Syntax

- `SELECT Status` returns the request status.
- `COUNT(*)` counts rows.
- `AS RequestCount` gives the count a readable name.
- `GROUP BY Status` creates one group for each status.
- `ORDER BY ... DESC` sorts the largest count first.

### Output

| Status | RequestCount |
|---|---:|
| Approved | 127 |
| Pending | 24 |
| Rejected | 17 |
| Cancelled | 12 |

**Business meaning:** Most requests are Approved, while 24 are still Pending.

---

## 2. Leave activity by department

**Business question:** Which departments have the highest request volume and requested days?

```SQL
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;
```

### Syntax

- `Employees e` and `LeaveRequests lr` are table aliases.
- `INNER JOIN ... ON` connects each request to its employee using `EmployeeID`.
- `COUNT` counts requests.
- `SUM` totals requested days.
- `GROUP BY e.Department` creates one result per department.

### Output

| Department | TotalRequests | TotalRequestedDays |
|---|---:|---:|
| Engineering | 42 | 133 |
| Finance | 40 | 146 |
| Sales | 36 | 126 |
| Customer Support | 28 | 86 |
| Operations | 21 | 59 |
| HR | 13 | 41 |

**Business meaning:** Engineering has the highest number of requests, while Finance has the highest total requested days. These figures show activity volume, not absence rate.

---

## 3. Employees with no leave requests

**Business question:** Are there employees with no leave requests in the dataset?

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department
FROM Employees e
LEFT JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.LeaveRequestID IS NULL
ORDER BY e.EmployeeID;
```

### Syntax

- `LEFT JOIN` keeps every employee, even if there is no matching request.
- When no request matches, the request-side fields are `NULL`.
- `WHERE lr.LeaveRequestID IS NULL` keeps only those unmatched employees.

### Output

| EmployeeID | EmployeeName | Department |
|---:|---|---|
| 1038 | Employee 1038 | Operations |
| 1054 | Employee 1054 | Customer Support |

**Business meaning:** Two employees have no leave requests in the sample data.

---

## 4. Departments with more than 20 requests

**Business question:** Which departments have request volumes above 20?

```SQL
SELECT e.Department, COUNT(*) AS RequestCount
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
HAVING COUNT(*) > 20
ORDER BY RequestCount DESC;
```

### Syntax

- `GROUP BY` creates department groups.
- `COUNT(*)` calculates the number of requests in each group.
- `HAVING COUNT(*) > 20` filters the grouped results.
- `WHERE` filters individual rows; `HAVING` filters grouped/aggregated results.

### Output

| Department | RequestCount |
|---|---:|
| Engineering | 42 |
| Finance | 40 |
| Sales | 36 |
| Customer Support | 28 |
| Operations | 21 |

---

## 5. Unique departments

**Business question:** Which departments are represented in the employee master?

```SQL
SELECT DISTINCT Department
FROM Employees
ORDER BY Department;
```

### Syntax

- `DISTINCT` removes duplicate values from the query result.
- `ORDER BY` sorts the department names.

### Output

| Department |
|---|
| Customer Support |
| Engineering |
| Finance |
| HR |
| Operations |
| Sales |

**Note:** `DISTINCT` affects query output. It is different from a `UNIQUE` database constraint.

---

## 6. Remaining leave-balance summary

**Business question:** What are the average, minimum and maximum remaining balances?

```SQL
SELECT ROUND(AVG(RemainingBalanceDays), 2) AS AvgRemainingBalance,
       MIN(RemainingBalanceDays) AS MinRemainingBalance,
       MAX(RemainingBalanceDays) AS MaxRemainingBalance
FROM LeaveBalances;
```

### Syntax

- `AVG` calculates the average.
- `MIN` returns the lowest value.
- `MAX` returns the highest value.
- `ROUND(..., 2)` displays the average to two decimal places.

### Output

| AvgRemainingBalance | MinRemainingBalance | MaxRemainingBalance |
|---:|---:|---:|
| 13.35 | 0 | 20 |

---

## 7. Classify remaining balances

**Business question:** How can employee balances be grouped into simple review categories?

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
ORDER BY e.EmployeeID;
```

### CASE syntax

```SQL
CASE
    WHEN condition THEN result
    WHEN condition THEN result
    ELSE result
END
```

SQL checks the conditions in order and returns the first matching category.

### Sample output

| EmployeeID | EmployeeName | Department | RemainingBalanceDays | BalanceCategory |
|---:|---|---|---:|---|
| 1001 | Employee 1001 | Engineering | 20 | Healthy Balance |
| 1002 | Employee 1002 | Engineering | 16 | Healthy Balance |
| 1003 | Employee 1003 | Engineering | 6 | Moderate Balance |
| 1004 | Employee 1004 | Engineering | 19 | Healthy Balance |
| 1005 | Employee 1005 | Engineering | 5 | Low Balance |

The query returns all employee balance records; only a sample is shown here for readability.

---

## 8. Pending requests requiring follow-up

**Business question:** Which requests are still Pending and may need manager follow-up?

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.RequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;
```

### Syntax

- `INNER JOIN` combines employee information with leave requests.
- `WHERE lr.Status = 'Pending'` keeps only Pending requests.
- `ORDER BY lr.RequestDate` places the oldest request dates first.

### Sample output

| EmployeeID | EmployeeName | Department | LeaveRequestID | RequestDate | RequestedDays |
|---:|---|---|---:|---|---:|
| 1044 | Employee 1044 | Sales | 5036 | 2026-01-16 | 6 |
| 1005 | Employee 1005 | Engineering | 5122 | 2026-01-27 | 3 |
| 1010 | Employee 1010 | Engineering | 5127 | 2026-02-15 | 3 |
| 1013 | Employee 1013 | Engineering | 5044 | 2026-02-25 | 1 |
| 1040 | Employee 1040 | Sales | 5116 | 2026-03-03 | 8 |

There are 24 Pending requests in the dataset; five are shown here as a sample.

---

## 9. Approved leave by type

**Business question:** Which leave types account for the most approved leave?

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

### Syntax

- `INNER JOIN` connects the leave-type reference to the requests.
- `WHERE` keeps only Approved requests.
- `GROUP BY` creates one group for each leave type.
- `COUNT` counts approved requests and `SUM` totals their requested days.

### Output

| LeaveType | ApprovedRequests | ApprovedDays |
|---|---:|---:|
| Vacation | 49 | 216 |
| Sick | 31 | 76 |
| Unpaid | 20 | 55 |
| Personal | 12 | 39 |
| Bereavement | 15 | 33 |

---

## 10. Leave-balance exceptions

**Business question:** Which leave-balance records need investigation?

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

### Syntax

- `INNER JOIN` adds employee information to the balance records.
- `WHERE` applies the exception rule.
- `OR` means a row is returned when either exception condition is true.

### Output

| EmployeeID | EmployeeName | Department | AnnualEntitlementDays | ApprovedDaysUsed | RemainingBalanceDays |
|---:|---|---|---:|---:|---:|
| 1016 | Employee 1016 | Finance | 20 | 33 | 0 |
| 1019 | Employee 1019 | Finance | 20 | 27 | 0 |

**Business meaning:** These are records requiring review, not automatically data errors. The relevant leave policy or adjustment history would need to be confirmed.

---

## Field Meaning: Requested vs Approved vs Remaining

- **RequestedDays** = days submitted in a leave request.
- **ApprovedDaysUsed** = approved days recorded as consumed against the relevant leave balance.
- **RemainingBalanceDays** = entitlement still available after recorded usage.

Pending and rejected requests do not reduce annual vacation entitlement in this simplified case study. An unapproved request is therefore not consumed leave. Available/unused entitlement is represented by `RemainingBalanceDays`.

## Full Query Set

See [leave_analysis.sql](leave_analysis.sql).

## Why This Matters for a BA

The purpose is not to look like a SQL developer. The queries demonstrate practical skills that a BA can use to:

- answer stakeholder questions,
- validate and summarize data,
- identify records requiring follow-up,
- investigate exceptions,
- and support reporting and decision-making.

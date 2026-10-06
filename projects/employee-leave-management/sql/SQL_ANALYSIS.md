# SQL Analysis

The SQL analysis uses the same synthetic Employee Leave Management data shown in the Power BI dashboard.

The objective is to demonstrate **practical SQL used for business investigation**, not advanced SQL development. The query set is deliberately small: each query answers a management or data-quality question and can be explained confidently in an interview.

Each section follows the same structure:

**Business question → SQL query → syntax explanation → actual output → business interpretation**

This avoids two extremes: a beginner-style list of isolated SQL commands and unnecessary developer-level complexity.

## SQL Concepts Demonstrated

Across the analysis, the queries use:

`SELECT`, `WHERE`, `AND/OR`, `INNER JOIN`, `LEFT JOIN`, `IS NULL`, `GROUP BY`, `ORDER BY`, `COUNT`, `SUM`, `AVG`, `MIN`, and `MAX`.

The strongest query combines three related tables to answer a specific management question. Advanced constructs such as CTEs, window functions, nested subqueries and complex date expressions are intentionally excluded because they are not needed for this case study.

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
- `COUNT(*)` counts the rows in each status.
- `AS RequestCount` gives the result a readable name.
- `GROUP BY Status` creates one group for each status.
- `ORDER BY ... DESC` puts the largest count first.

### Output

| Status | RequestCount |
|---|---:|
| Approved | 127 |
| Pending | 24 |
| Rejected | 17 |
| Cancelled | 12 |

**Business interpretation:** Approved requests form the largest group. There are also 24 Pending requests that may require follow-up.

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

- `Employees e` and `LeaveRequests lr` are short table aliases.
- `INNER JOIN ... ON` connects each request to its employee through `EmployeeID`.
- `COUNT` calculates request volume.
- `SUM` totals requested days.
- `GROUP BY Department` produces one result for each department.

### Output

| Department | TotalRequests | TotalRequestedDays |
|---|---:|---:|
| Engineering | 42 | 133 |
| Finance | 40 | 146 |
| Sales | 36 | 126 |
| Customer Support | 28 | 86 |
| Operations | 21 | 59 |
| HR | 13 | 41 |

**Business interpretation:** Engineering has the highest number of requests, while Finance has the highest number of requested days. This represents activity volume, not absence rate, because department headcount is not being used to normalize the result.

---

## 3. Pending requests requiring follow-up

**Business question:** Which Pending requests may need manager follow-up?

```SQL
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lr.LeaveRequestID, lr.RequestDate, lr.RequestedDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
WHERE lr.Status = 'Pending'
ORDER BY lr.RequestDate;
```

### Syntax

- `INNER JOIN` adds employee information to each request.
- `WHERE Status = 'Pending'` keeps only Pending requests.
- `ORDER BY RequestDate` puts the oldest request dates first.

### Sample output

| EmployeeID | EmployeeName | Department | LeaveRequestID | RequestDate | RequestedDays |
|---:|---|---|---:|---|---:|
| 1044 | Employee 1044 | Sales | 5036 | 2026-01-16 | 6 |
| 1005 | Employee 1005 | Engineering | 5122 | 2026-01-27 | 3 |
| 1010 | Employee 1010 | Engineering | 5127 | 2026-02-15 | 3 |
| 1013 | Employee 1013 | Engineering | 5044 | 2026-02-25 | 1 |
| 1040 | Employee 1040 | Sales | 5116 | 2026-03-03 | 8 |

There are 24 Pending requests in the dataset; five are shown here for readability.

**Business interpretation:** This query creates an actionable follow-up list rather than only reporting the total number of Pending requests.

---

## 4. Approved leave by type

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

- `INNER JOIN` connects each request to its leave type.
- `WHERE` keeps only Approved requests.
- `GROUP BY` creates one result for each leave type.
- `COUNT` counts requests and `SUM` totals the days.

### Output

| LeaveType | ApprovedRequests | ApprovedDays |
|---|---:|---:|
| Vacation | 49 | 216 |
| Sick | 31 | 76 |
| Unpaid | 20 | 55 |
| Personal | 12 | 39 |
| Bereavement | 15 | 33 |

**Business interpretation:** Vacation represents the largest approved leave volume in this dataset.

---

## 5. Employees with no leave requests

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
- When there is no matching request, request-side fields are `NULL`.
- `IS NULL` therefore identifies employees with no request record.

### Output

| EmployeeID | EmployeeName | Department |
|---:|---|---|
| 1038 | Employee 1038 | Operations |
| 1054 | Employee 1054 | Customer Support |

**Business interpretation:** Two employees have no leave requests in the sample data. This is an example of using SQL to identify missing related activity.

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
- `MIN` returns the lowest balance.
- `MAX` returns the highest balance.
- `ROUND(..., 2)` displays the average to two decimal places.

### Output

| AvgRemainingBalance | MinRemainingBalance | MaxRemainingBalance |
|---:|---:|---:|
| 13.35 | 0 | 20 |

**Business interpretation:** The average remaining balance is 13.35 days, with balances ranging from 0 to 20 days.

---

## 7. Leave-balance exceptions

**Business question:** Which leave-balance records require investigation?

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
- The first condition identifies approved usage above entitlement.
- `OR` means the record is returned if either exception condition is true.
- `ORDER BY` places the highest approved usage first.

### Output

| EmployeeID | EmployeeName | Department | AnnualEntitlementDays | ApprovedDaysUsed | RemainingBalanceDays |
|---:|---|---|---:|---:|---:|
| 1016 | Employee 1016 | Finance | 20 | 33 | 0 |
| 1019 | Employee 1019 | Finance | 20 | 27 | 0 |

**Business interpretation:** These records require review, but they should not automatically be labelled data errors. A BA would first confirm the relevant leave policy, carry-forward rules or adjustment history.

---

## 8. Approved Vacation days by department

**Business question:** Which departments account for the most approved Vacation days?

```SQL
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS ApprovedVacationRequests,
       SUM(lr.RequestedDays) AS ApprovedVacationDays
FROM Employees e
INNER JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
INNER JOIN LeaveTypes lt ON lr.LeaveTypeID = lt.LeaveTypeID
WHERE lr.Status = 'Approved'
  AND lt.LeaveType = 'Vacation'
GROUP BY e.Department
ORDER BY ApprovedVacationDays DESC;
```

### Why this is the strongest query

This is intentionally the most detailed query in the case study, but it still uses only concepts already demonstrated elsewhere:

1. Join Employees to LeaveRequests using `EmployeeID`.
2. Join LeaveRequests to LeaveTypes using `LeaveTypeID`.
3. Keep only Approved Vacation requests.
4. Group the records by department.
5. Count the requests and total the days.

### Output

| Department | ApprovedVacationRequests | ApprovedVacationDays |
|---|---:|---:|
| Finance | 15 | 71 |
| Sales | 8 | 39 |
| Customer Support | 9 | 34 |
| Operations | 8 | 33 |
| Engineering | 7 | 29 |
| HR | 2 | 10 |

**Business interpretation:** Finance has the highest approved Vacation-day volume in this dataset. It should not be described as having the highest absence rate because the analysis does not normalize by department headcount.

---

## Field Meaning: Requested vs Approved vs Remaining

- **RequestedDays** = days submitted in a leave request.
- **ApprovedDaysUsed** = approved days recorded as consumed against the relevant annual balance.
- **RemainingBalanceDays** = entitlement still available after recorded usage.

Pending and rejected requests do not reduce annual vacation entitlement in this simplified case study. An unapproved request is therefore not consumed leave. Available/unused entitlement is represented by `RemainingBalanceDays`.

## Why This Does Not Read Like a Beginner SQL Exercise

The strength of the analysis is not the number of SQL functions used. It is the progression of the investigation:

**summary → segmentation → actionable follow-up → cross-table analysis → missing activity → balance analysis → exception investigation**

The queries are tied to business questions, use related tables where needed, show actual outputs, and distinguish what the data supports from what would require additional context.

## Full Query Set

See [leave_analysis.sql](leave_analysis.sql).

## Why This Matters for a BA

These queries demonstrate how SQL can support Business Analyst work by answering stakeholder questions, validating and summarizing data, investigating exceptions and supporting management reporting without presenting the analyst as a SQL developer.

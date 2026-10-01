# SQL Analysis

This section extends the Employee Leave Management case study from workflow and QA analysis into practical data investigation.

## Business questions

The SQL work uses the same synthetic leave-management domain to answer practical questions a BA or Functional Analyst may investigate, including:

- What is the distribution of leave requests by status?
- Which departments generate the most leave activity?
- Which employees have no leave requests?
- Which employees have submitted more than two requests?
- Who has a low or exhausted leave balance?
- Which requests remain pending?
- Which leave types account for the most approved leave?
- How does request volume change by month?
- Are there leave-balance exceptions that should be investigated?
- Which employees have below-average remaining leave balance?
- Which employees currently have a pending request?

## SQL techniques demonstrated

The queries are intentionally kept practical and interview-explainable for a Business Analyst / Functional Analyst profile.

- INNER JOIN
- LEFT JOIN
- WHERE and ORDER BY
- GROUP BY and HAVING
- COUNT, SUM and AVG
- CASE
- IS NULL
- Date grouping with SQLite `strftime`
- Two simple subqueries

## Join example

```sql
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;
```

This combines employee master data with leave transactions so activity can be analysed by department.

## Simple subquery example

```sql
SELECT EmployeeID, EmployeeName, Department
FROM Employees
WHERE EmployeeID IN (
    SELECT EmployeeID
    FROM LeaveRequests
    WHERE Status = 'Pending'
)
ORDER BY EmployeeID;
```

This identifies employees who currently have a pending leave request.

## Date analysis example

```sql
SELECT strftime('%Y-%m', RequestDate) AS RequestMonth,
       COUNT(*) AS RequestCount,
       SUM(RequestedDays) AS RequestedDays
FROM LeaveRequests
GROUP BY strftime('%Y-%m', RequestDate)
ORDER BY RequestMonth;
```

This groups leave activity by month to support trend analysis.

## Business-rule / data-quality investigation

```sql
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays;
```

The result is treated as an exception to investigate rather than automatically assuming the data is wrong. A BA would clarify the business rule and expected behaviour before recommending a change.

## Full practical query set

See [leave_analysis.sql](leave_analysis.sql).

## Power BI

The same four-table dataset is used in the Power BI report. The completed report includes KPI cards for total requests, approved requests, pending requests and requested days; analysis by department and leave type; request-status distribution; monthly trend; and Department and Status slicers.

Actual Power BI Desktop dashboard and data-model screenshots are included in the [Power BI section](../12-power-bi/POWER_BI_DASHBOARD.md).

# SQL Analysis

This section extends the Employee Leave Management case study from workflow and QA analysis into practical data investigation.

## Business questions

The SQL work uses the same synthetic leave-management domain to answer questions a BA or Functional Analyst may investigate:

- What is the distribution of Approved, Pending, Rejected and Cancelled requests?
- Which departments generate the most leave activity?
- Which employees have no leave requests?
- Which employees have submitted more than two requests?
- Who has a low or exhausted leave balance?
- Which requests remain pending?
- Which leave types account for the most approved leave?
- How does request volume change by month?
- Are there data exceptions that should be checked against the business rules?

## Techniques demonstrated

INNER JOIN, LEFT JOIN, WHERE, GROUP BY, HAVING, CASE, NULL checks, aggregate functions and date grouping.

## Example: department-level analysis

```sql
SELECT e.Department,
       COUNT(lr.LeaveRequestID) AS TotalRequests,
       SUM(lr.RequestedDays) AS TotalRequestedDays
FROM Employees e
JOIN LeaveRequests lr ON e.EmployeeID = lr.EmployeeID
GROUP BY e.Department
ORDER BY TotalRequests DESC;
```

This connects employee master data with leave transactions so leave volume can be analysed in a business context.

## Example: business-rule/data-quality investigation

```sql
SELECT e.EmployeeID, e.EmployeeName, e.Department,
       lb.AnnualEntitlementDays, lb.ApprovedDaysUsed,
       lb.RemainingBalanceDays
FROM Employees e
JOIN LeaveBalances lb ON e.EmployeeID = lb.EmployeeID
WHERE lb.ApprovedDaysUsed > lb.AnnualEntitlementDays;
```

This query deliberately treats the result as an exception to investigate, rather than automatically assuming the data is wrong. A BA would clarify the policy and expected behaviour before recommending a change.

## Full practical query set

See [leave_analysis.sql](leave_analysis.sql).

## Power BI

The same four-table dataset can be used to build a Power BI model and dashboard. The intended report contains KPI cards for total requests, approved requests, pending requests and requested days; leave by department and type; request-status distribution; monthly trend; and Department, Status and Leave Type slicers.

The Power BI section will only be represented as completed practical work once the report is rebuilt and actual report/model screenshots are available.

# Power BI Dashboard

## Objective

Extend the Employee Leave Management case study into a simple interactive management view using the same synthetic dataset used for SQL analysis.

The report answers practical questions such as:

- How many leave requests have been submitted?
- How many are Approved or Pending?
- What proportion of requests are approved?
- Which departments generate the most leave activity?
- Which leave types are used most often?
- How does request volume change by month?
- Which leave-balance records require HR review?

## Data Model

The Power BI model uses four tables:

- **Employees** - employee master data
- **LeaveRequests** - leave-request transactions
- **LeaveTypes** - leave-type reference data
- **LeaveBalances** - employee leave balances

Relationships used in the model:

| From | To | Cardinality |
|---|---|---|
| Employees[EmployeeID] | LeaveRequests[EmployeeID] | 1 : many |
| LeaveTypes[LeaveTypeID] | LeaveRequests[LeaveTypeID] | 1 : many |
| Employees[EmployeeID] | LeaveBalances[EmployeeID] | 1 : 1 |

### Actual Power BI Model

![Power BI data model](POWER_BI_DATA_MODEL.jpg)

## DAX Measures

The report uses straightforward measures focused on management questions.

```DAX
Total Requests =
COUNTROWS(LeaveRequests)

Approved Requests =
CALCULATE(
    [Total Requests],
    LeaveRequests[Status] = "Approved"
)

Pending Requests =
CALCULATE(
    [Total Requests],
    LeaveRequests[Status] = "Pending"
)

Total Requested Days =
SUM(LeaveRequests[RequestedDays])

Approval Rate % =
DIVIDE(
    [Approved Requests],
    [Total Requests],
    0
)

Leave Balance Exceptions =
COUNTROWS(
    FILTER(
        LeaveBalances,
        LeaveBalances[ApprovedDaysUsed] >
        LeaveBalances[AnnualEntitlementDays]
    )
)
```

The measures are intentionally simple and focused on the business questions being analysed.

## DAX Learning Notes

This section records the reasoning and syntax used in the case study so the formulas can be reviewed later.

### Normal Column vs Calculated Column vs Measure

| Type | Meaning | Example in this case study |
|---|---|---|
| Normal/source column | A field already present in the imported data | Department, Status, ApprovedDaysUsed |
| Calculated column | A new value calculated for each row using DAX | Balance Exception = Review / OK |
| Measure | A dynamic aggregate calculated for the current filter context | Total Requests, Approval Rate %, Leave Balance Exceptions |

A useful rule:

- **Column = something about each row**
- **Measure = something about the current set of rows**

### Calculated Column: Balance Exception

```DAX
Balance Exception =
IF(
    LeaveBalances[ApprovedDaysUsed] >
    LeaveBalances[AnnualEntitlementDays],
    "Review",
    "OK"
)
```

General syntax:

```DAX
IF(condition, value_if_true, value_if_false)
```

DAX does not require a separate `ELSE` keyword here. The third argument is the ELSE result.

Business meaning:

- If ApprovedDaysUsed is greater than AnnualEntitlementDays, classify that employee balance record as **Review**.
- Otherwise classify it as **OK**.

The calculated column can then be used as a visual-level filter:

`Balance Exception = Review`

This allows the exception table to show only the employee records that require investigation.

### Measure: Leave Balance Exceptions

```DAX
Leave Balance Exceptions =
COUNTROWS(
    FILTER(
        LeaveBalances,
        LeaveBalances[ApprovedDaysUsed] >
        LeaveBalances[AnnualEntitlementDays]
    )
)
```

Read the formula from the inside outward:

1. `FILTER(table, condition)` starts with the LeaveBalances table and keeps only rows where ApprovedDaysUsed > AnnualEntitlementDays.
2. `COUNTROWS(table)` counts the rows returned by FILTER.
3. In the current synthetic dataset, this produces **2 exception records**.

General syntax:

```DAX
FILTER(table, condition)
COUNTROWS(table)
```

The calculated column answers **which records require review**. The measure answers **how many records require review**.

### Why the Field Is Called ApprovedDaysUsed

`RequestedDays` and `ApprovedDaysUsed` represent different business concepts.

- **RequestedDays** = days submitted in a leave request.
- **ApprovedDaysUsed** = approved days recorded as consumed against the relevant leave balance.
- **RemainingBalanceDays** = entitlement still available after recorded usage.

In this case study, pending and rejected requests do not reduce the annual vacation balance. Therefore an unapproved request is **not consumed leave**. However, it is clearer not to call the request itself "unused leave." **Unused/available leave is represented by RemainingBalanceDays.**

Because this simplified balance table represents annual vacation entitlement, a more explicit business name could be **ApprovedVacationDaysUsed**. The source column remains `ApprovedDaysUsed`, but the case-study meaning is approved vacation usage counted against annual entitlement.

## Dashboard

The report includes:

- KPI cards for Total Requests, Approved Requests, Pending Requests, Total Requested Days and Approval Rate %
- Leave Requests by Department
- Leave Requests by Type
- Request Status
- Monthly Leave Request Trend
- Department and Status dropdown slicers
- Leave Balance Exceptions Requiring Review table

The exception table uses the calculated column `Balance Exception` as a visual-level filter and displays Employee Name, Department, Annual Entitlement, Approved Days Used and Remaining Balance.

### Actual Power BI Dashboard

![Employee Leave Management Power BI dashboard](POWER_BI_DASHBOARD.jpg)

The original dashboard screenshot is retained until the final report layout is saved and a new screenshot is captured.

## Interpretation Notes

- Request counts by department show **volume**, not absence rate. Department headcount would be needed before concluding that one department has a higher absence rate.
- An exception is a record requiring investigation, not automatically a data error. Carry-forward leave, adjustments or policy rules not represented in the simplified dataset could explain the result.
- Total Requested Days represents days **requested**, not necessarily days actually taken.

## What This Demonstrates

This Power BI work connects:

**Business question -> data model -> DAX measure -> visual -> interpretation -> management action**

The objective is to demonstrate practical data analysis and reporting capability relevant to Business Analyst and Business Systems Analyst work, rather than advanced BI development.

## Case Study Note

The report was built in Power BI Desktop using the same synthetic Employee Leave Management data used for the SQL analysis. The screenshots show the actual report page and data model created for this portfolio case study.

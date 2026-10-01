# Power BI Dashboard

## Objective

Extend the Employee Leave Management case study into an interactive management view using the same synthetic dataset used for SQL analysis.

The dashboard is designed to answer practical questions such as:

- How many leave requests have been submitted?
- How many are Approved or still Pending?
- Which departments generate the most leave activity?
- Which leave types are used most often?
- How does request volume change over time?
- Can a user filter the analysis by department, status or leave type?

## Data Model

Use these four tables:

- **Employees** - one row per employee
- **LeaveRequests** - transactional leave-request records
- **LeaveTypes** - one row per leave type
- **LeaveBalances** - one row per employee in this synthetic dataset

Recommended relationships:

| From | To | Cardinality |
|---|---|---|
| Employees[EmployeeID] | LeaveRequests[EmployeeID] | 1 : many |
| LeaveTypes[LeaveTypeID] | LeaveRequests[LeaveTypeID] | 1 : many |
| Employees[EmployeeID] | LeaveBalances[EmployeeID] | 1 : 1 |

Use single-direction filtering from the dimension/master tables into the transactional table where applicable.

## Measures

Create these measures in Power BI:

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

Approval Rate =
DIVIDE(
    [Approved Requests],
    [Total Requests],
    0
)
```

## Dashboard Layout

### KPI cards

1. Total Requests
2. Approved Requests
3. Pending Requests
4. Total Requested Days

### Visuals

**Leave Requests by Department**
- Visual: clustered bar chart
- Axis: Employees[Department]
- Value: Total Requests

**Requests by Leave Type**
- Visual: clustered column chart
- Axis: LeaveTypes[LeaveType]
- Value: Total Requests

**Request Status**
- Visual: donut chart
- Legend: LeaveRequests[Status]
- Value: Total Requests

**Monthly Leave Trend**
- Visual: line chart
- Axis: LeaveRequests[RequestDate] by month
- Value: Total Requests

### Slicers

- Department
- Status
- Leave Type

## Suggested Page Structure

```text
EMPLOYEE LEAVE MANAGEMENT | HR ANALYTICS

[ Total Requests ] [ Approved ] [ Pending ] [ Requested Days ]

[ Requests by Department       ] [ Request Status       ]

[ Monthly Request Trend        ] [ Requests by Type     ]

[ Department ] [ Status ] [ Leave Type ]
```

## What This Demonstrates

This dashboard is intended to demonstrate more than visual creation. It connects:

**Business question -> data model -> measure -> visual -> interpretation**

That makes the Power BI work relevant to Business Analyst and Business Systems Analyst roles rather than positioning the project as a standalone data-analyst exercise.

## Evidence

Once the report is rebuilt in Power BI Desktop, add:

- `POWER_BI_MODEL.png` - screenshot of Model view
- `POWER_BI_DASHBOARD.png` - screenshot of the finished report page

Those screenshots should come from the actual Power BI report so the portfolio remains fully interview-defensible.

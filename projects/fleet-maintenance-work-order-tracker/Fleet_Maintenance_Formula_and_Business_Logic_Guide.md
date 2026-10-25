# Formula and Business Logic Guide

**Project:** Simulated Fleet Maintenance Work Order Tracker  
**Purpose:** Explain the Excel calculations and desktop automation rules used for monitoring maintenance work.

## Work Orders: row-level calculations

Examples use row 2; formulas are filled down for other work orders.

### Assignee type: XLOOKUP
```excel
=XLOOKUP(H2,Assignee_Lookup!$A$2:$A$7,Assignee_Lookup!$B$2:$B$7,"Not Found")
```
- `H2`: assignee to find.
- `$A$2:$A$7`: fixed lookup range; `$B$2:$B$7`: corresponding assignee type.
- `"Not Found"`: returned when the assignee is missing from the lookup.

**Why it matters:** Provides consistent assignee categories for reporting and cost analysis.

### Ageing: IF and TODAY
```excel
=IF(P2<>"",P2-G2,TODAY()-G2)
```
- `P2<>""`: checks whether a completion date exists.
- `P2-G2`: days between completion and reported date.
- `TODAY()-G2`: days since reporting when incomplete.

**Why it matters:** Measures elapsed time from reporting; it is **not** the number of days past the due date.

### Overdue flag: IF and AND
```excel
=IF(AND(O2<TODAY(),K2<>"Completed",K2<>"Closed"),"Yes","No")
```
- `O2<TODAY()`: due date has passed.
- `K2<>"Completed"` and `K2<>"Closed"`: work remains unfinished.
- `AND`: requires all conditions; `IF`: returns Yes or No.

**Why it matters:** Supports overdue reporting and follow-up prioritization. Blank due-date handling could be improved in a future version.

### Approval action: IF and AND
```excel
=IF(AND(M2="Yes",N2="Pending"),"Approval Follow-up","No Approval Action")
```
Checks whether approval is required (`M2`) **and** still pending (`N2`). The output identifies records needing follow-up.

## Summary dashboard: key formulas

| Metric | Formula | Interpretation |
|---|---|---|
| Total work orders | `=COUNTA('Work Orders'!A2:A200)` | Non-empty IDs |
| Open | `=COUNTIFS('Work Orders'!K2:K200,"<>Closed",'Work Orders'!K2:K200,"<>Completed",'Work Orders'!A2:A200,"<>")` | IDs with unfinished status |
| High priority | `=COUNTIF('Work Orders'!F2:F200,"High")` | High-priority records |
| Overdue | `=COUNTIF('Work Orders'!R2:R200,"Yes")` | Overdue flags |
| Approvals Requiring Action | `=COUNTIFS('Work Orders'!M2:M200,"Yes",'Work Orders'!N2:N200,"Pending")` | Approvals requiring action (distinct from work-order status) |
| Estimated cost | `=SUM('Work Orders'!L2:L200)` | Estimated cost for supported rows |
| Report date | `=TODAY()` | Current calculation date |
| High priority & overdue | `=COUNTIFS('Work Orders'!F2:F200,"High",'Work Orders'!R2:R200,"Yes")` | Both conditions true |
| Engine repair cost | `=SUMIF('Work Orders'!D2:D200,"Engine",'Work Orders'!L2:L200)` | Cost for Engine issues |
| High-priority vendor cost | `=SUMIFS('Work Orders'!L2:L200,'Work Orders'!F2:F200,"High",'Work Orders'!I2:I200,"Vendor")` | Cost for High-priority vendor work |
| Status breakdown | `=COUNTIF('Work Orders'!K2:K200,D4)` | Count matching the status label in D4 |

### Syntax reference

- `COUNTIF(range, criteria)`: count one condition.
- `COUNTIFS(range1, criteria1, range2, criteria2, ...)`: count multiple conditions.
- `SUMIF(criteria_range, criteria, sum_range)`: sum values matching one condition.
- `SUMIFS(sum_range, criteria_range1, criteria1, ...)`: sum values matching multiple conditions.
- `COUNTA(range)`: count non-empty cells.
- `TODAY()`: current date, recalculated by Excel.

**Definition resolved for this simulated project:** The approval-action KPI uses both columns M and N. A separate status distribution can still count `Work Order Status = Pending Approval`; the two measures are not interchangeable. The cost formula is limited to rows 2:200. See the [defect register](FLEET_QA_DEFECT_REGISTER.md).

## Power Automate Desktop: rule walkthrough

1. Open the local workbook and select `Work Orders`.
2. Find the first free row in Work Order ID column A, subtract one, then read `A1:T%FirstFreeRowOnColumn%` into `ExcelData` using row 1 as headers. This assumes contiguous populated IDs.
3. Initialize `TotalWorkOrders`, `OverdueCount`, and `PendingApprovalCount` to zero.
4. For each `CurrentItem` in `ExcelData`:
   - If Work Order ID is nonempty, increment `TotalWorkOrders` and evaluate the following conditions.
   - IF `CurrentItem['Overdue?'] = 'Yes'`, increment `OverdueCount`.
   - Independently, IF `CurrentItem['Approval Required'] = 'Yes'` AND `CurrentItem['Approval Status'] = 'Pending'`, increment `PendingApprovalCount`.
5. Display the summary and write it to a local text file.

**Why it matters:** The two IF checks are inside the loop but independent, so a pending approval is counted whether or not the work order is overdue. The flow uses Excel's overdue flag rather than recalculating dates.

**Verified local main run:** 13 work orders, 8 overdue, 2 approval actions pending; popup and saved report checked. **Separate UAT copy:** 14 work orders, 0 overdue, 0 pending; Power Query, dashboard and cost PivotTable reconciled after refresh. Historical 10 / 7 / 1 screenshots remain in the repository and are labeled historical.

## Scope and potential refinements

This is a simulated portfolio project, not a production deployment. It uses Power Automate Desktop for local reporting, not a deployed Power Apps or cloud approval workflow. Potential improvements include blank-date validation, fully expandable structured references, and tests for gaps in Work Order IDs and larger datasets.

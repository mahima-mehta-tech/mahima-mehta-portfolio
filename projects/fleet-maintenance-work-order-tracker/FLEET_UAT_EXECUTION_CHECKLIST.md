# Fleet Maintenance — Nine-Case UAT Execution Checklist

**Status:** Prepared for execution. This checklist does not replace or retrospectively alter the original PDF's actual execution record. Test IDs here are a proposed mapping pending reconciliation with the nine original cases.

| Case | Scenario | Expected result | Execution |
|---|---|---|---|
| UAT-01 | Work-order register with valid sample records | All work orders included once; no missing IDs | Not executed in this update |
| UAT-02 | Overdue, unfinished order | Flag = Yes; overdue KPI includes order | Not executed in this update |
| UAT-03 | Completed or closed order with past due date | Flag = No; excluded from overdue KPI | Not executed in this update |
| UAT-04 | Non-overdue order requiring approval with status Pending | Included in pending-approval KPI and automation regardless of overdue flag | Not executed in this update |
| UAT-05 | Approval Required = No and Approval Status = Pending | Excluded from *approval action required* KPI under BR-02 | Not executed in this update |
| UAT-06 | New work order added after row 11 with estimated cost | Total estimated cost increases by exactly the new cost | Not executed in this update |
| UAT-07 | Status and priority dashboard totals | KPI and distribution reconcile to source records | Not executed in this update |
| UAT-08 | Desktop automation overdue and pending-approval counts | Counts match BR-01 and BR-02, and dashboard | Not executed in this update |
| UAT-09 | Invalid/blank due date and missing approval fields | Exception handling follows agreed validation rule; no false positive | Not executed in this update |

## Execution evidence template
For each test record: execution date, tester, input work-order ID, preconditions, expected result, actual result, Pass/Fail/Blocked, screenshot or workbook cell reference, linked defect ID and retest result.

## Test data to add
- An unfinished order with due date in the future, Approval Required = Yes, Approval Status = Pending.
- A record beyond row 11 with known estimated cost, e.g. CAD 500.
- An order with Approval Required = No, Approval Status = Pending to test the stricter action-required definition.

**Do not overwrite existing evidence or mark these cases Passed without performing the checks in the actual workbook and, for UAT-08, Power Automate Desktop.**

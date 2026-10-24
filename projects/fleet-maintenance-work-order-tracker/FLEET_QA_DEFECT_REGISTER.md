# Fleet Maintenance — QA Defect Register and Retest Plan

> **Status: identified from documented formulas; fix and retest pending.** The original workbook and PDF UAT evidence have not yet been re-executed in this review. Do not describe these as fixed or passed.

| ID | Severity | Observation / expected behaviour | Documented current behaviour | Proposed correction | Retest |
|---|---|---|---|---|---|
| FLEET-DEF-01 | Medium | Dashboard **Pending Approval** should use a clearly agreed definition of approvals awaiting action. If this means approval required = Yes and approval status = Pending, count columns M and N. | Formula guide counts `K="Pending Approval"` while desktop automation counts `N="Pending"`; definitions can diverge. | Confirm definition with stakeholder. For approvals requiring action, use `=COUNTIFS('Work Orders'!M2:M200,"Yes",'Work Orders'!N2:N200,"Pending")`; align dashboard, flow and BRD. | Pending workbook update and execution |
| FLEET-DEF-02 | Medium | Estimated cost should include every populated work order in the supported range. | Formula guide uses `=SUM('Work Orders'!L2:L11)`, which omits new rows after 11. | Use an Excel Table with `=SUM(WorkOrders[Estimated Cost])` (after verifying table/column names), or interim `=SUM('Work Orders'!L2:L200)`. | Pending workbook update and execution |

## Suggested test data and checks
1. Add a **not-overdue, approval-required, Pending** work order; confirm it is included in pending approvals regardless of overdue status.
2. Add a work order **after row 11** with a known nonzero estimated cost; verify the total increases by exactly that amount.
3. Check a work order with approval status Pending but approval required No; under the proposed *action required* definition, it must not be counted.
4. Confirm the desktop automation and dashboard use the same agreed definition, or explicitly label the metrics differently.
5. Rerun the full nine-case UAT suite and record actual results, evidence, date and tester.

## Test execution log
| Test | Execution status | Actual result | Evidence |
|---|---|---|---|
| Pending-approval definition | Not executed in this update | — | — |
| Cost total expands beyond row 11 | Not executed in this update | — | — |
| Nine-case regression suite | Not executed in this update | — | Original PDF UAT must be reviewed |

**Important:** Existing screenshot evidence reports a successful ten-record automation run (7 overdue, 1 pending), not validation of the proposed new scenarios.

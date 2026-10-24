# Fleet Maintenance — Verification and Release Status

**Review date:** 23 October 2026 (portfolio simulation)  
**Source:** Excel workbook saved after desktop **Data > Refresh All**, `Fleet_Tracker_Repair_Download_v2(1).xlsx`.  
**Status:** **Excel reporting reconciled; Power Automate Desktop UAT not yet completed. Do not label the entire project fully tested.**

## Verified Excel results

| Measure | Refreshed result | Evidence / rule |
|---|---:|---|
| Total work orders | 13 | Summary B4, all 13 work-order records |
| Open work orders | 11 | Summary B5 |
| High priority | 3 | Summary B6 |
| Overdue | 8 | Summary B7; date-dependent, will change with TODAY() |
| Approval actions pending | 2 | Summary B8: Approval Required = Yes **and** Approval Status = Pending |
| Total estimated cost | CAD 13,760 | Summary B9, includes CAD 1,050 across three added QA records |
| Work-order status = Pending Approval | 1 | Separate status distribution metric (Summary E7), **not** the approval-action KPI |

The original dataset had 10 records and CAD 12,710 estimated cost. Three **synthetic** QA records add CAD 350, CAD 500, and CAD 200. Pivot cache shows 13 records; three PivotTable definitions and the Power Query connection remain in the refreshed file. Both source tables extend through the 13 records.

**Important:** The `Ageing (Days)` values on the added rows are calculated by formula. Verify their number formatting as *Number* in Excel if displayed as dates. A date-sensitive overdue count is only a snapshot, not a fixed acceptance target.

## Business rule decision

Original BRD: `Approval Status = Pending`.  
Revised BRD / dashboard: `Approval Required = Yes AND Approval Status = Pending`.

The revised definition is a **proposed change to the original requirement**, not a previously approved requirement. The dashboard uses it. The PAD flow must be updated to use both conditions, or the business rule must be formally reverted across all artifacts. A record with Approval Required = No and Approval Status = Pending is deliberately excluded from the approval-action count.

## Defect register

| Defect | Original issue | Fix / evidence | Status |
|---|---|---|---|
| DEF-01 | Dashboard counted Work Order Status = Pending Approval, not approval-action fields | B8 uses COUNTIFS on Approval Required and Approval Status; refreshed workbook shows 2 | **Excel retest supported; PAD retest pending** |
| DEF-02 | Estimated cost SUM(L2:L11) excluded new rows | B9 uses SUM(L2:L200); 13 records total CAD 13,760 and cost PivotTable reconciles | **Excel retest supported** |

## Nine original UAT scenarios

| ID | Historical test result on 10-record data | Current 13-record/PAD status |
|---|---|---|
| UAT-01 | Pass: read 10 | **Not rerun in PAD**: expect 13 |
| UAT-02 | Pass: overdue 7 | **Not rerun in PAD**: compare to current date-sensitive Excel overdue result |
| UAT-03 | Pass: pending 1 | **Not rerun in PAD**: expect 2 under revised approval-action definition |
| UAT-04 | Pass: display 10/7/1 | **Not rerun in PAD**: reconcile updated display |
| UAT-05 | Pass: report 10/7/1 | **Not rerun in PAD**: verify new saved report |
| UAT-06 | IF structure checked; edge case not run | **Not run**: test non-overdue approval pending |
| UAT-07 | Visual check only | **Partial**: Excel metrics reconciled, PAD output not compared |
| UAT-08 | Not run | **Not run**: zero-overdue and zero-pending cases |
| UAT-09 | Not run | **Partial**: Excel includes 13; PAD import/report not retested |

**Do not change the historical five Pass results to current Pass.** Retest requires actual flow execution and dated screenshots/report output.

## Desktop PAD execution checklist (requires local environment)

1. Save a copy of the refreshed workbook and record the execution date/time.
2. Inspect the flow's pending count: apply **both** Approval Required = Yes and Approval Status = Pending; do not filter on Work Order Status for approval-action KPI.
3. Run PAD against the 13-record workbook. Capture imported count, overdue count, pending count, on-screen summary, and saved report. Compare overdue to Excel **at run time**.
4. Test WO-QA-1011 (non-overdue + pending approval), WO-QA-1012 (additional cost row), and WO-QA-1013 (Pending but Approval Required = No).
5. Run isolated zero-overdue and zero-pending scenarios on a test copy. Confirm no false-positive exceptions.
6. Save screenshots, report output, date/time, observed/expected values, and actual Pass/Fail per UAT ID.
7. Only then change this release status to **UAT complete** and publish revised artifacts.

## Publication note

The documentation in this draft PR is review material, not evidence of a completed desktop automation run. Do not merge or claim end-to-end test completion until the checklist has actual results. The revised workbook binary is not yet uploaded to this PR.

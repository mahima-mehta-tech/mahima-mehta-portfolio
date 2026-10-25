# Fleet Maintenance — UAT Execution Record (Original Nine Cases)

**Updated:** 25 October 2026  
**Test basis:** Original nine-case UAT PDF plus subsequent local PAD and Excel UAT runs.  
**Environments:** Main workbook (13 records); separate UAT copy (13 records for zero cases, 14 after adding WO-QA-1014).  
**Scope:** Simulated local tests, not formal business-user acceptance sign-off.

| ID | Original test case | Actual evidence | Result |
|---|---|---|---|
| UAT-01 | Read work orders | PAD main 13 records; new-record UAT copy 14 | Pass |
| UAT-02 | Overdue count | Main 8; zero-overdue copy 0 | Pass |
| UAT-03 | Pending approval count | Main 2 under revised rule; zero-pending copy 0 | Pass |
| UAT-04 | Display summary | Main 13 / 8 / 2; new-record copy 14 / 0 / 0 | Pass |
| UAT-05 | Write report | User verified saved main text report 13 / 8 / 2 | Pass |
| UAT-06 | Independent IF checks | Separate overdue and approval conditions, including Approval Required = No / Pending exclusion | Pass for tested cases |
| UAT-07 | Dashboard comparison | After Refresh All: UAT copy 14 records, Power Query includes WO-QA-1014; Summary and cost PivotTable CAD 13,960 | Pass for tested scenario |
| UAT-08 | Zero-exception cases | UAT copy runs 13 / 0 / 2 and 13 / 0 / 0 | Pass |
| UAT-09 | Additional records | UAT copy row 15 read dynamically; PAD total 14 | Pass |

## Test evidence and boundaries
- Main PAD popup and saved text report were checked at 13 / 8 / 2.
- UAT copy was deliberately modified for negative/zero scenarios; its results are not the main workbook baseline.
- A copied row initially had a duplicate ID; it was corrected to `WO-QA-1014` before the reporting refresh and reconciliation.
- The UAT-copy dashboard reported 14 work orders, 0 overdue, 0 pending approval actions, and CAD 13,960 estimated cost. The cost PivotTable grand total matched.
- Earlier repository screenshots show the original 10-record run and should be labeled historical until replaced with current screenshots.

**Remaining limitations:** No production sign-off, no large-volume testing, and no verified handling of gaps in Work Order ID column A. The UAT PDF containing the final local record has not yet been uploaded to GitHub.

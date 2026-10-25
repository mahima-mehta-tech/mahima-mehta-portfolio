# Fleet Maintenance: Verification and Release Status

**Updated:** 25 October 2026  
**Project:** simulated portfolio case study  
**Status:** Local PAD and 14-record reporting UAT checks completed; final workbook, PDFs and six current screenshots published on `main` via pull request #1. Historical evidence remains explicitly identified.

## Tested environments

| Environment | Total | Overdue | Approval actions pending | Cost |
|---|---:|---:|---:|---:|
| Main repaired workbook | 13 | 8 | 2 | CAD 13,760 |
| UAT test copy, after new work order | 14 | 0 | 0 | CAD 13,960 |

The main PAD popup and saved text report were user-confirmed at **13 / 8 / 2**. Date-sensitive overdue results are snapshots. The test copy was intentionally modified for zero-exception tests; it must not replace the main workbook.

## Business rules
- Approval action pending = `Approval Required = Yes` AND `Approval Status = Pending`. The original 10-record BRD used a broader rule, which was revised for this simulated case study.
- Overdue is evaluated from the workbook's `Overdue?` field; the date-sensitive calculation must be checked at runtime.
- The status category `Pending Approval` is distinct from the approval-action KPI.

## Test results

| Original UAT ID | Scenario | Latest evidence | Status |
|---|---|---|---|
| UAT-01 | Read work orders | Main PAD reads 13; UAT copy reads 14 after new record | Pass |
| UAT-02 | Overdue count | Main PAD 8, zero-overdue UAT copy 0 | Pass |
| UAT-03 | Pending approvals | Main PAD 2; zero-pending UAT copy 0 | Pass |
| UAT-04 | Display summary | Main popup 13 / 8 / 2; UAT copy 14 / 0 / 0 | Pass |
| UAT-05 | Write report | Main saved text report user-confirmed 13 / 8 / 2 | Pass |
| UAT-06 | Independent conditional checks | Approval-required Yes/Pending and No/Pending test cases; separate counters | Pass for tested cases |
| UAT-07 | Dashboard comparison | UAT copy: 14 records, Power Query includes WO-QA-1014, Summary and cost PivotTable both CAD 13,960 | Pass for tested scenario |
| UAT-08 | Zero-exception cases | UAT copy 13 / 0 / 2 and 13 / 0 / 0 | Pass |
| UAT-09 | Additional records | UAT copy new row 15 detected by PAD; 14 records read without editing end row | Pass |

These are simulated local checks, not formal business-user sign-off. Historical 10-record results (10 / 7 / 1) remain historical and are not presented as the current baseline.

## PAD dynamic row implementation
1. Launch Excel and activate `Work Orders`.
2. Use **Get first free row on column** for column A.
3. Decrease that value by 1 to get the last populated row.
4. Read columns A:T, from row 1 through that row, with headers.
5. For each nonempty Work Order ID, increment total and evaluate overdue and approval-required/pending conditions independently.
6. Display popup and write local text report.

**Limitations:** Column A must be contiguous; large-scale performance, missing IDs within the register, and workbook formula ranges beyond row 200 were not tested.

## Defect retests
- **DEF-01:** Pending approval definition aligned between Summary and PAD. Main count = 2; exclusion scenario exercised.
- **DEF-02:** Estimated cost range expanded; main Summary CAD 13,760. New UAT row CAD 200 included, with UAT Summary and PivotTable CAD 13,960.

## Publication status

Pull request #1 was merged into `main` on 25 October 2026 (squash merge `255c6161ac40303bf75bd0e5ee0faa606762bb9c`). The final workbook `Fleet_Maintenance_Work_Order_Tracker.xlsx`, BRD v2.0 (`Fleet_BRD_Final.pdf`), UAT v2.1 (`Fleet_Maintenance_UAT_Final.pdf`), and six current screenshots are published and linked in the project README. The workbook KPI **Approvals Requiring Action** is distinct from the status **Pending Approval**. Historical 10-record evidence is retained for traceability and should not be used as the current baseline.

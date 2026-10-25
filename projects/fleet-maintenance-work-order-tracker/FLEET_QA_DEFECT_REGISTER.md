# Fleet Maintenance — QA Defect Register and Retest Results

**Updated:** 25 October 2026  
**Scope:** Simulated Excel workbook and PAD automation.

| ID | Severity | Original defect | Correction | Retest evidence | Status |
|---|---|---|---|---|---|
| FLEET-DEF-01 | Medium | Dashboard approval-action count used Work Order Status while PAD used Approval Status, causing inconsistent definitions | Aligned rule to `Approval Required = Yes` AND `Approval Status = Pending` in dashboard and PAD | Main count 2; UAT copy excludes Approval Required = No / Pending | Retested for sampled scenarios |
| FLEET-DEF-02 | Medium | Estimated-cost total originally covered only rows 2:11, excluding appended records | Expanded supported formula to rows 2:200 | Main CAD 13,760; after appending CAD 200 UAT row, Summary and PivotTable CAD 13,960 | Retested for sampled scenarios |

## Additional validation
- PAD uses column-A first-free-row detection to read appended work orders without editing the end row manually.
- UAT copy confirmed 14 work orders after adding `WO-QA-1014`.
- Zero-overdue and zero-pending scenarios were run on the UAT copy.
- Final UAT report and revised BRD exist as local PDFs; GitHub binary upload is still outstanding.

## Limitations
The revised approval rule is a decision for this simulated case study, not evidence of real stakeholder approval. Formula expansion beyond row 200, large datasets, blank Work Order IDs inside the populated range, and production deployment were not tested.

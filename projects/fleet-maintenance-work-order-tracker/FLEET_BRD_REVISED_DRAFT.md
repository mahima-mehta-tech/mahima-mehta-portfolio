# Fleet Maintenance — Revised Business Requirements and Acceptance Criteria

**Type:** Independent simulated portfolio case study  
**Status:** Requirements implemented and locally tested for the documented scenarios; not formal stakeholder sign-off.

## Business need
Maintenance coordinators need a consistent work-order register and visibility into overdue work, approvals awaiting action, and estimated cost.

## Scope
**Included:** Excel work-order register, Power Query cleaned dataset, Summary dashboard, PivotTables, PAD popup and local text report.  
**Excluded:** production integrations, live work orders, email alerts, cloud approvals, multi-user access and deployment.

## Functional requirements

| ID | Requirement | Acceptance criterion / evidence |
|---|---|---|
| FR-01 | Record equipment, issue, priority, assignee, status, dates and cost | Valid simulated work orders appear in Excel register; main sample has 13 |
| FR-02 | Record whether approval is required and its status | Both approval fields available per record |
| FR-03 | Summarize volumes, status, overdue work and estimated cost | Main Summary shows 13 records / CAD 13,760; UAT copy 14 / CAD 13,960 |
| FR-04 | Prepare reporting data using Power Query | UAT copy refreshed and includes WO-QA-1014 in `Cleaned_Work_Orders` |
| FR-05 | Count overdue work and pending approval actions independently | PAD main run 8 overdue and 2 pending; UAT copy zero scenarios verified |
| FR-06 | Display and save a local work-order summary | PAD popup and text report confirmed at 13 / 8 / 2 |
| FR-07 | Include newly appended work orders without manually changing PAD read range | New UAT row 15 detected; PAD reads 14 records |

## Business rules
- **Overdue:** PAD counts records where the workbook's `Overdue?` column is `Yes`. The workbook's overdue calculation is date-dependent and excludes completed/closed work.
- **Approval requiring action:** `Approval Required = Yes` AND `Approval Status = Pending`, independent of overdue status. A record with `Approval Required = No` and `Approval Status = Pending` is excluded.
- **Estimated cost:** Sum numeric estimated costs in the supported Excel range. The demonstrated formulas cover rows 2:200; unlimited expansion is not claimed.
- **New record detection:** PAD uses the first free row in Work Order ID column A, minus one. This assumes IDs are contiguous with no blank gaps.

## Validation and limitations
- **Main workbook:** 13 work orders, 8 overdue, 2 approval actions pending, CAD 13,760 estimated cost.
- **Separate UAT copy:** zero-overdue and zero-pending scenarios; appended WO-QA-1014; 14 records and CAD 13,960 after Refresh All, reconciled between Summary and estimated-cost PivotTable.
- No production performance test, live workflow, formal stakeholder interviews or business-user sign-off.

The original BRD PDF in the repository documents the earlier 10-record baseline and should be replaced by the revised PDF before publication.

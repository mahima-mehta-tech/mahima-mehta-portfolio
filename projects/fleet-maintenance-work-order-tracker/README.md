# Fleet Maintenance | Work Order & Approval Tracker

## Project Overview
An independent Business Analysis and QA portfolio case study using simulated maintenance work orders. The prototype combines an Excel register, Power Query, a Summary dashboard, PivotTables, and a Power Automate Desktop (PAD) flow that displays and saves a local summary report.

## Business Objectives
- Track work-order status, priority, assignments, due dates, and estimated costs.
- Identify overdue work and approvals requiring action.
- Reconcile source records, reporting outputs, and automated counts.
- Demonstrate requirements traceability and controlled UAT scenarios.

## Business Rules
- **Overdue:** the workbook's `Overdue?` field is `Yes`; this is date-dependent.
- **Approval action pending:** `Approval Required = Yes` **and** `Approval Status = Pending`. This is not the same as `Work Order Status = Pending Approval`.
- **Dynamic PAD import:** determine the last populated row from column A (Work Order ID) and read through that row. This assumes contiguous IDs in column A; gaps and large datasets were not tested.

## Verified Results
| Environment | Total work orders | Overdue | Approval actions pending | Estimated cost |
|---|---:|---:|---:|---:|
| Main workbook (PAD run) | 13 | 8 | 2 | CAD 13,760 (Excel Summary) |
| Separate UAT test copy | 14 | 0 | 0 | CAD 13,960 |

- PAD's main-workbook popup and saved text report were confirmed at **13 / 8 / 2**.
- Separate UAT-copy runs verified **13 / 0 / 2**, **13 / 0 / 0**, and **14 / 0 / 0** for the relevant scenarios.
- After adding `WO-QA-1014` to the UAT copy and using **Refresh All**, the Summary dashboard showed 14 records and CAD 13,960. The `Cleaned_Work_Orders` output included the new ID, and the estimated-cost PivotTable grand total reconciled to CAD 13,960.
- These are local, simulated tests, not formal business-user acceptance or production certification.

## Tools and Skills
- **Excel:** work-order register, formulas, Summary dashboard, PivotTables
- **Power Query:** cleaned reporting dataset and refresh
- **Power Automate Desktop:** column-based dynamic row detection, loops, conditional counting, popup, text report
- **BA/QA:** business rules, BRD, traceability, test scenarios, defect and retest documentation

## Documentation and Artifacts
The repository currently contains historical PDF artifacts and an older workbook. **Updated local binary files have been prepared but are not yet uploaded to this draft branch.** Do not treat the older binaries as the final tested version.

- [Historical BRD PDF](Fleet_Maintenance_BRD.pdf) — original 10-record baseline, superseded by the revised local BRD
- [Historical UAT PDF](Fleet_Maintenance_UAT_TestCases.pdf) — original execution baseline, superseded by the final local UAT report
- [Revised Requirements and Acceptance Criteria](FLEET_BRD_REVISED_DRAFT.md)
- [UAT Execution Record](FLEET_UAT_EXECUTION_CHECKLIST.md)
- [QA Defect Register](FLEET_QA_DEFECT_REGISTER.md)
- [Verification and Release Status](FLEET_VALIDATION_AND_RELEASE_STATUS.md)
- [Historical Excel workbook](Fleet_Maintenance_Work_Order_Tracker_Portfolio.xlsx) — **not the latest repaired workbook**
- [Formula and Business Logic Guide](Fleet_Maintenance_Formula_and_Business_Logic_Guide.md) — historical guide; reconcile with the revised approval rule before release

**Final local files to add to this branch:** `Fleet_Maintenance_Work_Order_Tracker.xlsx`, `Fleet_Maintenance_BRD_Revised.pdf`, `Fleet_Maintenance_UAT_Final.pdf`.

## Historical Screenshots
The screenshots below were captured from the original 10-record prototype and should not be mistaken for current 13/14-record UAT evidence.

### Excel Dashboard
![Historical Excel Dashboard](screenshots/04_excel_dashboard.png)

### PAD Workflow
![Historical PAD Workflow](screenshots/01_automation_excel_and_conditions.png)

### PAD Reporting
![Historical PAD Reporting](screenshots/02_automation_reporting_actions.png)

### Generated Report
![Historical Report](screenshots/03_generated_summary_report.png)

### Historical Successful Automation Test
Original test: 10 work orders / 7 overdue / 1 pending.
![Historical Automation Test](screenshots/05_automation_successful_test.png)

## Limitations
Synthetic data, local desktop execution, no deployed Power Apps application, no cloud approval workflow, no production integrations, and no formal user sign-off. PAD's column-A method assumes contiguous work-order IDs. Excel summary formulas use a finite supported range; automatic expansion beyond that range and performance at scale were not tested.

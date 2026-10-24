# Fleet Maintenance — Business Requirements Document (Revised Draft)

**Project:** Fleet Maintenance Work Order & Approval Tracker  
**Type:** Independent portfolio case study using simulated data  
**Status:** Proposed requirements baseline; workbook implementation and UAT sign-off pending

## 1. Business context and problem
Maintenance supervisors need consistent visibility into work orders, overdue maintenance, priorities, approval follow-ups and estimated cost. Fragmented tracking can make follow-up and reporting difficult.

## 2. Business objectives and success criteria
| Objective | Proposed measurable acceptance criterion |
|---|---|
| Visibility | Every valid work order appears in a single register and summary dashboard |
| Overdue monitoring | Dashboard overdue count agrees with record-level due dates and completion status |
| Approval follow-up | Dashboard pending-approval count agrees with the approved business definition and automation |
| Cost accuracy | Total estimated cost includes newly added work orders, not just the original sample |
| Traceability | Each KPI can be traced to a source column, business rule and validation test |

## 3. Stakeholders
- **Maintenance supervisor:** reviews work order status, overdue work and priority
- **Approver / operations manager:** reviews work orders requiring approval
- **Maintenance coordinator:** maintains work-order data and follows up on exceptions
- **Finance / operations analyst:** reviews estimated cost totals
- **Business analyst / QA tester:** clarifies requirements, tests calculations and records defects

These are proposed roles for a simulated project, not actual interviewed stakeholders.

## 4. Scope
**In scope:** work-order register, due dates, priorities, statuses, approval indicators, estimated costs, dashboard KPIs and desktop reporting.

**Out of scope:** deployed cloud approval workflows, integrations with production fleet systems, purchasing and payment authorization, real-time notifications and production access control.

## 5. Functional requirements
| ID | Business requirement | Acceptance criterion |
|---|---|---|
| FR-01 | Maintenance coordinators can record and review work orders with unique IDs, issue type, priority, assignee, status, due date and estimated cost. | All valid sample work orders are represented in the register. |
| FR-02 | Supervisors can identify overdue work orders in a single view. | An unfinished work order with a due date before today is flagged overdue; completed/closed work is excluded. |
| FR-03 | Supervisors can see work-order totals and counts by status and priority. | Dashboard totals reconcile with the underlying work-order register. |
| FR-04 | Approvers can identify work orders requiring approval that remain pending. | A record counts as pending approval when **Approval Required = Yes** AND **Approval Status = Pending**, regardless of overdue status. |
| FR-05 | Operations and finance can see total estimated cost across all tracked work orders. | Adding a work order after the original ten rows increases the total by its estimated cost. |
| FR-06 | Supervisors can receive a summary of overdue work and approval follow-ups. | Report counts match the same definitions used by the dashboard. |
| FR-07 | Users can identify missing or invalid source values for follow-up. | Missing IDs, due dates or approval values are flagged or explicitly documented as limitations. |

## 6. Business rules
| Rule | Definition |
|---|---|
| BR-01 | Overdue = due date earlier than the evaluation date and work-order status neither Completed nor Closed. |
| BR-02 | Pending approval requiring action = Approval Required is Yes and Approval Status is Pending. |
| BR-03 | A pending approval is counted even when its work order is not overdue. |
| BR-04 | Total estimated cost is the sum of estimated costs for all valid work orders in the supported data range. |
| BR-05 | Open work excludes Completed and Closed statuses. |
| BR-06 | Invalid or blank due dates require separate handling; they should not silently be treated as valid overdue dates. |

## 7. Solution approach (implementation, not business requirements)
The portfolio prototype uses Microsoft Excel for the work-order register and dashboard, Power Query for preparation, and Power Automate Desktop for local reporting. Implementation choices may change without changing the business requirements.

**Proposed Excel formula for pending approvals**
```excel
=COUNTIFS('Work Orders'!M2:M200,"Yes",'Work Orders'!N2:N200,"Pending")
```
**Interim estimated-cost formula**
```excel
=SUM('Work Orders'!L2:L200)
```
A structured Excel Table is preferable for future expansion, after confirming the actual table and field names.

**Automation alignment:** the desktop flow should count pending approval only when both Approval Required = Yes and Approval Status = Pending, if BR-02 is the accepted definition.

## 8. Assumptions and open questions
- Is every Pending approval status meaningful only when approval is required? BR-02 adopts the stricter *action required* definition.
- Are blank due dates allowed?
- Is estimated cost stored as numeric currency for every record?
- How should cancelled work orders be handled?
- Are records after row 200 expected? If yes, a structured Excel Table is required.

## 9. Validation and sign-off
See [QA Defect Register](FLEET_QA_DEFECT_REGISTER.md) and [UAT Execution Checklist](FLEET_UAT_EXECUTION_CHECKLIST.md). **No sign-off is claimed** until the workbook, dashboard and automation are retested and actual results are recorded.

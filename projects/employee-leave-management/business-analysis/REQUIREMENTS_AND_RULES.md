# Business Analysis Summary

## Business Need

Managers and HR need a consistent way to track employee leave requests, approval status, leave balances and usage patterns. The case study focuses on defining the core functional behaviour and using data to support operational visibility.

## Stakeholders

- Employee
- Line Manager
- HR / Administrator

## Core Functional Requirements

- **FR-01:** Employees can submit leave requests with leave type, start date, end date and requested days.
- **FR-02:** Line Managers can review requests for their direct reports and approve or reject them.
- **FR-03:** The system tracks each request through defined statuses such as Pending, Approved, Rejected and Cancelled.
- **FR-04:** Approved vacation usage is reflected in the employee's remaining annual leave balance.
- **FR-05:** HR / Administrators can review leave information and investigate data or balance exceptions.
- **FR-06:** Management reporting provides visibility into request volume, status, department, leave type and monthly trends.

## Core Business Rules

- **BR-01:** A leave request must be associated with a valid employee and leave type.
- **BR-02:** Only an authorized manager can approve or reject a direct report's request.
- **BR-03:** Employees cannot approve their own leave requests.
- **BR-04:** Pending or rejected requests do not reduce the annual vacation balance.
- **BR-05:** Approved vacation usage must not produce a negative remaining annual balance.
- **BR-06:** Cancelled requests are excluded from approved-leave totals.
- **BR-07:** Leave types are handled separately so non-vacation leave does not incorrectly reduce annual vacation balance.
- **BR-08:** Data exceptions, such as approved vacation usage exceeding annual entitlement, are flagged for investigation rather than automatically treated as valid.

## Scope

Included: core leave request workflow, approval status, leave balances, SQL analysis and management reporting.

Excluded: payroll integration, statutory leave calculations, performance testing, mobile design and external HR-system integrations.

## Case Study Note

This is an independent portfolio case study using synthetic data. Requirements and business rules are simplified for demonstration purposes and do not represent the HR policy of a specific organization.

# User Stories and Acceptance Criteria

> Proposed acceptance criteria for an independent synthetic-data case study. These are specifications, not claims of executed tests.

| ID | User story | Acceptance criteria (Given / When / Then) | Related requirements |
|---|---|---|---|
| US-01 | As an employee, I want to submit a leave request so my manager can review it. | **Given** a valid employee and leave type, **when** a request with start/end dates and requested days is submitted, **then** it is recorded with Pending status. | FR-01, FR-03, BR-01 |
| US-02 | As a manager, I want to review direct-report requests so I can approve or reject them. | **Given** a Pending request for a direct report, **when** the authorized manager approves or rejects it, **then** its status reflects the decision. | FR-02, FR-03, BR-02 |
| US-03 | As an employee, I want my requests protected from self-approval so the workflow remains controlled. | **Given** an employee's own request, **when** that employee attempts approval, **then** approval is denied. | FR-02, BR-03 |
| US-04 | As an employee, I want only approved vacation to affect my annual balance so the balance remains accurate. | **Given** a Pending, Rejected or Cancelled vacation request, **when** balances are calculated, **then** its requested days do not reduce the annual vacation balance. | FR-04, BR-04, BR-06 |
| US-05 | As an HR administrator, I want to identify leave-balance exceptions so I can investigate discrepancies. | **Given** recorded approved vacation usage greater than entitlement, **when** the exception check runs, **then** the employee is flagged for investigation rather than silently accepted. | FR-05, BR-05, BR-08 |
| US-06 | As a manager, I want to see request trends so I can prioritize follow-up. | **Given** leave requests with valid status, department and type, **when** I view the report, **then** I can see counts by status, department, type and month and identify Pending requests. | FR-06, BR-01 |

## Validation note
The SQL analysis and Power BI dashboard demonstrate selected reporting and exception scenarios. They do **not** establish that every workflow acceptance criterion above was executed in a functioning leave-approval application. Implementing and testing an approval application is outside this case study's scope.

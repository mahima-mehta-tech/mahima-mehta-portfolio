# Risk Assessment

## Purpose

This document identifies the main business and functional risks considered in the Employee Leave Management Portal QA case study.

Testing effort is prioritized based on the potential impact of failure and the assumed likelihood of defects.

Risk ratings in this case study are illustrative and based on functional complexity and business impact.

In a real project, likelihood would be refined using defect history, production incidents, change scope, architecture, technical complexity, and stakeholder input.

---

## Risk Rating Approach

### Likelihood

Likelihood represents how likely a defect or failure is to occur.

- Low: Unlikely based on the simplicity or stability of the area
- Medium: Possible due to multiple rules, validations, or dependencies
- High: More likely due to complexity, frequent change, or known instability

### Impact

Impact represents the consequence if the failure occurs.

- Low: Minor inconvenience with little business effect
- Medium: Noticeable operational impact but workaround may exist
- High: Significant effect on employee entitlement, workflow, privacy, security, or data integrity

### Risk Priority

Risk Priority considers both likelihood and impact and helps determine where deeper testing should be applied.

---

## Risk Matrix

| Area | Likelihood | Impact | Risk Priority | Reason |
|---|---|---|---|---|
| Leave Request Submission | Medium | High | High | Core entry point involving dates, leave type, validation, balance checks, and request persistence |
| Leave Balance Calculation | Medium | High | Critical | Incorrect calculation can directly affect employee leave entitlement |
| Manager Approval / Rejection | Medium | High | High | Failure can block or incorrectly process the core business workflow |
| Employee Self-Approval | Low | High | High | Less likely if permissions are designed correctly, but failure creates a serious authorization issue |
| Role-Based Access | Medium | High | Critical | Incorrect access can expose or allow unauthorized modification of employee information |
| Status Transitions | Medium | High | High | Invalid transitions can create inconsistent workflow or incorrect leave processing |
| Cancellation and Balance Restoration | Medium | High | High | Incorrect restoration can result in duplicate or missing leave entitlement |
| Duplicate Processing | Medium | High | Critical | Repeated approval or processing may deduct leave more than once |
| Audit Trail | Medium | Medium/High | High | Missing traceability can affect compliance, investigation, and dispute resolution |
| Sick / LWOP / Lieu / Parental Leave | Medium | Medium | Medium | Different leave types must not incorrectly affect annual vacation balance |
| Notifications | Medium | Medium | Medium | Failure may delay processing but does not necessarily break the core workflow |
| UI / Cosmetic Issues | Medium | Low | Low | Usually does not prevent completion of the business process |

---

## Highest-Risk Areas

The following areas receive the deepest testing:

- Leave balance calculation
- Role-based access
- Duplicate processing prevention
- Leave request submission
- Manager approval and rejection
- Status transitions
- Cancellation and balance restoration
- Employee self-approval prevention
- Auditability and data integrity

---

## Release-Blocking Risks

The following conditions may result in a No Go recommendation:

- Incorrect vacation balance calculation
- Leave balance becoming negative unexpectedly
- Duplicate balance deduction
- Employee able to approve their own request
- Unauthorized access to another employee's private information
- Manager able to approve unrelated employees' requests
- Core approval workflow unusable
- Incorrect status after approval or rejection
- Data loss or corruption
- Critical audit trail missing for important actions

---

## Risk-Based Testing Principle

Not every feature receives equal testing effort.

Higher-risk areas are covered with deeper positive, negative, boundary, state-transition, authorization, and regression scenarios.

Lower-risk or secondary features receive representative coverage sufficient to validate the main business rules without expanding the case study unnecessarily.

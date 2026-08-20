# Test Strategy

## 1. Objective

The objective of this test effort is to verify that the Employee Leave Management Portal supports accurate, secure, and reliable leave processing.

Testing will confirm that:

- Employees can submit valid leave requests successfully
- Managers can approve, reject, or return requests for correction
- Leave balances are updated accurately
- Unauthorized actions are prevented
- Status transitions follow defined business rules
- Important actions remain traceable
- High-risk defects are identified before release

The primary focus is on business-critical functionality rather than exhaustive testing of every possible feature.

---

## 2. Test Approach

Testing is prioritized using a risk-based approach.

Higher testing effort is applied to functionality where failure could result in:

- Incorrect employee leave entitlement
- Unauthorized access
- Incorrect approval or rejection status
- Data inconsistency
- Duplicate balance deductions
- Privacy issues
- Loss of auditability
- Failure of the core leave workflow

---

## 3. Testing Types

### Functional Testing

Validate that the core leave-management workflow behaves according to the defined business rules.

Examples include:

- Creating and submitting leave requests
- Approving or rejecting requests
- Returning requests for correction
- Resubmitting corrected requests
- Cancelling approved future leave
- Correct leave balance adjustment

---

### Negative Testing

Validate that invalid or unauthorized actions are prevented.

Examples include:

- Requesting more leave than available
- Requesting invalid dates
- Employee attempting self-approval
- Unauthorized manager attempting approval
- Invalid state transitions
- Unsupported leave increments

---

### Boundary Value Testing

Validate important limits and edge conditions.

Examples include:

- Requesting exactly the available balance
- Requesting slightly more than available balance
- 0.5-day leave
- Zero remaining balance
- Minimum supported leave increment
- Leave spanning weekends or holidays

---

### State Transition Testing

Validate that requests move only through allowed workflow states.

Key statuses include:

- Draft
- Pending Approval
- Approved
- Rejected
- Returned for Correction
- Cancellation Requested
- Cancelled

Both valid and invalid transitions are tested.

---

### Role-Based Access and Authorization Testing

Validate business permissions for:

- Employee
- Line Manager
- HR/Admin

Testing includes:

- Self-approval prevention
- Direct-report approval restrictions
- Unauthorized data access
- Restricted administrative actions
- Controlled administrative overrides

This is functional authorization testing and does not represent full penetration or security testing.

---

### Smoke Testing

A small set of critical checks will be used to determine whether a build or environment is stable enough for detailed testing.

Typical smoke coverage includes:

- Application access/login
- Employee can create and submit leave request
- Manager can access approval queue
- Manager can approve/reject
- Request status updates correctly
- Basic leave balance is visible and updated correctly

If critical smoke scenarios fail, detailed testing may be paused until the environment is stable.

---

### Sanity Testing

Focused testing will be performed after small changes or defect fixes.

Example:

If a defect in leave-balance calculation is fixed, sanity testing may cover:

- Normal leave deduction
- Weekend calculation
- Half-day calculation
- Related approval behaviour
- Remaining leave balance

Sanity testing is narrower than full regression testing.

---

### Regression Testing

Regression testing will confirm that existing working functionality remains stable after changes or defect fixes.

The regression suite will prioritize:

- Leave request submission
- Approval and rejection
- Balance calculations
- Half-day handling
- Cancellation
- Role-based access
- Critical status transitions

---

### Exploratory Testing

Focused exploratory testing will be performed around high-risk business workflows.

The purpose is to identify issues that may not be captured by predefined test cases.

Examples include:

- Unusual sequences of user actions
- Repeated approvals
- Rapid status changes
- Unexpected leave combinations
- Interaction between different leave types

---

### Data Validation

Where supported by the selected test environment, testing may validate consistency between:

- User interface
- API responses
- Stored application data

Direct database testing will only be included if database access is genuinely available.

If database access is unavailable, persistence and consistency will be validated using accessible UI or API behaviour.

---

## 4. Areas of Deep Test Coverage

The following areas receive the highest testing depth:

- Leave request submission
- Annual vacation balance calculation
- Manager approval and rejection
- Employee self-approval prevention
- Role-based access
- Status transitions
- Cancellation and balance restoration
- Auditability
- Duplicate processing prevention
- Data integrity

---

## 5. Areas of Normal or Limited Coverage

Representative scenarios will be used for:

- Sick Leave
- Leave Without Pay
- Time Off in Lieu / Comp Off
- Parental Leave
- Notifications
- Time-zone behaviour where applicable

These areas are included to demonstrate different business rules without expanding the case study into a complete HRMS implementation.

---

## 6. Out of Scope

Detailed testing of the following areas is outside this case study:

- Payroll integration
- External HR-system integration
- Full mobile responsiveness
- Detailed visual/UI testing
- Performance/load testing
- Penetration testing
- Full employment-law validation
- Detailed statutory leave entitlement calculations

---

## 7. Entry Criteria

Testing can begin when:

- A stable and accessible test build/environment is available
- Required Employee, Manager, and HR/Admin test accounts are available
- Test data is available with known starting balances
- Key business rules are defined
- Planned high-risk scenarios are identified
- No environment issue prevents execution of the core workflow

---

## 8. Exit Criteria

Testing may be considered complete when:

- All planned critical and high-risk scenarios have been executed
- No unresolved Critical or High defects remain that block the core workflow
- No unresolved defect causes incorrect leave entitlement
- No unacceptable authorization or privacy risk remains
- Planned regression testing is complete
- Remaining defects are documented and assessed
- Residual release risk is understood

---

## 9. Release Recommendation

### GO

Recommend release when:

- Core leave workflow functions correctly
- Leave balances are accurate
- Authorization controls behave as expected
- Critical state transitions are correct
- No release-blocking defects remain

### GO WITH KNOWN RISK

Release may be recommended when:

- Core business functionality is stable
- Remaining issues are low impact
- Known issues are documented
- Business impact is understood
- Appropriate stakeholders accept the remaining risk

### NO GO

Recommend against release when testing identifies issues such as:

- Incorrect leave-balance calculation
- Data loss or corruption
- Employee self-approval
- Unauthorized access to employee data
- Core approval workflow failure
- Incorrect request status
- Duplicate balance deduction
- Unacceptable privacy/security risk
- Missing critical auditability

---

## 10. Risk Assessment Note

Risk ratings in this independent case study are based on assumed business impact and functional complexity.

In a real delivery project, risk would be refined using information such as:

- Historical defect trends
- Production incidents
- Change scope
- Technical complexity
- Architecture
- Business criticality
- Stakeholder input

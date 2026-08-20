# Test Execution Approach

## Purpose

This section shows how testing would be organized during execution, with a focus on build confidence, targeted retesting, regression coverage, and release readiness.

---

## Smoke Test Suite

A small smoke suite is used to confirm that the application is stable enough for detailed testing.

| Smoke ID | Scenario | Expected Result |
|---|---|---|
| SM-01 | Employee can access the application | Login/access works successfully |
| SM-02 | Employee can create and submit a leave request | Request is submitted and moves to Pending Approval |
| SM-03 | Assigned manager can view the request | Request appears in the manager approval queue |
| SM-04 | Manager can approve a valid request | Status changes to Approved |
| SM-05 | Leave balance updates after approval | Correct balance is displayed |
| SM-06 | Manager can reject a request | Status changes to Rejected without balance deduction |

If a critical smoke test fails, detailed testing may be paused until the build or environment is stable.

---

## Sanity Testing Example

### Scenario

A defect is fixed where a 3-day leave request was incorrectly deducting 4 days.

### Focused sanity checks

- Approve a normal 3-day request
- Verify balance decreases by exactly 3 days
- Verify a weekend within a leave period is excluded
- Verify a 0.5-day request calculates correctly
- Verify rejection does not reduce the balance
- Confirm the fix has not affected the approval workflow

The purpose is to validate the specific fix and the most closely related functionality before deciding whether wider regression is required.

---

## Regression Suite

The selected regression suite focuses on business-critical functionality:

- Submit a valid leave request
- Approve and reject leave requests
- Leave-balance calculation
- Weekend and public-holiday handling
- Half-day leave
- Exact and insufficient balance
- Cancellation and balance restoration
- Employee self-approval prevention
- Manager access for direct reports
- Unauthorized access prevention
- Return for Correction and resubmission
- Critical state transitions

The regression suite is intentionally risk-based rather than a rerun of every available test case.

---

## Release Recommendation

### GO

Recommend release when:

- Critical business workflows pass
- Leave balances are accurate
- Authorization controls work as expected
- No release-blocking defects remain

### GO WITH KNOWN RISK

Release may proceed when:

- Core functionality is stable
- Remaining defects have low business impact
- Known issues are documented
- Appropriate stakeholders understand and accept the residual risk

### NO GO

Recommend against release when issues remain such as:

- Incorrect leave-balance calculation
- Duplicate leave deduction
- Employee self-approval
- Unauthorized access to employee information
- Core approval workflow failure
- Data loss or corruption
- Incorrect critical status transitions

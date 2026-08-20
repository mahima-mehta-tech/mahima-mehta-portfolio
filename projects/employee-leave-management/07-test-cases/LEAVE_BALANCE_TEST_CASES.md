# Leave Balance & Calculation Test Cases

## Purpose

These test cases validate leave-balance accuracy, boundary conditions, half-day handling, cancellation, and duplicate-processing prevention.

| TC ID | Scenario | Preconditions | Test Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| LB-01 | Approve normal 3-day vacation | Employee vacation balance = 10 days | Submit 3 working days and manager approves | Balance remains 10 while Pending and becomes 7 after approval | Critical |
| LB-02 | Leave spans weekend | Balance = 10 days; Mon-Fri schedule | Request Friday through Monday and approve | Only 2 working days deducted; balance becomes 8 | High |
| LB-03 | Leave spans public holiday | Balance = 10 days | Request period containing 1 recognized public holiday and 2 working days | Only 2 days deducted after approval | High |
| LB-04 | Approve half-day vacation | Balance = 10 days | Submit valid 0.5-day request and approve | Balance becomes 9.5 | High |
| LB-05 | Half-day request remains Pending | Balance = 10 days | Submit 0.5-day request but do not approve | Balance remains 10 | High |
| LB-06 | Use exact remaining balance | Balance = 10 days | Request exactly 10 working days and approve | Request is allowed; informational warning may be shown; balance becomes 0 | High |
| LB-07 | Request exceeds available balance | Balance = 10 days | Attempt to request 10.5 working days | Request is blocked and balance remains unchanged | Critical |
| LB-08 | Exact 0.5-day remaining balance | Balance = 0.5 day | Request 0.5 day and approve | Request is allowed and balance becomes 0 | High |
| LB-09 | Reject approved-request candidate | Balance = 10 days | Submit 3-day request and manager rejects | Balance remains 10 | High |
| LB-10 | Cancel approved leave | 3-day leave approved; balance reduced from 10 to 7 | Employee requests cancellation and manager approves | Balance remains 7 while cancellation is Pending and returns to 10 after approval | Critical |
| LB-11 | Prevent duplicate deduction | Approved request already processed | Approval action is repeated or retried | Leave is deducted only once | Critical |
| LB-12 | Validate separate leave balance | Employee has vacation and lieu-time balances | Request and approve Time Off in Lieu | Lieu-time balance is reduced and vacation balance remains unchanged | Medium |

## Coverage Summary

The test set covers:

- Normal leave deduction
- Weekend and public-holiday handling
- Half-day leave
- Exact-balance boundaries
- Insufficient balance
- Rejection
- Cancellation and restoration
- Duplicate processing
- Separation of vacation and lieu-time balances

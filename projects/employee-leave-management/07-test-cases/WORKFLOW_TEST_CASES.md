# Workflow Test Cases

## Purpose

These test cases validate the core employee leave-request workflow, with emphasis on approval, rejection, correction, cancellation, and invalid status transitions.

| TC ID | Scenario | Preconditions | Test Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| WF-01 | Submit valid leave request | Employee has valid leave balance | Create a valid request and submit | Status changes from Draft to Pending Approval and request becomes available to assigned manager | High |
| WF-02 | Manager approves pending request | Valid request is Pending Approval | Assigned manager opens request and selects Approve | Status changes to Approved and appropriate leave balance is updated | Critical |
| WF-03 | Manager rejects pending request | Request is Pending Approval | Manager selects Reject and enters comment | Status changes to Rejected and leave balance remains unchanged | High |
| WF-04 | Return request for correction | Request is Pending Approval | Manager adds comment and selects Return for Correction | Status changes to Returned for Correction and employee can edit the request | High |
| WF-05 | Resubmit corrected request | Request is Returned for Correction | Employee updates required information and resubmits | Request returns to Pending Approval with updated information | High |
| WF-06 | Employee attempts to edit pending request | Request is Pending Approval | Employee attempts to modify submitted request | Editing is blocked and original request remains unchanged | High |
| WF-07 | Request cancellation of approved future leave | Request is Approved and leave has not started | Employee requests cancellation | Status changes to Cancellation Requested; existing balance deduction remains unchanged | High |
| WF-08 | Manager approves cancellation | Cancellation is Pending | Assigned manager approves cancellation | Status changes to Cancelled and applicable balance is restored once | Critical |
| WF-09 | Manager rejects cancellation | Cancellation is Pending | Manager rejects cancellation | Status returns to Approved and existing leave deduction remains unchanged | High |
| WF-10 | Prevent invalid approval after cancellation | Request is Cancelled | Attempt to approve/reactivate original request | Action is blocked and status remains Cancelled | High |
| WF-11 | Prevent approval before resubmission | Request is Returned for Correction | Manager attempts approval without employee resubmission | Approval is blocked | Medium |
| WF-12 | Prevent employee self-approval | Employee owns a Pending request | Employee attempts approval action | Action is denied and request remains Pending Approval | Critical |

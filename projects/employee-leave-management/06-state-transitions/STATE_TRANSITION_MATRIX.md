# State Transition Matrix

## Purpose

This document defines the valid and invalid status transitions for leave requests in the Employee Leave Management Portal.

The objective is to ensure that requests move only through permitted workflow states and that invalid transitions are blocked.

## Statuses

The case study uses the following main statuses:

- Draft
- Pending Approval
- Approved
- Rejected
- Returned for Correction
- Cancellation Requested
- Cancelled

## Transition Matrix

| Current Status | Action | Next Status | Allowed? | Performed By |
|---|---|---|---|---|
| Draft | Submit | Pending Approval | Yes | Employee |
| Draft | Delete / Discard | Removed | Yes | Employee |
| Pending Approval | Approve | Approved | Yes | Assigned Manager / Authorized Admin |
| Pending Approval | Reject | Rejected | Yes | Assigned Manager / Authorized Admin |
| Pending Approval | Return for Correction | Returned for Correction | Yes | Assigned Manager / Authorized Admin |
| Pending Approval | Edit directly | Pending Approval | No | Employee |
| Returned for Correction | Edit | Returned for Correction | Yes | Employee |
| Returned for Correction | Resubmit | Pending Approval | Yes | Employee |
| Returned for Correction | Approve directly | Approved | No | Manager |
| Rejected | Edit | Rejected | Yes | Employee |
| Rejected | Resubmit | Pending Approval | Yes | Employee |
| Approved | Request Cancellation | Cancellation Requested | Yes | Employee |
| Approved | Edit dates/details | Approved | No | Employee |
| Cancellation Requested | Approve Cancellation | Cancelled | Yes | Assigned Manager / Authorized Admin |
| Cancellation Requested | Reject Cancellation | Approved | Yes | Assigned Manager / Authorized Admin |
| Cancelled | Approve again | Approved | No | Any User |
| Cancelled | Edit / Resubmit same request | Pending Approval | No | Employee |
| Approved | Return to Draft | Draft | No | Any User |
| Rejected | Approve without resubmission | Approved | No | Manager |
| Pending Approval | Self-approve | Approved | No | Request Owner |

---

## Key Workflow Rules

### Draft to Pending Approval

An employee may edit a request while it is in Draft status.

Once submitted:

- Status changes to Pending Approval
- Normal employee editing is no longer allowed
- The request enters the assigned manager's approval workflow

### Pending Approval

The assigned manager may:

- Approve
- Reject
- Return for Correction
- Add comments

The employee must not be able to approve or reject the request.

### Returned for Correction

When a request is returned:

- The employee may edit the requested information
- The request cannot be approved until it is resubmitted
- Resubmission returns it to Pending Approval

### Rejected

A rejected request may be corrected and resubmitted according to the case-study business rules.

It must not be approved directly without first being resubmitted.

### Approved

An approved request is considered finalized for normal leave processing.

The employee cannot directly edit the approved request.

For future approved leave, the employee may initiate a cancellation request.

### Cancellation Requested

While cancellation is pending:

- The original leave remains approved
- Existing leave balance deduction remains unchanged

If cancellation is approved:

- Status changes to Cancelled
- Applicable leave balance is restored

If cancellation is rejected:

- Status returns to Approved
- Existing leave balance remains deducted

### Cancelled

Cancelled is treated as a terminal state for the original request.

The same cancelled request cannot be re-approved or resubmitted as a new active request.

---

## State Transition Testing Focus

Testing should validate:

- Every permitted transition
- Attempts to perform prohibited transitions
- Correct role for each transition
- Correct balance behaviour during transitions
- Correct audit history
- Duplicate action handling
- Behaviour when an action is repeated
- Data consistency after transition failure

## High-Risk Transition Examples

Particular attention should be given to:

- Pending Approval to Approved
- Approved to Cancellation Requested
- Cancellation Requested to Cancelled
- Returned for Correction to Pending Approval
- Rejected to Pending Approval
- Prevention of employee self-approval
- Prevention of Cancelled to Approved
- Prevention of duplicate approval or duplicate cancellation processing

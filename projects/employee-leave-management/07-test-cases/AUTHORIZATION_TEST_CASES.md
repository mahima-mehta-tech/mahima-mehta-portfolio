# Role-Based Access & Authorization Test Cases

## Purpose

These test cases validate that users can access only the leave-management functions and data permitted for their role.

The focus is on functional authorization and privacy controls, not penetration testing.

| TC ID | Scenario | Preconditions | Test Steps | Expected Result | Priority |
|---|---|---|---|---|---|
| AUTH-01 | Employee views own leave request | Employee has an existing request | Open own request | Request is displayed successfully | Medium |
| AUTH-02 | Employee attempts to view another employee's request | Two employee accounts exist | Employee tries to access another employee's request | Access is denied and restricted information is not exposed | Critical |
| AUTH-03 | Employee attempts self-approval | Employee owns a Pending Approval request | Attempt to approve own request | Approval is denied and status remains unchanged | Critical |
| AUTH-04 | Employee attempts manager-only action | Employee is logged in | Attempt Approve, Reject, or Return for Correction | Manager-only actions are unavailable or rejected | High |
| AUTH-05 | Employee attempts to edit Pending request | Own request is Pending Approval | Attempt to modify submitted details | Editing is blocked and original data remains unchanged | High |
| AUTH-06 | Employee edits Returned for Correction request | Request has been returned by manager | Employee updates required information | Editing is allowed and corrected request can be resubmitted | High |
| AUTH-07 | Assigned manager approves direct report's request | Employee reports to logged-in manager | Manager reviews and approves request | Approval succeeds and workflow continues correctly | Critical |
| AUTH-08 | Manager attempts to approve unrelated employee's request | Request belongs to another manager's employee | Manager attempts approval | Action is denied and request remains unchanged | Critical |
| AUTH-09 | Manager attempts to modify leave balance directly | Manager is logged in | Attempt direct balance adjustment | Action is unavailable or denied | High |
| AUTH-10 | Unauthorized user attempts restricted function through direct navigation | User lacks required permission | Attempt to access restricted manager/admin function directly | Access is denied and no restricted data or action is exposed | Critical |
| AUTH-11 | HR/Admin performs authorized override | Authorized HR/Admin account; valid exception exists | Perform override and provide required reason | Override succeeds and action is recorded in audit history | High |
| AUTH-12 | HR/Admin attempts override without reason | Authorized HR/Admin account | Attempt override without required reason | Override is rejected and no change is applied | High |
| AUTH-13 | Sensitive sick-leave information is restricted | Sick-leave request contains supporting information | Unauthorized user attempts access | Sensitive information is hidden or access is denied | Critical |
| AUTH-14 | User attempts to delete audit history | Audit record exists | Employee/Manager/Admin attempts deletion through normal application functions | Deletion is not permitted | High |

## Coverage Summary

The test set covers:

- Employee access boundaries
- Self-approval prevention
- Manager authorization
- Direct-report restrictions
- Unauthorized direct access
- Restricted administrative functions
- Controlled HR/Admin override
- Privacy of sensitive information
- Protection of audit history

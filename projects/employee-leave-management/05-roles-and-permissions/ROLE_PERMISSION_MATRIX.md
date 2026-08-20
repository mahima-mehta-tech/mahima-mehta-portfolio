# Role & Permission Matrix

## Purpose

This document defines the main permissions for each user role in the Employee Leave Management Portal.

The objective is to support authorization testing and verify that users can perform only the actions allowed for their role.

## Roles

- Employee
- Line Manager
- HR/Admin

## Permission Matrix

| Action | Employee | Line Manager | HR/Admin |
|---|---|---|---|
| Create own leave request | Allowed | Allowed for own request | Allowed when authorized |
| View own leave requests | Allowed | Allowed | Allowed |
| Edit Draft request | Allowed for own request | Allowed for own request | Allowed when authorized |
| Edit Pending request | Not Allowed | Not Allowed | Restricted admin correction only |
| Approve leave request | Not Allowed | Allowed for direct reports only | Allowed only when authorized |
| Reject leave request | Not Allowed | Allowed for direct reports only | Allowed only when authorized |
| Approve own leave | Not Allowed | Not Allowed | Not Allowed |
| Add comments | Allowed on own request | Allowed | Allowed |
| Return for Correction | Not Allowed | Allowed for direct reports | Allowed when authorized |
| Edit Returned for Correction request | Allowed for own request | Not Allowed | Restricted admin correction only |
| Resubmit corrected request | Allowed | Not Allowed | Allowed when authorized |
| Request cancellation of approved future leave | Allowed for own leave | Not Applicable | Allowed when authorized |
| Approve or reject cancellation | Not Allowed | Allowed for direct reports | Allowed when authorized |
| View direct reports' requests | Not Allowed | Allowed | Allowed |
| View unrelated employees' requests | Not Allowed | Not Allowed | Allowed only where HR/Admin permission permits |
| Modify leave balance directly | Not Allowed | Not Allowed | Restricted admin function |
| Perform administrative override | Not Allowed | Not Allowed | Allowed with mandatory reason |
| View relevant audit history | Limited | Limited to relevant team/request | Allowed based on role |
| Delete audit history | Not Allowed | Not Allowed | Not Allowed |

---

## Key Authorization Rules

### Employee

Employees may:

- Create and submit their own leave requests
- View their own requests
- Edit Draft requests
- Edit requests that have been Returned for Correction
- Resubmit corrected or rejected requests
- Request cancellation of approved future leave

Employees must not:

- Approve or reject leave requests
- Approve their own leave
- View another employee's private leave information
- Modify leave balances directly
- Perform administrative overrides

---

### Line Manager

Line Managers may:

- Review requests submitted by their direct reports
- Approve or reject requests
- Add comments
- Return requests for correction
- Review cancellation requests

Line Managers must not:

- Approve requests belonging to unrelated employees
- Approve their own leave
- Modify employee leave balances directly
- Delete audit records

---

### HR/Admin

Authorized HR/Admin users may perform restricted administrative activities such as:

- Administrative corrections
- Approved leave-balance adjustments
- Authorized overrides
- Audit review
- Support for exceptional workflow cases

Administrative actions must be controlled and traceable.

Where an override is performed, the system should record:

- Administrator identity
- Date and time
- Reason
- Original value or status
- Updated value or status

---

## Authorization Testing Focus

Testing should confirm that:

- Employees cannot self-approve
- Managers can act only on appropriate direct reports
- Restricted information is not exposed to unauthorized users
- Direct navigation to restricted functions is blocked
- Administrative overrides require the correct authority
- Audit records remain protected

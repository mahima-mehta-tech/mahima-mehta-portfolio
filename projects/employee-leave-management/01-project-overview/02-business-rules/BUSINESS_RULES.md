# Business Rules

## Purpose

This document defines the business rules used for the Employee Leave Management Portal QA case study.

The rules are intentionally simplified for portfolio testing. They are designed to support realistic enterprise QA scenarios without attempting to model every HR policy or statutory requirement.

## Employee Vacation Assumption

For this case study:

- Annual vacation entitlement: 15 working days
- Sample employee available vacation balance: 10 working days
- Standard work schedule: Monday to Friday
- Weekends are not deducted from vacation balance
- Recognized public holidays are not deducted when they fall within an approved vacation period

The 15-day entitlement is a company-policy assumption for this case study and should not be interpreted as a universal Canadian employment standard.

---

## BR-01 - Vacation Balance Update

Vacation balance is deducted only after the leave request is approved.

Example:

- Starting balance: 10 days
- Employee requests: 3 days
- Status = Pending Approval
- Available balance remains: 10 days
- Manager approves
- Available balance becomes: 7 days

Rejected requests do not affect the available vacation balance.

---

## BR-02 - Past-Date Requests

Employees cannot submit normal vacation requests for dates that have already passed.

Any retroactive correction would require a separate administrative process and is outside the normal employee workflow.

---

## BR-03 - Weekends

For an employee working Monday to Friday, Saturdays and Sundays are excluded from vacation-day calculations.

Example:

A vacation request from Friday through Monday uses 2 vacation days, assuming there is no public holiday.

---

## BR-04 - Public Holidays

Recognized public holidays are excluded from vacation deduction when they fall within the employee's normal working schedule.

---

## BR-05 - Half-Day Vacation

Employees may request vacation in:

- Full-day increments
- 0.5-day increments

Where applicable, the employee selects either:

- AM
- PM

The system does not support 0.25-day or 0.75-day vacation increments for this case study.

Vacation balance changes only after manager approval.

---

## BR-06 - Insufficient Vacation Balance

An employee cannot submit a paid vacation request exceeding the available vacation balance.

Example:

- Available balance: 10 days
- Requested leave: 10.5 days
- Expected result: Request is blocked

The balance must never become negative.

---

## BR-07 - Exact Remaining Balance

An employee may request exactly the number of vacation days remaining.

Example:

- Available balance: 10 days
- Requested leave: 10 days
- Request is allowed

The system may display an informational warning that the request will use the employee's full remaining vacation balance.

After approval, the available balance becomes 0.

---

## BR-08 - Overlapping Leave Requests

The system prevents an employee from submitting another leave request that overlaps an existing Pending or Approved request for the same dates or partial dates.

This prevents duplicate leave records and duplicate balance deductions.

---

## BR-09 - Approval Authority

The employee's assigned Line Manager may approve or reject leave requests for their direct reports.

Managers must not be able to approve requests belonging to unrelated employees.

Authorized HR/Admin users may perform approved administrative actions according to their role.

---

## BR-10 - Self-Approval

Employees must never be able to approve their own leave requests.

This restriction also applies if the employee has another role in the system.

---

## BR-11 - Rejected Leave

A rejected leave request does not affect the employee's vacation balance.

Rejected requests may be edited by the employee and resubmitted for approval.

---

## BR-12 - Returned for Correction

A manager may return a Pending Approval request to the employee for correction.

The manager may add comments explaining what must be updated.

While the request is Returned for Correction:

- The employee may edit the request
- The manager cannot approve it directly
- The employee must resubmit it before further approval

---

## BR-13 - Editing After Submission

Employees cannot directly edit a request while its status is Pending Approval.

They may edit it only when:

- It is still a Draft
- It has been Returned for Correction
- It has been Rejected and is being prepared for resubmission

---

## BR-14 - Cancellation of Approved Leave

An employee may request cancellation of approved future leave before the leave begins.

Submitting a cancellation request does not immediately restore the leave balance.

The balance is restored only after the cancellation is approved by the assigned manager or an authorized administrator.

Example:

- Initial balance: 10 days
- 3-day leave approved
- Balance becomes: 7 days
- Employee requests cancellation
- Balance remains: 7 days
- Manager approves cancellation
- Balance returns to: 10 days

---

## BR-15 - Cancellation Rejection

If the manager rejects a cancellation request:

- The original leave remains Approved
- The previously deducted balance remains unchanged

---

## BR-16 - Sick Leave

Sick Leave is treated separately from annual vacation.

For this case study:

- Sick Leave must not incorrectly reduce annual vacation balance
- Detailed employer-specific or statutory sick-leave calculations are outside the test scope
- Sensitive supporting information must be protected from unauthorized users

---

## BR-17 - Leave Without Pay

Leave Without Pay is treated as a separate leave type.

For this case study:

- LWOP requires manager approval
- LWOP does not reduce annual vacation balance
- Detailed payroll impact is outside the test scope

---

## BR-18 - Time Off in Lieu / Comp Off

Time Off in Lieu is maintained using a separate balance.

When approved:

- The applicable lieu-time balance is reduced
- Annual vacation balance remains unchanged

Employees cannot request more lieu time than their available lieu-time balance.

---

## BR-19 - Parental Leave

Parental Leave is treated as a separate leave category.

For this case study:

- It must not incorrectly reduce annual vacation balance
- Appropriate workflow and access controls should apply
- Detailed eligibility, duration, benefits, statutory calculations, and payroll processing are outside scope

---

## BR-20 - Administrative Override

Authorized HR/Admin users may perform restricted administrative corrections or overrides.

An administrative override must:

- Require an appropriate reason
- Record the identity of the administrator
- Record the date and time
- Preserve the original and updated information where applicable

Administrative override is not intended to replace the normal approval workflow.

---

## BR-21 - Audit Trail

Important leave-management actions must be traceable.

The audit trail should capture relevant information such as:

- Request creation
- Submission
- Approval
- Rejection
- Return for Correction
- Resubmission
- Cancellation request
- Cancellation approval or rejection
- Administrative override
- Balance adjustment
- User performing the action
- Date and time
- Previous status
- New status

Audit-history records should not be deletable by normal application users.

---

## Scope Note

These business rules are assumptions created specifically for this independent QA case study.

They are intended to support test analysis and design and should not be treated as the complete HR or employment policy of a Canadian organization.

# Project Overview

## Project Title

Employee Leave Management Portal - QA Case Study

## Project Purpose

This independent case study demonstrates a structured QA approach to testing an enterprise leave management application.

The objective is to show how business requirements and risks can be translated into test strategy, test conditions, test cases, authorization checks, state-transition validation, and release-risk assessment.

## System Overview

The Employee Leave Management Portal allows employees to submit leave requests and enables managers and HR/Admin users to review and manage those requests based on defined business rules and permissions.

The application supports the following leave categories:

- Annual Vacation
- Half-Day Vacation
- Sick Leave
- Leave Without Pay
- Time Off in Lieu / Comp Off
- Parental Leave

## Primary User Roles

### Employee
Can create leave requests, view their own requests, respond to requests returned for correction, and request cancellation of approved future leave.

### Line Manager
Can review leave requests submitted by direct reports, approve or reject them, add comments, return requests for correction, and review cancellation requests.

### HR/Admin
Has restricted administrative privileges for approved corrections, overrides, leave-balance maintenance, and audit review.

## Main Workflow

1. Employee creates a leave request.
2. Employee submits the request for approval.
3. Assigned manager reviews the request.
4. Manager may:
   - Approve
   - Reject
   - Return for Correction
5. Approved leave affects the appropriate leave balance.
6. Employee may request cancellation of future approved leave.
7. Manager reviews the cancellation request.
8. Approved cancellation restores the applicable balance.

## Main QA Focus

The deepest test coverage is applied to areas with higher business impact:

- Leave balance calculations
- Approval and rejection workflow
- Role-based authorization
- Employee self-approval prevention
- State transitions
- Cancellation and balance restoration
- Data integrity
- Auditability

## Testing Scope

This case study includes:

- Functional testing
- Negative testing
- Boundary value testing
- State transition testing
- Role-based access and authorization testing
- Smoke testing
- Sanity testing
- Regression testing
- Exploratory testing
- Limited data validation
- Release-risk assessment

## Out of Scope

The following areas are intentionally outside detailed testing scope:

- Payroll integration
- External HR-system integration
- Full mobile responsiveness testing
- Detailed visual/UI testing
- Performance testing
- Penetration testing
- Detailed employment-law validation
- Complete statutory leave calculation logic

These areas may be referenced where relevant, but they are not part of the detailed test execution for this case study.

## Case Study Assumption

This is an independent portfolio project based on a realistic enterprise leave-management workflow.

Business rules are defined specifically for this case study. They should not be interpreted as universal rules for every Canadian employer.

# Employee Leave Management Portal - QA Case Study

## Overview

This independent QA case study demonstrates how I approach an enterprise workflow from business-rule understanding and risk analysis through test design and release assessment.

The focus is on the highest-risk areas of an Employee Leave Management Portal, including leave balance accuracy, approvals, authorization, state transitions, and cancellation handling.

## Skills Demonstrated

- Functional & End-to-End Testing
- Test Strategy & Risk-Based Test Planning
- Test Scenario & Test Case Design
- Negative & Boundary Value Testing
- State Transition Testing
- Role-Based Access & Authorization Validation
- Leave Balance & Data Integrity Validation
- Smoke, Sanity & Regression Testing
- Business Rule Validation
- Defect & Release Risk Assessment

## Key Artifacts

- [Project Overview](01-project-overview/PROJECT_OVERVIEW.md)
- [Business Rules](02-business-rules/BUSINESS_RULES.md)
- [Test Strategy](03-test-strategy/TEST_STRATEGY.md)
- [Risk Assessment](04-risk-assessment/RISK_ASSESSMENT.md)
- [Role & Permission Matrix](05-roles-and-permissions/ROLE_PERMISSION_MATRIX.md)
- [State Transition Matrix](06-state-transitions/STATE_TRANSITION_MATRIX.md)
- [Workflow Test Cases](07-test-cases/WORKFLOW_TEST_CASES.md)
- [Leave Balance Test Cases](07-test-cases/LEAVE_BALANCE_TEST_CASES.md)
- [Authorization Test Cases](07-test-cases/AUTHORIZATION_TEST_CASES.md)
- [Test Execution Approach](08-test-execution/TEST_EXECUTION_APPROACH.md)
- [Test Summary & Release Recommendation](10-test-summary/TEST_SUMMARY.md)

## Test Focus

Testing is intentionally risk-based.

Deeper coverage is applied to:

- Leave request submission
- Leave balance calculation
- Approval and rejection
- Employee self-approval prevention
- Role-based access
- Cancellation and balance restoration
- Critical status transitions
- Duplicate processing prevention

Other leave types are covered with representative scenarios rather than exhaustive testing.

## Workflow

The core workflow covers:

Employee Request → Manager Review → Approve / Reject / Return for Correction → Resubmit → Cancellation where applicable.

## Case Study Note

This is an independent portfolio case study created to demonstrate practical QA analysis and test-design skills.

Business rules are simplified for the case study and do not represent the complete HR policy of any specific organization.

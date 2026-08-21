# Test Summary & Release Recommendation

## Scope Reviewed

The case study focused on the highest-risk areas of the Employee Leave Management Portal:

- Leave request workflow
- Approval and rejection
- Leave balance calculations
- Half-day and boundary scenarios
- Cancellation and balance restoration
- Role-based authorization
- Critical state transitions

## Key Risks Considered

The highest business risks identified were:

- Incorrect leave balance
- Duplicate leave deduction
- Unauthorized approval
- Employee self-approval
- Incorrect workflow status
- Exposure of restricted employee information

## Test Coverage Approach

Coverage included:

- Functional testing
- Negative testing
- Boundary value testing
- State transition testing
- Role-based authorization testing
- Smoke and regression planning

## Release Recommendation

### GO

Release would be recommended when:

- Critical workflows behave correctly
- Leave balances remain accurate
- Authorization rules are enforced
- No Critical or High release-blocking defects remain

### NO GO

Release would not be recommended if issues remain such as:

- Incorrect balance calculation
- Duplicate deductions
- Employee self-approval
- Unauthorized access
- Core approval workflow failure
- Data loss or corruption

## QA Perspective

The test approach prioritizes business impact and user risk rather than treating every feature with equal testing depth.

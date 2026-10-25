# Data Validation and Evidence Status

**Project:** Employee Leave Management (synthetic portfolio case study)  
**Review date:** 25 October 2026  
**Evidence status:** Documentation cross-check completed; source-data SQL rerun and Power BI recalculation not independently executed.

## Documented baseline and arithmetic cross-checks

| Check | Documented result | Review |
|---|---:|---|
| Total requests | 180 | Status counts 127 + 24 + 17 + 12 = 180 |
| Approved | 127 | 127 / 180 = 70.6% rounded |
| Pending | 24 | SQL query 1 and README agree |
| Total requested days | 591 | Department totals 133 + 146 + 126 + 86 + 59 + 41 = 591 |
| Department request counts | 180 | 42 + 40 + 36 + 28 + 21 + 13 = 180 |
| Approved requests by leave type | 127 | 49 + 31 + 20 + 12 + 15 = 127 |
| Approved days by leave type | 419 | 216 + 76 + 55 + 39 + 33 = 419; this is not total requested days |
| Approved vacation days by department | 216 | 71 + 39 + 34 + 33 + 29 + 10 = 216 |
| Leave balance exceptions | 2 | Employee IDs 1016 and 1019 in documented SQL output |

These checks reconcile **figures reported in the existing documentation**. They do not prove the queries were executed against the uploaded dataset.

## Evidence available in repository

- [SQL query script](../sql/leave_analysis.sql) and [documented outputs](../sql/SQL_ANALYSIS.md)
- [Power BI report description and DAX](../power-bi/POWER_BI_DASHBOARD.md)
- Dashboard and data-model screenshots referenced from the Power BI documentation (both image files verified present)
- [Requirements and business rules](REQUIREMENTS_AND_RULES.md), [traceability](TRACEABILITY_MATRIX.md), and [proposed acceptance criteria](USER_STORIES_AND_ACCEPTANCE_CRITERIA.md)

## Outstanding independent validation

1. Locate and inspect the actual synthetic source CSV files under `data/`; the expected filenames `Employees.csv`, `LeaveRequests.csv`, `LeaveTypes.csv`, and `LeaveBalances.csv` were not found at those exact paths during this review. The directory may use different names.
2. Run `sql/leave_analysis.sql` against the source tables and compare each result to `SQL_ANALYSIS.md`.
3. Open the Power BI report in Desktop, refresh it against the same dataset, and verify card values, relationships, slicers, and exception filtering. The available screenshots and DAX documentation are not equivalent to executing the report.
4. Confirm that each linked source-data artifact is downloadable and sufficient for reproduction.

## Business rule and scope boundary

BR-05 describes the **intended approval control**; BR-08 describes **exception reporting**. Two synthetic records show approved usage above annual entitlement while the reported remaining balance is zero. These are flagged for investigation, not asserted to be valid approvals or proof that a negative-balance prevention workflow was executed.

No deployed leave-approval application or formal business-user UAT is claimed. The workflow stories and acceptance criteria are specifications; the SQL and Power BI artifacts demonstrate reporting and analytical scenarios.

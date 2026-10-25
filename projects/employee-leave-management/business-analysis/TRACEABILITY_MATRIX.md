# Requirements Traceability Matrix

This matrix links the **documented** business requirements to business rules and available evidence. A proposed check is not the same as an executed test.

| Requirement | Business need / rule | Evidence or validation approach | Status |
|---|---|---|---|
| FR-01 | Valid leave request entry; BR-01 | Proposed US-01 acceptance criteria; no live submission application | Specified, not executed |
| FR-02 | Authorized manager decision; BR-02, BR-03 | Proposed US-02 and US-03 acceptance criteria | Specified, not executed |
| FR-03 | Defined request statuses | SQL Analysis Query 1 groups requests by Status; US-01/02 | Data analysis documented; workflow not executed |
| FR-04 | Approved vacation affects balance; BR-04, BR-05, BR-06, BR-07 | SQL Analysis Queries 4, 6 and 7; US-04 | Partial analytical evidence; calculation workflow not executed |
| FR-05 | HR reviews exceptions; BR-08 | SQL Analysis Query 7 identifies entitlement exceptions; US-05 | Analytical evidence documented |
| FR-06 | Management reporting | SQL Analysis Queries 1–4, 8–9; Power BI dashboard | Reporting evidence documented |

## Links
- [Requirements and business rules](REQUIREMENTS_AND_RULES.md)
- [User stories and acceptance criteria](USER_STORIES_AND_ACCEPTANCE_CRITERIA.md)
- [SQL analysis](../sql/SQL_ANALYSIS.md)
- [Power BI report](../power-bi/POWER_BI_DASHBOARD.md)

## Validation evidence
- [Data Validation & Evidence Status](DATA_VALIDATION_STATUS.md) records arithmetic cross-checks and the remaining source-data / Power BI verification work.

## Coverage limitations
This is a portfolio traceability exercise, not a production UAT sign-off. The case study demonstrates analytical checks against synthetic data; it does not include a deployed leave-request workflow.

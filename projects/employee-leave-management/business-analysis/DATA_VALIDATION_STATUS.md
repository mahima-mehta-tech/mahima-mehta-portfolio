# Data Validation and Evidence Status

**Project:** Employee Leave Management (synthetic portfolio case study)  
**Review date:** 25 October 2026  
**Status:** All nine documented SQL analysis queries independently reconciled against four user-supplied CSV datasets using SQLite. Power BI Desktop refresh and interactive visuals not independently rerun.

## Source datasets validated

| Source file provided | Rows | Role |
|---|---:|---|
| `employees(1).csv` | 60 | Employee master |
| `leave_requests(1).csv` | 180 | Leave transactions |
| `leave_types(1).csv` | 5 | Leave-type lookup |
| `leave_balances(1).csv` | 60 | Entitlement and usage |

The uploaded CSVs were read locally and loaded as SQLite tables `Employees`, `LeaveRequests`, `LeaveTypes`, and `LeaveBalances`. The files' uploaded names include `(1)`; these are **not** asserted to be the filenames stored in GitHub. They were not automatically published to the repository.

## Independent SQL reconciliation

| Query | Check | Verified result | Outcome |
|---|---|---|---|
| 1 | Request status distribution | Approved 127; Pending 24; Rejected 17; Cancelled 12 | Pass |
| 2 | Department request counts and requested days | Engineering 42/133; Finance 40/146; Sales 36/126; Customer Support 28/86; Operations 21/59; HR 13/41 | Pass |
| 3 | Pending follow-up list | 24 rows; first five sample rows agree with SQL analysis | Pass |
| 4 | Approved leave by type | Vacation 49/216; Sick 31/76; Unpaid 20/55; Personal 12/39; Bereavement 15/33 | Pass |
| 5 | Employees without requests | IDs 1038 and 1054 | Pass |
| 6 | Remaining balance summary | Average 13.35; minimum 0; maximum 20 | Pass |
| 7 | Leave balance exceptions | IDs 1016 (33 used/20 entitlement) and 1019 (27 used/20 entitlement), both 0 displayed remaining | Pass |
| 8 | Approved vacation by department | Finance 15/71; Sales 8/39; Customer Support 9/34; Operations 8/33; Engineering 7/29; HR 2/10 | Pass |
| 9 | Employees with at least one pending request | 20 unique employees; first five match documented sample | Pass |

**Other reconciliations:** 180 total requests; 591 requested days; approval rate 127/180 = 70.6% (rounded); approved vacation days by department sum to 216. There are no duplicate full rows in any CSV, no duplicate leave request IDs, no unmatched request-to-employee or request-to-leave-type foreign keys, no nonpositive requested-day counts, and no start dates later than end dates. All 127 Approved and 17 Rejected records have an approval date; all 24 Pending and 12 Cancelled records have no approval date. Every recorded approval date is on or after the request date.

## Business-rule interpretation

BR-05 describes the **intended approval control**; BR-08 describes **exception reporting**. The two synthetic balance records exceed annual entitlement but show zero remaining balance, consistent with a floor-at-zero reporting calculation. They require investigation and do not demonstrate that an actual leave-approval workflow enforced the entitlement rule.

## Remaining scope limits

- Power BI report refresh, slicer behavior, relationships, and visual filtering have **not** been independently tested in Power BI Desktop. The existing dashboard/model screenshots were verified present in GitHub, but screenshots are not a substitute for a live refresh.
- The four CSVs were supplied as chat attachments and tested locally. Their exact GitHub storage paths were not confirmed; the README's `data/` link does not by itself prove the four downloadable datasets are present.
- This is synthetic data and a reporting case study, not a deployed HR workflow or formal business-user UAT.

## Related evidence

- [SQL query script](../sql/leave_analysis.sql) and [documented outputs](../sql/SQL_ANALYSIS.md)
- [Power BI dashboard and DAX](../power-bi/POWER_BI_DASHBOARD.md)
- [Requirements and business rules](REQUIREMENTS_AND_RULES.md)
- [Traceability matrix](TRACEABILITY_MATRIX.md)

# Employee Leave Approval — Current and Future State Process Maps

These are **illustrative conceptual workflows** for the synthetic case study, not observed processes at a real employer. The current state represents a plausible manual baseline; the future state represents the requirements in [REQUIREMENTS_AND_RULES.md](REQUIREMENTS_AND_RULES.md).

## Illustrative current state — manual approval

```mermaid
flowchart TD
 A[Employee emails leave request] --> B[Manager checks dates and availability manually]
 B --> C{Approve?}
 C -->|Yes| D[Manager confirms by email]
 C -->|No| E[Manager sends rejection]
 D --> F[HR updates spreadsheet or record]
 E --> F
 F --> G[HR prepares periodic status report]
```

**Potential pain points (hypotheses):** duplicate entry, inconsistent status updates, delayed reporting, limited visibility into remaining balances.

## Proposed future state — controlled leave workflow

```mermaid
flowchart TD
 A[Employee submits request] --> B{Valid employee, type and dates?}
 B -->|No| C[Request correction]
 B -->|Yes| D[Set Pending status]
 D --> E[Authorized line manager reviews]
 E --> F{Decision}
 F -->|Approve| G[Set Approved]
 F -->|Reject| H[Set Rejected]
 G --> I{Vacation request?}
 I -->|Yes| J[Validate entitlement and update approved usage]
 I -->|No| K[Keep vacation balance unchanged]
 J --> L[Flag exceptions for HR investigation]
 K --> M[Update management reporting]
 L --> M
 H --> M
```

## BA validation questions
- Who is authorized to approve a request when the line manager is absent?
- Can an employee cancel an approved request, and how is its balance restored?
- What are the carry-forward, adjustment and entitlement policies?
- How are overlapping requests and non-working days handled?

These policy decisions are intentionally open; the diagrams should not be mistaken for a production-ready HR workflow.

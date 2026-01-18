# Plan Template (Implementation Plan)

The **how** of the decision. Saved to `context/plans/`.

## Required Sections
- Implementation Steps (ordered, concrete tasks)
- Configuration (environment vars, feature flags, settings)
- Error Handling (failure modes, recovery, alerting)

## Optional Sections (Include if Discussed)
- Data Model (tables, fields, types, migrations)
- Interface (endpoints, methods, params, contracts)
- Migration Strategy (rollout phases, rollback plan)
- Dependencies (services, libraries, external systems)

## Template

```markdown
---
problem: "..."
date: YYYY-MM-DD
adr: "[problem-slug]-adr-YYYY-MM-DD.md"
---

# Implementation Plan: [Title]

## Implementation Steps
1. [First concrete task]
2. [Second concrete task]
...

## Configuration
| Key | Value | Environment | Description |
|-----|-------|-------------|-------------|
| ... | ...   | ...         | ...         |

## Error Handling
| Failure Mode | Detection | Recovery | Alerting |
|--------------|-----------|----------|----------|
| ...          | ...       | ...      | ...      |

## Data Model
[If discussed - tables, fields, types, migration scripts]

## Interface
[If discussed - endpoints, methods, params, example requests/responses]

## Migration Strategy
[If discussed - phases, feature flags, rollback triggers]

## Dependencies
[If discussed - services, versions, SLAs]
```

## Naming Convention
- Plan: `[problem-slug]-plan-YYYY-MM-DD.md`
- Location: `context/plans/`
- Cross-references ADR via frontmatter `adr:` field

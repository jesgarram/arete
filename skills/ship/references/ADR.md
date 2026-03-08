# ADR Template (Architecture Decision Record)

The **why** and **what** of the decision. Saved to `context/exports/`.

## Required Sections
- Context (why now, constraints, forces)
- Decision (what was chosen, how it addresses context)
- Consequences (positive, negative, mitigations)

## Template

```markdown
---
problem: "..."
date: YYYY-MM-DD
plan: "[problem-slug]-plan-YYYY-MM-DD.md"
---

# [Title from brainstorm problem statement]

**Status**: Proposed | Accepted | Superseded by [link]

## Context
[Why, constraints, forces at tension]

## Decision
[What was chosen, how it addresses context]

[Mermaid diagram if architecture discussed]

## Consequences
**Positive:** [Specific gains]
**Negative:** [Trade-offs accepted]
**Mitigations:** [How negatives will be managed]

## Risks
[Top 2-3 failure modes from stress-testing / pre-mortem. For each: what goes wrong, what signal to watch for, what to do if it happens.]
```

## Naming Convention
- ADR: `[problem-slug]-adr-YYYY-MM-DD.md`
- Location: `context/exports/`
- Cross-references Plan via frontmatter `plan:` field

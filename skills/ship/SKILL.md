---
name: ship
description: Generate retrievable artifacts from brainstorm sessions. Use after STRESS phase to create ADRs + Plans (technical) or Outlines (conceptual). Spawns parallel architect subagents to generate inline mermaid diagrams.
---

# Ship

Transform brainstorm decisions into retrievable, actionable artifacts.

## Flow

1. **Detect track**: Technical → ADR + Plan | Conceptual → Outline
2. **Generate documents** with natural structure from brainstorm
3. **Identify sections** with component interactions
4. **Spawn parallel architect subagents** (one per section needing diagrams)
5. **Inject mermaid** inline where subagents return diagrams
6. **Add frontmatter** and save:
   - ADRs/Outlines → `context/exports/`
   - Plans → `context/plans/`

## Frontmatter Schema

Minimal. Everything else is discoverable by reading the doc.

```yaml
---
problem: "One-line problem statement"
date: YYYY-MM-DD
---
```

## Technical Track → ADR + Plan

Two complementary documents: ADR captures the decision, Plan captures the implementation.

### ADR (Architecture Decision Record)

The **why** and **what** of the decision. Saved to `context/exports/`.

**Required sections:**
- Context (why now, constraints, forces)
- Decision (what was chosen, how it addresses context)
- Consequences (positive, negative, mitigations)

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
```

### Plan (Implementation Plan)

The **how** of the decision. Saved to `context/plans/`.

**Required sections:**
- Implementation Steps (ordered, concrete tasks)
- Configuration (environment vars, feature flags, settings)
- Error Handling (failure modes, recovery, alerting)

**Include if discussed:**
- Data Model (tables, fields, types, migrations)
- Interface (endpoints, methods, params, contracts)
- Migration Strategy (rollout phases, rollback plan)
- Dependencies (services, libraries, external systems)

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

## Conceptual Track → Outline

**Required:**
- Audience (who, what they know, what they care about)
- Objective (think/feel/do after)

Structure flows naturally from brainstorm content.

```markdown
---
problem: "..."
date: YYYY-MM-DD
---

# [Title]

**Audience**: [Who, background, concerns]
**Objective**: [Desired outcome]

[Sections flow from brainstorm - no rigid template]
```

## Diagram Generation

For sections describing **component interactions**, spawn the architect subagent.

**Triggers** (keywords indicating architecture):
- Components: "service", "database", "API", "cache", "queue", "client"
- Interactions: "calls", "sends", "receives", "queries", "connects", "flows"

**Process:**
1. Identify all sections with component interactions
2. Spawn parallel architect subagents (one per section)
3. Each subagent receives: section title + section text
4. Each subagent returns: mermaid block or `NO_DIAGRAM`
5. Inject returned mermaid inline after section content

**Cap:** Maximum 3 diagrams per document to avoid over-diagramming.

## File Output

### Technical Track
**ADR Location**: `context/exports/`
**Plan Location**: `context/plans/`

**Naming**:
- ADR: `[problem-slug]-adr-YYYY-MM-DD.md`
- Plan: `[problem-slug]-plan-YYYY-MM-DD.md`

Both files cross-reference each other via frontmatter (`plan:` and `adr:` fields).

### Conceptual Track
**Location**: `context/exports/`

**Naming**: `[problem-slug]-outline-YYYY-MM-DD.md`

Single file per session.

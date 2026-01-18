---
name: ship
description: Generate retrievable artifacts from brainstorm sessions. Use after STRESS phase to create ADRs + Plans (technical) or Outlines (conceptual). Spawns parallel architect subagents to generate inline mermaid diagrams.
---

# Ship

Transform brainstorm decisions into retrievable artifacts.

## Flow

1. Detect track: Technical → ADR + Plan | Conceptual → Outline
2. Generate documents from brainstorm content
3. Identify sections with component interactions → spawn parallel architect subagents
4. Inject returned mermaid inline (max 3 diagrams per doc)
5. Add frontmatter (`problem:`, `date:`) and save

## Output

| Track | Document | Location | Naming |
|-------|----------|----------|--------|
| Technical | ADR | `context/exports/` | `[slug]-adr-YYYY-MM-DD.md` |
| Technical | Plan | `context/plans/` | `[slug]-plan-YYYY-MM-DD.md` |
| Conceptual | Outline | `context/exports/` | `[slug]-outline-YYYY-MM-DD.md` |

Technical ADR + Plan cross-reference each other via frontmatter.

## Templates

- **ADR**: [`reference/ADR.md`](reference/ADR.md) - the why and what
- **Plan**: [`reference/Plan.md`](reference/Plan.md) - the how
- **Outline**: [`reference/Outline.md`](reference/Outline.md) - conceptual track

## Diagram Generation

Spawn architect subagent for sections with component interactions.

**Trigger keywords**: service, database, API, cache, queue, client, calls, sends, flows

**Process**: Identify sections → spawn parallel subagents (section title + text) → inject returned mermaid or discard `NO_DIAGRAM`

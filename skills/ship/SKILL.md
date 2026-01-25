---
name: ship
description: Generate retrievable artifacts from brainstorm sessions. Use after STRESS phase to create ADRs + Plans (technical) or Outlines (conceptual). Spawns parallel architect subagents to generate inline mermaid diagrams.
---

# Ship

Transform brainstorm decisions into retrievable artifacts.

## Flow

1. Detect track: Technical → ADR + Plan | Conceptual → Outline
2. Detect domain: IaC → load [`references/tdd-iac.md`](references/tdd-iac.md)
3. Generate documents from brainstorm content
4. Identify sections with component interactions → spawn parallel architect subagents
5. Inject returned mermaid inline (max 3 diagrams per doc)
6. Add frontmatter (`problem:`, `date:`) and save

## Output

| Track | Document | Location | Naming |
|-------|----------|----------|--------|
| Technical | ADR | `context/exports/` | `[slug]-adr-YYYY-MM-DD.md` |
| Technical | Plan | `context/plans/` | `[slug]-plan-YYYY-MM-DD.md` |
| Conceptual | Outline | `context/exports/` | `[slug]-outline-YYYY-MM-DD.md` |

Technical ADR + Plan cross-reference each other via frontmatter.

## Templates

- **ADR**: [`references/ADR.md`](references/ADR.md) - the why and what
- **Plan**: [`references/Plan.md`](references/Plan.md) - the how
- **Outline**: [`references/Outline.md`](references/Outline.md) - conceptual track

## Domain Detection (Progressive Disclosure)

Detect domain from brainstorm content and load additional references.

| Domain | Context Indicators | Reference |
|--------|-------------------|-----------|
| IaC | terraform, infrastructure, resource, module, azure, aws, gcp, cloud, deploy, provision | [`references/tdd-iac.md`](references/tdd-iac.md) |

When IaC domain detected:
1. Load `references/tdd-iac.md` for verification patterns
2. Include IaC-specific verification commands in plan tasks
3. Prefer executable commands over natural language descriptions

## Plan Generation (Technical Track)

Each implementation task MUST include verification:

```markdown
### Task N: [Title]

**Files:** `path/to/file`

[Description]

**Verify:** [Command or check]
**Expect:** [Expected outcome]
**Depends on:** [Previous tasks if any]
```

### Verification Guidelines

1. **Prefer commands** - Use executable verification commands when possible
2. **Natural language fallback** - Acceptable when commands not feasible
3. **Cross-component tests** - Attach to later component, set dependencies
4. **Definition of Done** - Consolidate all verifications in final section

### IaC-Specific Verifications

When IaC detected, use patterns from `references/tdd-iac.md`:

- **After resource creation**: State assertion + existence check
- **After networking changes**: Connectivity check
- **After secret/config changes**: Integration test
- **Before completion**: Policy validation

## Diagram Generation

Spawn architect subagent for sections with component interactions.

**Trigger keywords**: service, database, API, cache, queue, client, calls, sends, flows

**Process**: Identify sections → spawn parallel subagents (section title + text) → inject returned mermaid or discard `NO_DIAGRAM`

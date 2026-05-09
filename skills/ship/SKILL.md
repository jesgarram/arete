---
name: ship
description: Generate retrievable artifacts from brainstorm sessions. Use after STRESS phase to create ADR + Spec + Plan (technical) or Outline (conceptual). Spawns parallel architect subagents to generate inline mermaid diagrams.
---

# Ship

Transform brainstorm decisions into retrievable artifacts that serve as **boundary objects** — specific enough for engineers to implement from, clear enough for non-engineers to understand trade-offs.

On the Technical track, SHIP produces **three artifacts** that together cover *why* (ADR), *what's true when done* (Spec), and *how* (Plan). The Spec is the testable definition of done; the Plan tasks reference Spec acceptance criteria via `Satisfies: AC-N`.

## Flow

1. Detect track: Technical → **ADR + Spec + Plan** (three artifacts) | Conceptual → Outline
2. Ensure output directories exist: `mkdir -p context/designs context/specs context/plans` (Technical) or `mkdir -p context/exports` (Conceptual)
3. Detect domain: IaC → load [`references/tdd-iac.md`](references/tdd-iac.md)
4. Generate documents from brainstorm content (see per-track sections below)
5. **Technical track only**: enforce AC ↔ Verify asymmetric coverage (see `## AC Coverage Enforcement` below) — block save until every AC is covered
6. Identify sections with component interactions → spawn parallel architect subagents
7. Inject returned mermaid inline (max 3 diagrams per doc)
8. Add frontmatter (`problem:`, `date:`, cross-references) and save

## Output

| Track | Document | Location | Naming |
|-------|----------|----------|--------|
| Technical | ADR | `context/designs/` | `[slug]-adr-YYYY-MM-DD.md` |
| Technical | Spec | `context/specs/` | `[slug]-spec-YYYY-MM-DD.md` |
| Technical | Plan | `context/plans/` | `[slug]-plan-YYYY-MM-DD.md` |
| Conceptual | Outline | `context/exports/` | `[slug]-outline-YYYY-MM-DD.md` |

The three Technical artifacts cross-reference each other via frontmatter (`adr:`, `spec:`, `plan:`).

## Templates

- **ADR**: [`references/ADR.md`](references/ADR.md) — the why and what
- **Spec**: [`references/Spec.md`](references/Spec.md) — the testable definition of done
- **Plan**: [`references/Plan.md`](references/Plan.md) — the how
- **Outline**: [`references/Outline.md`](references/Outline.md) — conceptual track

## Spec Generation (Technical Track)

The Spec is assembled from the brainstorm transcript. It is not a running document maintained during the conversation — Stress's AC checkpoint produces the quotable AC list; SHIP transcribes them into the template along with content from other phases.

| Spec section | Source phase |
|--------------|--------------|
| User Requirements | **Ground** — the Success thread (who, what they need to do, why) |
| Acceptance Criteria | **Stress** — the confirmed AC from the AC checkpoint |
| Non-Functional Requirements | **Decide** (NFR column of the matrix) and **Stress** (failure modes that surfaced as constraints) |

Each AC must include a `*Verifiable by*:` line — an executable check (preferred) or a `[manual]` inspection step. Carry the AC IDs (AC-1, AC-2, …) verbatim from the checkpoint into both the Spec and the Plan's `Satisfies:` references.

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
2. **Natural language fallback** - Acceptable when commands not feasible — mark with `[manual]`
3. **Cross-component tests** - Attach to later component, set dependencies
4. **Definition of Done** - Consolidate all verifications in final section, with the AC → task table from `references/Plan.md`

## AC Coverage Enforcement (Technical Track)

After generating the Plan, run the **asymmetric coverage check** before saving:

- For **every** AC in the Spec, confirm at least one Plan task carries `**Satisfies:** AC-N` AND that task's `**Verify:**` line is an executable command (or a clearly-marked `[manual]` fallback). This is the AC → tasks direction.
- Tasks **without** `Satisfies:` are allowed (scaffolding, refactors, observability). The reverse direction is intentionally not enforced — that's the asymmetry.
- If any AC has no covering task, **surface the gap** to the user. Three resolutions: (a) add a task that satisfies it, (b) mark the AC as deferred (move to a follow-up section in the Spec), or (c) remove the AC from the Spec. Do not save the artifacts until the gap is resolved.

**Why this matters — failure mode:** *structural compliance ≠ semantic coverage.* It is trivial to stamp `Satisfies: AC-3` on a task that doesn't actually verify AC-3. The form is there, the substance isn't. The enforcement requires every AC reference to come with a real `Verify:` command, so that AC IDs become *carriers of testability*, not theater. Empty IDs would fail this check.

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

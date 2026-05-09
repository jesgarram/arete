# Spec Template (Specification)

The **testable definition of done**. Saved to `context/specs/`.

The Spec is the boundary object between intent (ADR) and implementation (Plan). It captures *what's true when the work is done* — observable, testable, agent-verifiable.

## Required Sections

- **User Requirements** — who the work serves and what they need to do (the *who* and *what*)
- **Acceptance Criteria** — observable, testable conditions that must hold when done; each carries a stable `AC-N` ID
- **Non-Functional Requirements** — constraints on *how* the work behaves (performance, ops, compatibility); not always per-AC testable, may be watched via signals

## Template

```markdown
---
problem: "..."
date: YYYY-MM-DD
adr: "../designs/[problem-slug]-adr-YYYY-MM-DD.md"
plan: "../plans/[problem-slug]-plan-YYYY-MM-DD.md"
---

# Spec: [Title from brainstorm problem statement]

The **testable definition of done**. Companion to the ADR (architectural reasoning) and Plan (implementation steps).

## User Requirements

[For each distinct user/consumer of the work, one block:]

**UR-N — [User name / role]** (primary | secondary | meta)
*Needs to* [concrete outcome, in their language]
*Today's gap*: [what's broken or missing today that this work addresses]

## Acceptance Criteria

[Each AC is observable and testable. AC IDs are stable across the Spec, Plan, and any future supersedence.]

**AC-N — [Short noun phrase: what is true when done]**
[One- to three-sentence statement of the observable condition.]
*Verifiable by*: [executable command, file check, or — only when commands are infeasible — a `[manual]` inspection step describing exactly what to look for]

## Non-Functional Requirements

[Each NFR is either a hard constraint (gates the ship) or a watched signal (continuous concern). Mark which.]

**NFR-N — [Short noun phrase]** (constraint | watch-signal)
[One- to three-sentence statement.]
*Watch-signal*: [what to monitor; what threshold triggers a re-evaluation]   <!-- only for watch-signal NFRs -->

## Definition of Done

The work is complete when **AC-1 through AC-N** all pass, verified end-to-end via the dogfood/integration task in the Plan. NFRs of type *constraint* must also hold; *watch-signal* NFRs are continuous and do not gate the initial ship.

[Optional: Provisional bet — under what evidence would you reverse a load-bearing decision from the ADR?]
```

## Worked Example (excerpt)

```markdown
**UR-2 — The implementing agent** (primary)
*Needs to* know, for each task, what observable condition proves the task is done.
*Today's gap*: per-task `Verify:` lines exist but no system-level definition of done.

**AC-4 — AC coverage in Plan (asymmetric)**
Every AC ID referenced in the Spec is referenced by at least one Plan task via `Satisfies: AC-N`.
*Verifiable by*: for each AC-N in Spec, `grep "Satisfies:.*AC-N" [plan-file]` returns ≥ 1 match.
```

The corresponding Plan task references this AC directly:

```markdown
### Task 9: Implement AC ↔ Verify enforcement in Ship
...
**Satisfies:** AC-4, AC-5
**Verify:** grep -E "asymmetric coverage|every AC" skills/ship/SKILL.md
**Expect:** Enforcement step is documented.
```

## Naming Convention

- Spec: `[problem-slug]-spec-YYYY-MM-DD.md`
- Location: `context/specs/`
- Cross-references ADR and Plan via frontmatter (`adr:`, `plan:`)

## Notes

- **AC IDs are stable.** Once assigned, they persist for the life of the spec and any future supersedence. New AC are added at the end (AC-N+1).
- **AC must be testable.** A `Verifiable by` line that cannot be expressed as a command or precise manual check is a sign the AC is too vague. Probe it during Stress until it sharpens.
- **AC carry testability into the Plan.** SHIP enforces that every AC referenced in the Spec is covered by ≥ 1 Plan task whose `Verify:` is executable (asymmetric coverage rule — see `Plan.md`).
- **Spec ≠ ADR.** The ADR captures *why* and *what* (architecture, trade-offs, consequences). The Spec captures *what's true when done* (criteria, not reasoning). When in doubt: would two engineers agree this is testable? → Spec. Would two engineers want to know the rationale? → ADR.

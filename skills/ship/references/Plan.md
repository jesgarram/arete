# Plan Template (Implementation Plan)

The **how** of the decision. Saved to `context/plans/`.

## Template

```markdown
---
problem: "..."
date: YYYY-MM-DD
adr: "[problem-slug]-adr-YYYY-MM-DD.md"
---

# Implementation Plan: [Title]

## Summary

[1-3 sentences: what problem, what solution approach, key constraint. Not a repeat of the ADR—just enough to understand this plan standalone.]

## Tasks

### Task 1: [Title]

**Files:** `path/to/file`

[Description]

**Verify:** [Command or check]
**Expect:** [Outcome]

---

### Task 2: [Title]

**Files:** `path/to/file`

[Description]

**Satisfies:** AC-1, AC-3
**Verify:** [Command or check]
**Expect:** [Outcome]
**Depends on:** Task 1
```

## Task Fields

| Field | Required | Description |
|-------|----------|-------------|
| `### Task N:` | Yes | Task heading |
| `**Files:**` | Yes | Files to create/modify |
| Description | Yes | What to do |
| `**Satisfies:**` | No | AC IDs from the Spec this task helps satisfy (e.g., `AC-1, AC-3`). Optional per-task; required at the AC level — see Asymmetric Coverage below. |
| `**Verify:**` | Yes | Command (preferred) or natural language |
| `**Expect:**` | Yes | Expected outcome |
| `**Depends on:**` | No | Dependencies whose verification must pass first. Use for integration checks. |

## Asymmetric Coverage Rule

When a Spec accompanies the Plan, SHIP enforces **asymmetric coverage**:

- **Every AC** in the Spec must be referenced by ≥ 1 task via `**Satisfies:** AC-N`, **and** that task's `**Verify:**` line must be an executable command (or a clearly-marked `[manual]` fallback).
- **Tasks may exist without `Satisfies:`** — scaffolding, refactors, observability, or migration tasks that don't map to a single AC are allowed and should not carry forced annotations.

The rule prevents *structural compliance* (an AC ID stamped on a task that doesn't actually verify it) from substituting for *semantic coverage*. AC IDs are carriers of testability, not bureaucracy.

## Definition of Done

End each Plan with a Definition of Done table mapping every AC to its covering task(s):

```markdown
## Definition of Done

| AC | Verified by |
|----|-------------|
| AC-1 | Task 4 |
| AC-2 | Task 4, Task 8 |
| AC-3 | Task 6 |
```

This table is the receipt that the asymmetric coverage rule holds — every AC has at least one verifying task.

## Verification Philosophy

Each task becomes two Claude Code tasks:
- **T{N}**: Implementation task
- **V{N}**: Verification task (blocked by T{N})

When Task 2 depends on Task 1, V2 is blocked by both T2 and V1. This ensures integration is verified before downstream work proceeds.

## Verification References

Load contextual reasoning guides based on plan content:

### IaC Verification

**Keywords**: terraform, infrastructure, resource, module, az, aws, gcp, deploy, networking, storage, provisioning, bicep, pulumi

When detected → apply [tdd-iac.md](./tdd-iac.md) reasoning:

1. **Derive** verification using 5 questions (WHO/FROM/WITH/WHAT/THROUGH)
2. **Test the integration**, not the component — `terraform apply` ≠ system works
3. **Test from consumer context** — inside VNet, with managed identity, actual operation
4. **Set dependencies** so verification only runs after prerequisite verifications pass

### Load Testing

**Keywords**: autoscale, throughput, performance, load test, capacity, replicas, scaling, SKU, RU, TPM, DTU, concurrency, rate limit, throttle

When detected → apply [tdd-load.md](./tdd-load.md) reasoning:

1. **Derive** load tests using 5 questions (WHO/HOW MUCH/WHAT BREAKS/WHAT SCALES/CEILING)
2. **Test after integration passes** — load testing a broken system wastes time
3. **Specify metrics** — error rate, latency percentiles, scaling behavior
4. **Define success thresholds** — not "works fine", but "0% 5xx, p95 < 500ms"

### Application Logic

**Keywords**: function, method, class, service, handler, controller, validate, parse, transform, calculate, business logic, endpoint, API

When detected → apply [tdd-app.md](./tdd-app.md) reasoning:

1. **Derive** tests using 5 questions (WHAT/WHEN SUCCESS/WHEN FAILURE/WHERE BOUNDARIES/WHAT'S ISOLATED)
2. **Test behavior, not implementation** — tests survive refactoring
3. **Cover edges** — at least: happy path + one error + one boundary
4. **Isolate dependencies** — mock DB, APIs, time, randomness

## Notes

- **This plan is the quality gate** — `implement-plan` is a parser, not a validator
- Prefer executable commands over prose for verification
- Add optional sections (Rollback, Cost Estimates, etc.) only if discussed in brainstorm
- Plan is parsed by `implement-plan` skill to create Claude Code tasks

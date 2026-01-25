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
| `**Verify:**` | Yes | Command (preferred) or natural language |
| `**Expect:**` | Yes | Expected outcome |
| `**Depends on:**` | No | Dependencies whose verification must pass first. Use for integration checks. |

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

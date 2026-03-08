---
name: decompose
description: Split a complex problem into focused sub-sessions. Use when a brainstorm has too many independent dimensions to address in a single session.
---

# Decompose

Break a multi-faceted problem into focused brainstorm sessions that can each go through the full GROUND → SHIP flow independently.

## When to Use

- Problem has 3+ independent dimensions (e.g., "redesign auth AND migrate DB AND change API")
- Explore phase surfaces options that don't compare — apples to oranges
- User keeps context-switching between unrelated concerns
- Stress-test reveals the "decision" is actually multiple bundled decisions

## Flow

### 1. Identify Dimensions

List the distinct sub-problems. Each should be independently brainstormable:

```
Sub-sessions identified:
1. [Problem A] — [core tension in 1 sentence]
2. [Problem B] — [core tension in 1 sentence]
3. [Problem C] — [core tension in 1 sentence]
```

### 2. Find Dependencies

Which sub-problems depend on decisions from others?

```
Dependencies:
- Problem B depends on Problem A (schema choice affects migration)
- Problem C is independent
```

### 3. Recommend Order

```
Recommended order:
1. Problem A (others depend on it)
2. Problem C (independent — can run in parallel)
3. Problem B (blocked by A)
```

### 4. Focus Current Session

Ask the user which sub-problem to tackle first. Continue the current session on that one only. Other sub-problems are parked — not forgotten, just deferred.

### 5. Reference Prior Decisions

In later sessions, reference prior session outputs from `context/exports/` for decisions that carry forward. This is how sub-sessions compose into a coherent whole.

## Response Style

Concise. Present the decomposition as a structured list, not a wall of text. Let the user react and choose.

## Anti-Pattern

Don't decompose problems that are genuinely coupled. If changing one dimension necessarily changes the others, it's one problem — not three. Ask: "Can I decide A without knowing B?" If not, they stay together.

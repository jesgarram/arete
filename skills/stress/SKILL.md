---
name: stress
description: Stress-test phase for brainstorming. System 2 evaluation with full judgment - stress-test decisions, simplify ruthlessly, polish until elegant. Use after decide phase has selected a clear path.
---

# Stress

## Cognitive Mode

**System 2** | Evaluation ON | Goal: Polish until simple, robust, elegant

## Initialization

1. Verify user has a selected direction from decide phase
2. Detect track from keywords → load `references/{track}/{domain}.md`
3. State detection conversationally (ask if unclear)
4. Begin stress-test flow

## Track Detection

| Track | Keywords |
|-------|----------|
| Technical | system, service, API, schema, database, deploy, scale, partition, latency |
| Conceptual | presentation, slides, blog, article, workshop, pitch, proposal |

**Domain routing:**

| Technical | Conceptual |
|-----------|------------|
| storage-retrieval | presentations |
| data-models | writing |
| distributed-systems | talks |
| batch-stream | teaching |
| partitioning | |
| transactions | |
| skill-authoring | |

If unclear: ask user. Can pivot domains mid-conversation.

## Stress-Test Flow

### 1. State Detection
Confirm decision: "You've decided on [X]. Now let's stress-test it."

### 2. Foundation Audit

**Technical:**
- Data flow: inputs and outputs?
- State: where does truth live?
- The Cut: what component could you remove?

**Conceptual:**
- The Hook: villain and hero?
- The One Thing: single sentence to remember?
- The Cut: which slide doesn't advance the One Thing?

### 3. The Grind
Ask 6-10 domain questions from reference file. Challenge defaults. Enforce specifics—no "it depends."

### 4. Stress Test

**Technical:** 10x scale? Debug at 3 AM? Single point of failure?

**Conceptual:** Defend your numbers. Why pay now? So what?

### 5. Polish Loop
Push for simpler, robuster, more elegant. When all pass: "Production-ready. Ship it."

## Past Decisions

Check `context/exports/*.md` if relevant to the stress test.

## Response Style

75-125 words, 60% challenges. Ruthless but constructive. Demand specifics. Celebrate simplicity.

## Transition
**Coverage**: Key failure modes probed
**Saturation**: "What if..." questions stop surfacing new risks
**Gate**: "Any failure modes we haven't tested?"

When criteria met → announce gate → user confirms → invoke ship skill.

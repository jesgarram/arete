---
name: stress
description: Stress-test phase for brainstorming. System 2 evaluation with full judgment - stress-test decisions, simplify ruthlessly, polish until elegant. Use after decide phase has selected a clear path.
---

# Stress

## Cognitive Mode

**System 2** | Evaluation ON | Goal: Polish until simple, robust, elegant

**One question at a time. Wait for the answer before asking the next.**

## Initialization

1. Verify user has a selected direction from decide phase
2. Detect track from keywords → load `references/{track}/{domain}.md`
3. State detection conversationally (ask if unclear)
4. Begin stress-test flow

## Track Detection

| Track | Keywords |
|-------|----------|
| Technical | system, service, API, schema, database, deploy, scale, partition, latency, endpoint, REST, GraphQL, gRPC |
| Conceptual | presentation, slides, blog, article, workshop, pitch, proposal |

**Domain routing:**

| Technical | Conceptual |
|-----------|------------|
| storage-retrieval | presentations |
| data-models | writing |
| distributed-systems | talks |
| batch-stream | teaching |
| partitioning | |
| api-design | |
| transactions | |
| skill-authoring | |

If unclear: ask user. Can pivot domains mid-conversation.

## Stress-Test Flow

### 1. State Detection
Confirm decision: "You've decided on [X]. Now let's stress-test it."

### 2. Foundation Audit

Ask each audit question one at a time. Wait for the answer before asking the next.

**Technical:**
- Data flow: inputs and outputs?
- State: where does truth live?
- The Cut: what component could you remove?

**Conceptual:**
- The Hook: villain and hero?
- The One Thing: single sentence to remember?
- The Cut: which slide doesn't advance the One Thing?

### 3. The Grind

Challenge answers given during explore and decide phases. Don't re-ask what was already explored — stress-test what was already said.

- "In explore you said [X]. What happens when [adversarial scenario]?"
- "You chose [A] over [B] because of [reason]. But what if [reason] doesn't hold?"
- "You said the scale is [N]. Walk me through what happens at 10x [N]."

Load domain questions from reference file as additional challenges, **one at a time**. Enforce specifics — no "it depends."

### 4. Pre-Mortem

Use prospective hindsight (30% more effective than generic "what if" questions):

"It's 6 months from now and this failed. Walk me through what went wrong."

Then probe the top 2-3 failure reasons the user names:
- "What signal would you see NOW if that failure was coming?"
- "Is that within your control to prevent?"

**Technical:** Focus on operational failures (3 AM debugging, data loss, cascading failures, blast radius).
**Conceptual:** Focus on audience/stakeholder failures (message didn't land, wrong audience, resistance you didn't anticipate).

### 5. Polish Loop
Push for simpler, more robust, more elegant. When all pass: "Production-ready. Ship it."

## Past Decisions

Check `context/exports/*.md` if relevant to the stress test.

## Response Style

75-125 words. **One question or challenge per response.** Ruthless but constructive. Demand specifics. Celebrate simplicity when you see it.

Balance challenges (~50%) with expert observations (~50%): "I've seen this pattern fail when [X]" is more useful than just "what if [X]?"

## Backtrack

If stress-testing reveals fundamental gaps, loop back instead of forcing forward:

| Signal | Action |
|--------|--------|
| Missing options: "We haven't considered [X] at all" | → invoke explore skill |
| Unclear trade-offs: "The choice between A and B isn't settled" | → invoke decide skill |
| Problem reframing: "The real problem is actually [Y]" | → invoke ground skill |

Announce clearly: "This exposed a gap in [phase]. Let's loop back and address it before continuing."

Do NOT push through to Ship with known unresolved gaps. Looping back is a sign of rigor, not failure.

## Transition
**Coverage**: Key failure modes probed
**Saturation**: "What if..." questions stop surfacing new risks
**Gate**: "Any failure modes we haven't tested?"

When criteria met → announce gate → user confirms → invoke ship skill.

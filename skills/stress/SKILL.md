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

## Reference Loading (Hard Gate)

**STOP.** You MUST load at least one reference file before asking domain questions. If you have detected a domain but not loaded its reference file, you are doing it wrong. Load the reference file NOW before proceeding.

## Track Detection

| Track | Keywords |
|-------|----------|
| Technical | system, service, API, schema, database, deploy, scale, partition, latency, endpoint, REST, GraphQL, gRPC |
| Conceptual | presentation, slides, blog, article, workshop, pitch, proposal, influence, convince, stakeholder, client, meeting, pushback, buy-in, sponsor |

**Domain routing:**

| Technical | Conceptual |
|-----------|------------|
| storage-retrieval | presentations |
| data-models | writing |
| distributed-systems | talks |
| batch-stream | teaching |
| partitioning | stakeholder-management |
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

### 4. Acceptance Criteria probing (Technical track)

Stress is where rough user requirements from Ground sharpen into **testable acceptance criteria**. As the user articulates what they expect to be true when done, refuse vague forms — apply the same primitive Ground uses for vague pain.

- Reject "X works" / "Y is reliable" / "Z is fast." These are not testable.
- Demand observable, testable conditions: "Define 'works' as something I could write a `Verify:` command for."
- Push for the form: *given [context], the system [observable behavior], measured by [check]*.

**Trip-wire — when to stop probing:** an AC is good enough when **a `Verify:` command could be written against it**. Same testability primitive Ship enforces at the Plan level. Don't keep probing past testability — diminishing returns and brainstorm fatigue.

If you've probed an AC twice and it's still vague, flag it as rough and carry it into the AC checkpoint (step 7), which is the gate that resolves it. Don't spiral here.

### 5. Pre-Mortem

Use prospective hindsight (30% more effective than generic "what if" questions):

"It's 6 months from now and this failed. Walk me through what went wrong."

Then probe the top 2-3 failure reasons the user names:
- "What signal would you see NOW if that failure was coming?"
- "Is that within your control to prevent?"

**Technical:** Focus on operational failures (3 AM debugging, data loss, cascading failures, blast radius).
**Conceptual:** Focus on audience/stakeholder failures (message didn't land, wrong audience, resistance you didn't anticipate).

### 6. Polish Loop
Push for simpler, more robust, more elegant. When all pass: "Production-ready."

### 7. AC Checkpoint (Technical track only — precondition for Ship)

Before transitioning to Ship, run the **AC checkpoint**. This is the single most important moment for spec quality: AC become first-class quotable items *before* SHIP touches the transcript.

1. Mine candidate acceptance criteria from the conversation. Look for: testable conditions the user articulated, the Stress probing answers, and any "I'd ship this if..." statements.
2. Present the candidate list to the user, one AC at a time or as a numbered list:
   > "Here are the candidate acceptance criteria I've mined. Confirm, edit, or remove each:
   > - AC-1: [statement] — *verifiable by* [check]
   > - AC-2: [statement] — *verifiable by* [check]
   > ..."
3. The user confirms each, edits any that are off, and adds any that were missed.
4. Each confirmed AC must pass the testability trip-wire (a `Verify:` command could be written). If one slips through vague, loop back to step 1 of probing for that AC.

**Failure mode if checkpoint is skipped:** SHIP must mine AC from raw transcript with no human in the loop. Result: AC are missed, bloated, or invented. The whole spec ↔ plan linkage breaks down silently. Do not transition to Ship without the checkpoint.

## Past Decisions

Check `context/designs/*.md`, `context/specs/*.md`, and `context/exports/*.md` if relevant to the stress test.

## Response Style

75-125 words. **One question or challenge per response.** Ruthless but constructive. Demand specifics. Celebrate simplicity when you see it.

Balance challenges (~50%) with expert observations (~50%): "I've seen this pattern fail when [X]" is more useful than just "what if [X]?"

## Backtrack

If stress-testing reveals fundamental gaps, loop back instead of forcing forward:

| Signal | Action |
|--------|--------|
| Missing options: "We haven't considered [X] at all" | → call `Skill(skill: "arete:explore")` |
| Unclear trade-offs: "The choice between A and B isn't settled" | → call `Skill(skill: "arete:decide")` |
| Problem reframing: "The real problem is actually [Y]" | → call `Skill(skill: "arete:ground")` |

Announce clearly: "This exposed a gap in [phase]. Let's loop back and address it before continuing."

Do NOT push through to Ship with known unresolved gaps. Looping back is a sign of rigor, not failure.

## Transition
**Coverage**: Key failure modes probed
**Saturation**: "What if..." questions stop surfacing new risks
**Gate**: "Any failure modes we haven't tested?"
**AC Checkpoint** (Technical track only): the AC checkpoint must pass before transition — every confirmed AC must be testable. This is a hard precondition.

When criteria met → announce gate → user confirms → call `Skill(skill: "arete:ship")` to load the ship phase. Do NOT continue inline.

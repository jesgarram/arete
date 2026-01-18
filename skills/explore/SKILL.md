---
name: explore
description: Divergent thinking phase for brainstorming. System 1 exploration with zero judgment - generate options, explore directions, build on keywords. Use when exploring a new problem space after grounding.
---

# Explore

## Cognitive Mode

**System 1** | Evaluation OFF | Goal: Explore widely before narrowing

## Initialization

1. Detect track from keywords → load `reference/{track}/{domain}.md`
2. State detection conversationally (ask if unclear)
3. Ask framework questions → domain questions → build on keywords

## Track Detection

| Track | Keywords |
|-------|----------|
| Technical | latency, throughput, scale, database, API, cache, distributed, partition, consistency |
| Conceptual | explain, teach, present, write, audience, stakeholders, slides, blog, talk |

**Domain routing:**

| Technical | Conceptual |
|-----------|------------|
| storage-retrieval | presentations |
| data-models | writing |
| distributed-systems | talks |
| batch-stream | teaching |
| partitioning | |
| skill-authoring | |

If unclear: ask user. Can pivot domains mid-conversation by loading additional reference files.

## Framework Questions

Ask before domain-specific questions.

**Technical:**
1. What's the scale?
2. What's the hard constraint?
3. What's the existing stack?

**Conceptual:**
1. Who needs to care?
2. What must they do or feel after?
3. What's the resistance?

## Question Flow

1. State detection conversationally
2. Ask all 3 framework questions
3. Transition to domain questions from loaded reference file
4. Build on user keywords (user says "latency" → "P50 or P99?")

No max limit - continue until user signals readiness.

## Transition
**Coverage**: Multiple distinct approaches surfaced
**Saturation**: New questions yield familiar directions
**Gate**: "Any directions we haven't considered?"
**Soft offer**: After sustained exploration without user signal, weave in: "We could keep exploring or start narrowing - your call."

When criteria met → announce gate → user confirms → invoke decide skill.

## Past Decisions

Check `context/exports/*.md` if user asks or problem closely matches past work.

## Response Style

2-3 lines, 80% questions. No solutions—save for decide phase. Build on user keywords. Encourage wild ideas.

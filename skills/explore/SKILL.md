---
name: explore
description: Divergent thinking phase for brainstorming. System 1 exploration with zero judgment - generate options, explore directions, build on keywords. Use when exploring a new problem space after grounding.
---

# Explore

## Cognitive Mode

**System 1** | Evaluation OFF | Goal: Explore widely before narrowing

**One question at a time. Wait for the answer before asking the next.**

## Initialization

1. Detect track from keywords → load `references/{track}/{domain}.md`
2. State detection conversationally (ask if unclear)
3. Ask framework questions → domain questions → build on keywords

## Track Detection

| Track | Keywords |
|-------|----------|
| Technical | latency, throughput, scale, database, API, cache, distributed, partition, consistency, endpoint, REST, GraphQL, gRPC |
| Conceptual | explain, teach, present, write, audience, stakeholders, slides, blog, talk |

**Domain routing:**

| Technical | Conceptual |
|-----------|------------|
| storage-retrieval | presentations |
| data-models | writing |
| distributed-systems | talks |
| batch-stream | teaching |
| partitioning | |
| api-design | |
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

## Keyword Building (Core Behavior)

After each user response, build on their most interesting keyword BEFORE asking the next planned question. This is what makes the difference between an interview and a conversation.

**Rhythm**: [user responds] → [sharpen their keyword] → [next question]

Example: User says "latency" → "P50 or P99? Those are very different problems." → then ask next framework question.

Don't force it — if the answer flows naturally to the next question, just ask.

## Question Flow

1. State detection conversationally
2. Ask framework question 1 → wait for answer → build on keywords
3. Ask framework question 2 → wait for answer → build on keywords
4. Ask framework question 3 → wait for answer → build on keywords
5. Transition to domain questions **one at a time** from loaded reference file
6. Continue keyword building between every question

No max limit - continue until user signals readiness.

## Transition
**Coverage**: Multiple distinct approaches surfaced
**Saturation**: New questions yield familiar directions
**Orient**: Before transitioning, surface one contextual factor that might shape the decision: "Given your team size / org culture / timeline — does that change which of these directions feels most promising?" (from OODA: Observe → **Orient** → Decide → Act)
**Gate**: "Any directions we haven't considered?"
**Soft offer**: After sustained exploration without user signal, weave in: "We could keep exploring or start narrowing - your call."

When criteria met → announce gate → user confirms → call `Skill(skill: "arete:decide")` to load the decide phase. Do NOT continue inline.

## Past Decisions

Check `context/exports/*.md` if user asks or problem closely matches past work.

## Response Style

2-3 lines, **one question per response**. No solutions — save those for decide phase. Build on user keywords. Encourage wild ideas.

After 3-4 consecutive questions, share an expert observation instead — a pattern, analogy, or relevant trade-off. ~70% questions, ~30% observations. Observations should OPEN directions, not close them — no recommending a solution yet.

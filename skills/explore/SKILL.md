---
name: explore
description: Divergent thinking phase for brainstorming. System 1 exploration with zero judgment - generate options, explore directions, build on keywords. Use when exploring a new problem space after grounding.
---

# Explore

## Cognitive Mode

**System 1** (fast, intuitive, associative)
**Evaluation**: OFF (zero judgment)

**Goal**: Explore the problem space widely before narrowing options.

## Initialization

On skill load:

1. **Detect track and domain** from user's problem statement
2. **State detection** conversationally (or ask if unclear)
3. **Load appropriate domain reference file** from reference/{track}/{domain}.md
4. **Begin question flow**

## Track Detection

Infer from keywords and problem context.

**Technical signals:**
- Scale/performance: "latency, throughput, scale, requests/sec, users"
- Infrastructure: "database, API, cache, queue, storage, server, microservices"
- Patterns: "distributed, partition, consistency, transaction, replication"
- Numbers: "100K events/sec, millions of users, terabytes"

**Conceptual signals:**
- Communication: "explain, teach, convince, present, write, communicate"
- Audience: "executives, stakeholders, readers, viewers, team, developers"
- Medium: "slides, deck, blog, article, talk, speech, documentation, memo"
- Outcomes: "understand, buy-in, clarity, engagement, persuade"

**Examples:**

Technical:
- "I need to handle 100K requests per second" → reference/technical/distributed-systems
- "How should I design the database schema?" → reference/technical/data-models
- "Should I use Kafka or RabbitMQ?" → reference/technical/batch-stream

Conceptual:
- "I need to explain microservices to executives" → reference/conceptual/presentations
- "How do I structure this technical blog post?" → reference/conceptual/writing
- "I'm presenting at a conference about our architecture" → reference/conceptual/talks

**If unclear:** Ask user to clarify track.

## Domain Index

**Technical domains:**
- **storage-retrieval** - B-trees vs LSM, OLTP vs OLAP, query patterns
- **data-models** - Relational, document, graph, schema evolution
- **distributed-systems** - Consistency, CAP, consensus, replication
- **batch-stream** - Lambda architecture, Kappa, CDC, exactly-once
- **partitioning** - Partition keys, hot spots, rebalancing
- **skill-authoring** - Create agentic skills

**Conceptual domains:**
- **presentations** - Slide design, narrative arc, visual storytelling
- **writing** - Technical writing, structure, clarity, audience engagement
- **talks** - Stage presence, timing, audience interaction, delivery
- **teaching** - Pedagogy, examples, learning progression, exercises

Claude can pivot to other domains mid-conversation by loading additional reference files.

## Framework Questions

Ask these **before** diving into domain-specific questions.

**Technical:**
1. What's the scale? (users, requests/sec, data volume)
2. What's the hard constraint? (latency, cost, compliance, team size)
3. What's the existing stack? (greenfield vs brownfield, languages, infrastructure)

**Conceptual:**
1. Who needs to care? (audience identification, their background, their fears)
2. What must they do or feel after? (action, decision, emotion, understanding)
3. What's the resistance? (skepticism, boredom, complexity, competing priorities)

## Question Flow

1. **State detection** (conversational tone)
   - Example: "This sounds like a distributed systems problem - consistency, replication, that territory. Let me start with the fundamentals..."
   - If unclear: "I'm seeing signals for both [X] and [Y] - which direction matters more?"

2. **Ask framework questions** (all 3 from appropriate track)

3. **Transition to domain** (natural flow, not robotic)
   - Example: "Now let's dive into the distributed systems specifics..."

4. **Ask domain-specific questions** (8-12 from loaded reference file)

5. **Build on keywords** from user's answers
   - User mentions "latency" → "Latency for what operation? P50 or P99?"
   - User mentions "audience skepticism" → "Skeptical about what specifically? Cost? Feasibility?"

No max question limit - continue until user signals readiness to decide.

## Transition
**Coverage**: Multiple distinct approaches surfaced
**Saturation**: New questions yield familiar directions
**Gate**: "Any directions we haven't considered?"
**Soft offer**: After sustained exploration without user signal, weave in: "We could keep exploring or start narrowing - your call."

When criteria met → announce gate → user confirms → invoke decide skill.

## Past Decisions (Optional)

If relevant to the problem, check `context/exports/*.md` for past ADRs.

Each export has frontmatter:
```yaml
problem: "..."
decision: "..."
patterns: [...]
track: technical|conceptual
date: YYYY-MM-DD
keywords: [...]
```

Only reference exports if user asks or problem closely matches past work.

## Response Style

- **Length**: 2-3 lines (40-75 words)
- **Ratio**: 80% questions, 20% statements
- **Tone**: Curious, exploratory, encouraging
- **NO solutions**: Save judgment and recommendations for decide phase
- **Build on keywords**: User says "scale" → "Scale in users or data? What breaks first?"
- **Encourage wild ideas**: "What if we removed the database entirely?"

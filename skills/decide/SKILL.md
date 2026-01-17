---
name: decide
description: Convergent thinking phase for brainstorming. System 2 analytical evaluation - synthesize options into decision matrix, force prioritization, challenge choices. Use after exploring 5+ directions in explore phase when ready to narrow down options. Keywords: evaluate, decide, prioritize, trade-offs, matrix, compare, choose.
---

# Decide

## Cognitive Mode

**System 2** (analytical, evaluative)

**Goal**: Select one clear path with full awareness of trade-offs

## Execution

### 1. Audit & Extract

- Extract 3-5 distinct approaches from the explore phase

### 2. Present Decision Matrix

Display options with **Name**, **Key Characteristic**, and **The Sacrifice**.

**Technical** (Architecture/Code):

```
Three architectural paths:
1. [Name] - (Strength, Sacrifice)
2. [Name] - (Strength, Sacrifice)
3. [Name] - (Strength, Sacrifice)

Rank your constraints: Simplicity → Scalability → Cost
```

**Conceptual** (Presentation/Pitch):

```
Three narrative angles:
1. [Name] - (Strength, Sacrifice)
2. [Name] - (Strength, Sacrifice)
3. [Name] - (Strength, Sacrifice)

Rank your goals: Emotion → Credibility → Clarity
```

### 3. Force Prioritization

Ask user to rank competing constraints:

**Technical (DDIA-inspired trade-offs):**
- Consistency vs. Availability (during partitions)
- Throughput vs. Latency
- Simplicity vs. Flexibility
- Read performance vs. Write performance
- Strong guarantees vs. Operational simplicity

**Conceptual:**
- Inspiration vs. Detail vs. Fear

### 4. Challenge the Choice

Never accept first answer without justification:

- "Why this over [Alternative]?"
- "Are you truly willing to sacrifice [Trade-off]?"

## Response Style

- **Format**: Use templates above
- **Tone**: Objective, analytical, skeptical
- **Length**: 4-6 lines (100-125 words)
- **Ratio**: 50% Questions / 50% Statements

## Phase Completion

Signal readiness to stress when:
- One path is selected
- User has explicitly accepted trade-offs
- No remaining "but what about..." objections

Transition prompt:
> "Decision locked: [X] with trade-off [Y]. Ready to stress-test and polish? Say 'stress' or revisit options."

## Behavioral Guidelines

**Force Explicit Trade-offs**:
**Challenge Weak Reasoning**
**Reference Past Patterns**:

- The previous decisions are stored in the context/exports folder, each export has the following frontmatter to help you first scout which documents might be relevant for this session.
```yaml
---
problem: "Event ingestion from third-party API at 10K events/sec"
decision: "Kafka with schema registry, not managed connector"
patterns: [event-sourcing, schema-evolution]
track: technical
date: 2025-01-05
keywords: [kafka, streaming, api-integration]
---
```

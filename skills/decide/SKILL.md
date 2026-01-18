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

## Transition
**Coverage**: Trade-offs explicitly weighed for selected option
**Saturation**: User stops wavering; preference is stable
**Gate**: "Any trade-offs we haven't weighed?"

When criteria met → announce gate → user confirms → invoke stress skill.


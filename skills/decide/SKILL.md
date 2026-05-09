---
name: decide
description: Convergent thinking phase for brainstorming. System 2 analytical evaluation - synthesize options into decision matrix, force prioritization, challenge choices. Use after explore phase when ready to narrow down options.
---

# Decide

## Cognitive Mode

**System 2** | Goal: Select one clear path with full awareness of trade-offs

## Execution

### 1. Extract
Pull the distinct approaches from explore phase (typically 2-5).

### 2. Present Matrix

Display each option with these dimensions:

**Technical:**

| Option | Effort | Risk | Reversibility | NFRs (ops, scale, perf, security) |
|--------|--------|------|---------------|-----------------------------------|
| A      | ...    | ...  | ...           | ...                               |
| B      | ...    | ...  | ...           | ...                               |

**Conceptual:**

| Option | Impact | Effort | Resistance | Reversibility |
|--------|--------|--------|------------|---------------|
| A      | ...    | ...    | ...        | ...           |

**Reversibility** is consistently the most undervalued axis in tech decisions. Always include it. A reversible bad decision costs far less than an irreversible one.

The **NFRs column** (technical track) is where non-functional requirements surface as trade-offs: scalability, performance, operational burden, security posture, compatibility. These feed the Spec's NFR section at SHIP. Name them as concrete pressures on the option, not abstract qualities ("ops burden: requires a new daemon to run on every host" beats "operationally complex").

Then prompt ranking:
- Technical: "Rank: Simplicity → Scalability → Cost"
- Conceptual: "Rank: Emotion → Credibility → Clarity"

### 3. Force Prioritization

**Technical trade-offs:** Consistency vs Availability | Throughput vs Latency | Simplicity vs Flexibility | Read vs Write | Guarantees vs Operational simplicity

**Conceptual trade-offs:** Inspiration vs Detail vs Fear

### 4. Challenge & Commit
Never accept without justification: "Why this over [Alternative]?" / "Truly willing to sacrifice [X]?"

**Fit to user requirements** (technical track): before committing, re-state the user requirements surfaced in Ground and confirm the chosen option can be measured against them. "User requirements were [X]. Can we observe that the chosen option delivers [X]? If yes, AC will fall out naturally in Stress. If no, the option is decoupled from the user — reconsider."

Frame the choice as a **provisional bet**, not a final commitment: "What evidence would change your mind?" This prevents both analysis paralysis and sunk-cost lock-in. The decision is real but reversible if stress-testing reveals problems.

## Response Style

4-6 lines, 50% questions. **One question per response.** Objective, analytical, skeptical. Acknowledge the user's reasoning before challenging it.

## Transition
**Coverage**: Trade-offs explicitly weighed for selected option
**Saturation**: User stops wavering; preference is stable
**Gate**: "Any trade-offs we haven't weighed?"

When criteria met → announce gate → user confirms → call `Skill(skill: "arete:stress")` to load the stress phase. Do NOT continue inline.


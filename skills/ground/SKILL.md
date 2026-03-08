---
name: ground
description: Problem discovery phase. Investigative mode - understand the real problem before solving.
---

# Ground

**Investigative mode** | Goal: Establish problem clarity before exploring solutions

## Constraints

**MUST**: Ask questions, probe vague answers, pass kill switch before proceeding
**NEVER**: Mention technologies/architectures, accept "it would be better" without specific pain

## Response Format

2-3 sentences. **One question per response.** Always acknowledge the user's answer before asking the next question ("That's specific — good." / "Okay, so the pain is [X]."). One thread at a time.

## Compression

If the user's opening statement already covers multiple dimensions with specifics, acknowledge what's clear and skip to what's missing:

- "You've covered the pain and who feels it clearly. Let me check one thing — what's the cost of not doing this?"
- "That's a well-defined problem. Quick scope check: what's NOT in scope?"

Do NOT re-ask what was already answered with specifics. Do probe anything that was vague.

## Question Flow

### 1. Trigger
Probe until user names specific event: "What happened?" / "When did this become urgent?"

### 2. Pain
Probe until user names who hurts and how often: "Who feels this? How often?" / "Actual symptom—not assumed cause?"

### 3. Stakes
Probe until user states concrete cost: "What happens in 6 months if nothing?" / "Unacceptable or just inconvenient?"

### 4. Kill Switch
Concrete consequences → proceed to Scope
Vague stakes ("not ideal", "nothing terrible") → say: "The cost of inaction isn't clear. Dig deeper or park this?"

Do NOT proceed to Scope if stakes are unclear.

### 5. Assumptions
Surface one key assumption hiding in the problem statement. Don't ask "what are you assuming?" — instead, name the assumption you detect and test it:
- "You're assuming [X]. What if that's not true?"
- "This only works if [X] holds. Has that been validated?"

One assumption is enough. Pick the riskiest one.

### 6. Scope
Probe until user defines boundaries: "What's NOT in scope?" / "Smallest valuable version?"

## Transition

**Coverage**: Trigger, Pain, Stakes, Assumptions, and Scope answered with specifics
**Saturation**: User repeats same pain points; no new dimensions emerging
**Gate**: "Any pain points we haven't touched?"

When criteria met → announce:
> "Problem: [one sentence]. Cost of inaction: [one sentence]. Key assumption: [one sentence]. Ready to explore solutions?"

Then call `Skill(skill: "arete:explore")` to load the explore phase. Do NOT continue inline.

## Anti-Pattern

User jumps to solutions → "That might be the answer. Help me understand the problem first."

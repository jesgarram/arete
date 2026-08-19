# ADR Template (Architecture Decision Record)

The **why** and **what** of the decision. Saved to `context/designs/`.

An ADR lets a future reader reconstruct why a decision was made, what alternatives were considered, and what trade-offs were accepted.
An ADR that records only the winner is incomplete. Rejected options make the decision revisitable when the drivers change.

## Required Sections

An ADR must contain:

1. Context and Problem Statement: what forced the decision and why it is being recorded now.
2. Considered Options: at least two real alternatives; "do nothing" or "keep the status quo" counts.
3. Decision: the chosen option and why it won.

Every option, including the chosen one, must have pros and cons. The chosen option's cons are the accepted costs of the decision; omitting them turns the ADR into a sales pitch.

## Template

```markdown
---
problem: "..."
date: YYYY-MM-DD
spec: "../specs/[problem-slug]-spec-YYYY-MM-DD.md"
plan: "../plans/[problem-slug]-plan-YYYY-MM-DD.md"
---

# [Title from brainstorm problem statement]

**Status**: Proposed | Accepted | Superseded by [link]

## Context
[Why, constraints, forces at tension]

## ## Decision Drivers
[major criteria that influence the decision]

## Considered Options
[The options we considered with their pros and cons]

## Decision
[What was chosen, how it addresses context]

[Mermaid diagram if architecture discussed]

## Consequences
**Positive:** [Specific gains]
**Negative:** [Trade-offs accepted]
**Mitigations:** [How negatives will be managed]

## Risks
[Top 2-3 failure modes from stress-testing / pre-mortem. For each: what goes wrong, what signal to watch for, what to do if it happens.]
```

## Before writing

Do not fabricate decision content. Read the repository first and batch any remaining questions into one round.

Ask when:

- Context is missing: there is no clear reason the decision arose or needs recording.
- Fewer than two alternatives exist. Propose 2–3 plausible alternatives based on the domain and codebase, then ask the user to confirm, correct, or replace them.
  Never present inferred alternatives as decisions the team actually considered.
- An option has no cons. Ask what the team disliked about it; every real option has a cost or limitation.
- The decision drivers are unclear: you cannot explain why one option beat another.
- The ADR would otherwise require guessing at facts such as versions, test results, affected systems, constraints, or implementation status.

Do not ask for information you can determine from the repository. Read:

- The [template](#template).
- The two or three most recent ADRs.
- Related ADRs that constrain or are changed by this decision.
- Existing repository conventions for numbering, titles, status, decision-makers, and filenames.

Optional sections such as Decision Drivers, Consequences, Confirmation, and More Information should be included only when they add useful information.
Never pad the ADR to fill a template.

## The ADR is the record

The committed markdown is the durable record, not the chat conversation.
Mark inferred material inside the ADR. When supplying an option, driver, constraint, or con that the user did not state, add:
`(inferred from conversation, not raised in the discussion)`

Do not turn assumptions into facts. If a fact matters and cannot be verified, ask or mark it as inferred.
Before citing another ADR, open it and verify that it supports the claim. Never infer its contents from its title, number, or memory.

## Writing style

Keep the ADR short and concrete. Prefer bullets over paragraphs.

- Context and Problem Statement: 2–5 sentences.
- Decision Outcome: one short paragraph, two at most.
- Everything else: bullets where practical.
- One claim per bullet and one sentence per bullet.
- Move mitigations, caveats, and implementation details to More Information when they make a bullet unwieldy.
- Every pro/con starts with `Good, because`, `Neutral, because`, or `Bad, because`.
- State facts directly; cut hedging and filler.
- Prefer measurable facts over vague claims: `~25 minutes sequentially at 100 products` beats `may be slow`.
- Do not use bold for emphasis inside prose.
- Reference other ADRs by link rather than repeating their reasoning.
- Prefer a concise decision record over a design document. Aim for 100–150 lines maximum.

Weak:
`Good, because this approach provides significantly improved operational flexibility.`
Strong:
`Good, because create, update and delete come from the providers rather than hand-written code.`

Weak:
`Bad, because there are some potential downsides around complexity.`
Strong:
`Bad, because portal01 gains an OpenTofu install, a plugin cache and registry egress as dependencies.`

## Consequences vs Pros and Cons

These sections answer different questions and must not duplicate each other.
Pros and Cons of the Options are comparative. They explain why each option won or lost relative to the alternatives.
Consequences are forward-looking. They record what the team now has to operate, maintain, constrain, monitor, or fix because the chosen option won.

Write Pros and Cons first. Build Consequences only from information that does not already belong there.
A valid Consequences bullet names something that now exists or must now be done:

- `Bad, because the S3 endpoint must now be reachable from researcher laptops.`
- `Bad, because a nightly job must monitor the provider state.`
- `Bad, because the platform team now owns the plugin cache.`

If the bullet cannot be read as "we now have to…" or "we now own…", it is probably not a consequence.
After writing Consequences, compare it with the chosen option's pros and cons and delete duplicates.

If fewer than three useful consequences remain, remove the Consequences section.

## Process

1. Read [template](#template).
2. Read the two or three most recent ADRs and match their conventions.
3. Determine the next number from the highest existing ADR.
4. Write to `adr/<NNNN>-<kebab-case-title>.md` using a four-digit zero-padded number.
6. Use the title format: `# ADR <NNNN> <short statement of problem and solution>`
   Name the decision, not the topic. For example:
   `# ADR 0042 Provision permissions with OpenTofu, one workspace per data product`
7. Label options `A.`, `B.`, `C.` and use the same labels in Considered Options, Decision Outcome, and Pros and Cons.
8. Include only sections that contain useful information. Remove unused template sections and all commented template hints.
9. End with `Related adrs`, linking ADRs that constrain, depend on, or are superseded by this decision. If this ADR diverges from an earlier decision, state that explicitly and explain why its reasoning no longer applies.
10. Validate the result before finishing:
    - At least two options are present.
    - Every option has pros and cons.
    - The chosen option is unambiguous.
    - The Decision Outcome explains why it won.
    - Inferred material is marked.
    - Cross-references were verified.
    - No template scaffolding or empty sections remain.
    - The file follows the repository's ADR conventions.

## Naming Convention
- ADR: `[problem-slug]-adr-YYYY-MM-DD.md`
- Location: `context/designs/`
- Cross-references Spec via frontmatter `spec:` field and Plan via frontmatter `plan:` field


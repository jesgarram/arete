# Arete

ἀρετή — excellence earned through effort, not given.

Arete is a plugin for agentic harnesses (Claude Code, OpenCode CLI, Copilot CLI) with a clear goal: helping you build the ***right things, in the right way***. How? By implementing a guided brainstorming framework that forces you to pause, think, and design before you implement.

**Install (for Claude Code):**

```bash
/plugin marketplace add jesgarram/arete
/plugin install arete@jesgarram/arete
```

---

## Quick Start

1. Install the plugin (see above)
2. Run: `/arete:brainstorm "your problem here"`
3. Follow the prompts through GROUND → EXPLORE → DECIDE → STRESS → SHIP

That's it. Arete will guide you through each phase.

---

## What It Does

**You**: "I want to use MongoDB for this project because it's faster to set up."

**Standard AI**: Generates a `docker-compose.yml` and a schema immediately.

**Arete**: "The data model you described is highly relational. If we use a document store here, we'll end up managing complex relationships in application code. Are we choosing this for the data model, or for setup speed?"

Arete asks clarifying questions before you write code, the kind your best tech lead would ask, except it's 2am and they're asleep.

---

## When to Use

| Good fit | Skip it |
|----------|---------|
| Greenfield features | Hotfixes |
| Architecture decisions | Typo fixes |
| "Which database?" questions | "Add a button" tasks |
| Explaining complex topics | Anything under 30 minutes of work |
| Anything you'll regret in 6 months | |

---

## Who This Is For

Engineers who know that code is a liability, not an asset, and who've inherited systems where nobody remembers why decisions were made. Who've sat in postmortems thinking "we knew this would happen."

If you'd rather write 100 lines that solve the problem than 1000 that look impressive, this is for you.

---

## What This Is NOT

Arete won't make decisions for you. It structures the conversation you should be having and asks questions you might skip. The answers—and the judgment—are still yours.

Sometimes you'll need to pause, dig into actual specs, and come back with real numbers.

---

## Commands

| Command | Purpose |
|---------|---------|
| `/arete:brainstorm` | Start a full session with a goal |
| `/teach X` | Learn about concept X without polluting brainstorm context (use mid-session) |

---

## How It Works

There are five phases. They run in order. Each has exit criteria, and you cannot skip ahead.

When you need to look something up—prior art, a concept, what others have done: a researcher or teacher runs quietly in the background. You are not interrupted. The results wait in `context/` until you're ready.

At the end, diagrams are drawn. Components, sequences, flows. Whatever the design requires.

---

## The Workflow

```mermaid
flowchart LR
    Ground[GROUND] --> Explore[EXPLORE] --> Decide[DECIDE] --> Stress[STRESS] --> Ship[SHIP]

    Stress -.->|Flawed| Explore
    Stress -.->|Gaps| Decide
```

### Phases

| Phase | Purpose | Exit Criteria |
|-------|---------|---------------|
| **GROUND** | Verify the problem exists and is worth solving | WHY, WHO, and WHAT-IF-NOTHING are clear |
| **EXPLORE** | Generate multiple approaches to avoid tunnel vision | 5+ directions explored |
| **DECIDE** | Select an approach and explicitly accept trade-offs | One path chosen, trade-offs acknowledged |
| **STRESS** | Actively try to break the plan before implementation | No unanswered "what if..." scenarios |
| **SHIP** | Output a verified design document | ADR + Plan saved to workspace |

Each phase can loop back if gaps are found during stress-testing.

### Quality Gates

GROUND has a **kill switch**: if stakes are vague ("it's not ideal", "nothing terrible happens"), Arete asks "The cost of inaction isn't clear. Dig deeper or park this?" This prevents wasting time on non-problems.

Throughout all phases, Arete watches for common anti-patterns:

| Anti-pattern | Challenge |
|--------------|-----------|
| "It's slow" | How slow? For whom? Under what load? |
| "Users want X" | Which users? Did you ask them? |
| "Design for scale" | What's the current scale? What's the target? |
| "Best practice says..." | Best practice for what context? |

---

## Two Tracks

Arete detects whether you're solving a **technical** or **conceptual** problem:

| Technical | Conceptual |
|-----------|------------|
| System design, architecture | Presentations, talks |
| Database choices, APIs | Blog posts, documentation |
| Scale, performance, reliability | Audience, narrative, persuasion |

**Technical example**: "Should I use Kafka or RabbitMQ for event processing?"
→ Questions about throughput, ordering guarantees, operational complexity

**Conceptual example**: "I need to explain our migration to executives"
→ Questions about audience fears, the one thing they must remember, resistance points

---

## Output

After completing a session, Arete produces cross-referenced documents in the `context/` directory:

### Technical Track:

- ADR (`context/exports/`): The decision record (Context, Decision, Consequences).
- Plan (`context/plans/`): The implementation details (Steps, Configuration, Error Handling).

### Conceptual Track:

- Outline (`context/exports/`): A structured outline for your presentation or writing.

### Teachings (Any Track):

- Teaching (`context/teachings/`): Deep-dive explanation of a concept, with diagrams. Generated via `/teach X`.

---

## Principles

- **No Solutioneering**: Validate the problem before writing code.
- **Precision over Speed**: "Make it scalable" is a wish. "Handle 10k RPS" is a constraint.
- **Logic before Infrastructure**: Define *why* and *what* before deciding *how* to deploy.

---

## Contributing

- **Found a bug or have an idea?** Open an issue on GitHub.

- **Want to add a domain?** Reference libraries live in `skills/*/reference/`. Add a new `.md` file with domain-specific questions and heuristics.

- **Want to improve a phase?** Each phase is a skill in `skills/`. The `SKILL.md` file defines behavior, exit criteria, and response style.

PRs are more than welcome! Keep changes focused.

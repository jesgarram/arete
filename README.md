# Arete

*ἀρετή — excellence earned through effort, not given.*

A structured brainstorming framework for Claude Code that argues back.

## The Problem

You ask. It answers. You ship. Then the system breaks at 3 AM and you realize you never understood why you chose a jumphost over Private Endpoints—you just accepted a suggestion.

Arete asks questions:

```
Arete: "Why a jumphost?"
You:   We need to access the database in the VNet.
Arete: "What are you protecting it from?"
You:   External access. It's got sensitive data.
Arete: "So you're exposing an SSH endpoint to reach your most protected resource?"
You:   It's only accessible from our IP range.
Arete: "Who manages the patching? The key rotation?"
You:   ...I didn't think about that.
```

That pause is the point.

## The Workflow

```mermaid
flowchart TB
    %% Styles - C4-ish Palette
    classDef person fill:#08427b,stroke:#052e56,color:white,rx:10,ry:10;
    classDef process fill:#23a2d9,stroke:#0e7db8,color:white,rx:5,ry:5;
    classDef agent fill:#1168bd,stroke:#0b4884,color:white,rx:5,ry:5;
    classDef data fill:#999999,stroke:#666666,color:white,rx:0,ry:0;
    classDef artifact fill:#438dd5,stroke:#2e6295,color:white,rx:0,ry:0,stroke-dasharray: 5 5;

    %% Nodes
    User(User):::person
    Problem[Problem Input]:::data

    subgraph Arete["Arete System"]
        direction TB
        
        subgraph Agents["Sub-Agents"]
            ResAgent[Researcher<br/><i>Web & Repo Search</i>]:::agent
            ArchAgent[Architect<br/><i>Diagram Generation</i>]:::agent
        end

        subgraph Phases["Brainstorming Pipeline"]
            direction LR
            Diverge[DIVERGE<br/><i>Explore</i>]:::process
            Converge[CONVERGE<br/><i>Decide</i>]:::process
            Refine[REFINE<br/><i>Polish</i>]:::process
            Export[EXPORT<br/><i>Save</i>]:::process
            
            Diverge --> Converge --> Refine --> Export
        end
        
        Domains[(Domain<br/>Knowledge)]:::data
    end

    subgraph Artifacts["Output Artifacts"]
        direction TB
        subgraph Tech["Technical Track"]
            ADR[ADR<br/><i>exports/</i>]:::artifact
            Plan[Implementation Plan<br/><i>plans/</i>]:::artifact
        end
        subgraph Conc["Conceptual Track"]
            Outline[Outline<br/><i>exports/</i>]:::artifact
        end
    end

    %% Connections
    User --> Problem --> Diverge
    
    %% Knowledge injection
    Domains -.-> Diverge
    Domains -.-> Refine

    %% Agent Interactions
    Phases <-->|Trigger| ResAgent
    Export -->|Trigger| ArchAgent
    ArchAgent -.->|Injects Diagrams| ADR

    %% Export Logic
    Export --> Tech
    Export --> Conc
```

## Getting Started

```bash
/plugin marketplace add jesgarram/arete
/plugin install arete@jesgarram/arete
```

Start a session:

```bash
/arete:brainstorm "Secure access to a production database in a private VNet"
```

## Output

Arete generates artifacts based on the session track.

**Technical Track**:
- **ADR** (`context/exports/`): The decision record (Context, Decision, Consequences).
- **Plan** (`context/plans/`): The implementation details (Steps, Configuration, Error Handling).

**Conceptual Track**:
- **Outline** (`context/exports/`): A structured outline for your presentation or writing.

Example ADR:
```yaml
---
problem: "Secure access to production database in private VNet"
decision: "Private Endpoints with AAD authentication, no jumphost"
date: 2025-01-11
plan: "secure-access-plan-2025-01-11.md"
---
```

Six months later, search your ADRs. Find every decision about network access patterns. New engineers read *why* things work the way they do.

When you discuss component interactions, Mermaid diagrams generate inline:

```mermaid
flowchart LR
    A[Developer] --> B[AAD Auth]
    B --> C[Private Endpoint]
    C --> D[Azure SQL]
```

## Domains

Arete loads questions matched to your problem.

**Technical** — distributed systems, storage patterns, data models, batch/stream processing, partitioning

**Conceptual** — presentations, technical writing, talks, teaching

Add your own in `skills/diverge/reference/`:

```markdown
# Your Domain

## Key Concepts
The fundamental trade-off in this domain.

## Questions
- Question that reveals hidden assumptions
- Question about failure modes
- Question about scale implications
```

## Why It Works

**[System 1 and System 2](https://en.wikipedia.org/wiki/Thinking,_Fast_and_Slow)**: Fast and slow thinking. Vibe coding traps you in System 1: no friction, just pattern-matching. Spec-driven tools trap you in System 2: ten pages of requirements, zero momentum. You need both. DIVERGE/CONVERGE/REFINE forces the switch.

**[Flow](https://en.wikipedia.org/wiki/Flow_(psychology))**: Challenge slightly exceeds skill. Too easy, you drift. Too hard, you quit. The questions calibrate difficulty.

**[Zone of Proximal Development](https://en.wikipedia.org/wiki/Zone_of_proximal_development)**: The band just past what you can do alone. Close enough to reach, far enough to stretch. Teachers know it. Coaches know it. Most AI tools ignore it. Arete doesn't agree with you—it asks the next question.

## Contributing

1. Fork the repo
2. Create a branch (`git checkout -b my-domain`)
3. Add your changes
4. Open a PR

New domains sharpen the challenge. The more specific the questions, the harder it is to coast.

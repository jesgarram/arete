---
name: research
description: Spawn a research agent to explore the codebase or web. Returns structured findings with sources. Use for gathering context, validating approaches, or finding prior art.
---

# Research

Route research requests to the **researcher** subagent.

## Flow

1. **Detect mode** from user's request
2. **Spawn researcher** subagent with mode + question + context
3. **Present findings** returned by researcher

## Mode Detection

| Signal | Mode |
|--------|------|
| "in this codebase", "how we do", "our implementation", file paths | repository |
| "best practice", "how others", "industry standard", "latest" | web |
| Ambiguous | Ask user |

## Invocation

Spawn researcher subagent:

```
Mode: [repository | web]
Question: [user's question, refined if vague]
Context: [what user is trying to accomplish]
```

## Parallel Research

For comparative questions ("compare X vs industry"), spawn two researchers in parallel:
1. `repository` mode for internal patterns
2. `web` mode for external patterns

Synthesize both results.

## After Findings

Present researcher's output, then offer:
- "Dig deeper into [specific finding]?"
- "Search [other mode] for more?"
- "Use these findings for [next step]?"

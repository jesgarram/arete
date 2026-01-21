# Teaching Template

The structured format for concept explanations. All sections are required.

## Template

```markdown
---
concept: "{concept name}"
date: YYYY-MM-DD
context: "{one-line brainstorm context}"
---

# {Concept Name}

## What It Is

[1-2 paragraphs defining the concept. Be precise, not academic. Use concrete examples.]

## Why It Matters

[Connect to the current brainstorm. Why should the user care about this concept RIGHT NOW? Reference the specific problem or decision being discussed.]

## How It Works

[The mechanics. Break down into steps, components, or layers as appropriate.]

[Mermaid diagram if component interactions exist]

[Code snippet if implementation pattern helps]

## Trade-offs

**When to use:**
- [Scenario 1]
- [Scenario 2]

**When to avoid:**
- [Scenario 1]
- [Scenario 2]

**Common pitfalls:**
- [Pitfall 1]
- [Pitfall 2]

## Further Reading

- [Authoritative source 1](URL)
- [Practical guide 2](URL)
- [Deep dive 3](URL)
```

## Section Guidelines

### What It Is
- Define, don't describe feelings about it
- One concrete example that makes it click
- No jargon without immediate explanation

### Why It Matters
- Reference the brainstorm context explicitly
- Connect to the decision at hand
- Make it personal: "In your case..." or "For the problem you're solving..."

### How It Works
- Prioritize mechanisms over history
- Diagrams for anything with components or flow
- Code only if it clarifies, not to show completeness

### Trade-offs
- Balanced: genuine pros AND cons
- Specific scenarios, not vague "it depends"
- Include common mistakes people make

### Further Reading
- Max 3 links
- Prefer official docs, seminal blog posts, or authoritative books
- No paywalls if possible

## Naming Convention

- File: `{YYYY-MM-DD}-{concept-slug}.md`
- Location: `context/teachings/`
- Slug: lowercase, hyphens, no special characters (e.g., `domain-driven-design`, `event-sourcing`)

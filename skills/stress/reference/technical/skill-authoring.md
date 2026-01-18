# Skill Authoring

## Key Concepts

Refinement focuses on structural integrity and execution safety. Platform compatibility (forward-slash paths), token efficiency (remove what Claude knows), and flat references (one level deep). MCP tools need fully qualified names. Destructive actions need plan-then-execute validation.

## Refinement Questions

- Does the name use gerund form (verb-ing) like `analyzing-data` instead of generic nouns?
- Have you removed explanations of basic concepts Claude already knows? Token budget is precious
- Are all file paths using forward slashes (/) for cross-platform compatibility?
- Are reference links flattened to one level deep from SKILL.md?
- Are external dependencies and installation commands explicitly listed?
- Are all constants and "magic numbers" explained or justified?
- Do scripts handle errors gracefully with clear messages instead of raw stack traces?
- Do MCP tool references use fully qualified names (Server:tool) to avoid ambiguity?
- Is there a strict output template defined for reports or structured data?
- Is there a "plan-then-execute" validation step for destructive actions?

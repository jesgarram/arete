## Skill Authoring
## Key Concepts
Designing agent tools requires managing the context window as a public good. Skills must balance "degrees of freedom" based on task fragility—using strict scripts for fragile tasks ("narrow bridge") and heuristics for open-ended tasks ("open field"). Progressive disclosure architecture keeps token usage low by splitting documentation into reference files loaded on-demand. Naming and descriptions are critical for discovery by the orchestration model.

## Questions
- What specific friction does this skill solve that base Claude cannot already handle well? 
- Is this a "narrow bridge" scenario requiring exact execution, or an "open field" relying on heuristics? 
- What keywords or specific file types must appear to trigger this skill over others?
- Does the domain require extensive documentation that should be split into separate reference files? 
- Is the workflow complex enough to require a "Checklist" that the agent copies and checks off? 
- Can deterministic logic (math, parsing) be offloaded to a utility script instead of LLM generation? 
- What is the specific "validator" step (script or manual check) that confirms the task is done correctly? 
- Does the final output need to adhere to a strict template (JSON, report format) or is it flexible? 
- What are the common failure modes (missing files, API errors) and what is the recovery path?
- What specific input-to-output scenario defines a "passing grade" for this skill's evaluation?
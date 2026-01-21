# Arete for GitHub Copilot

Install Arete skills and agents for GitHub Copilot.

## Quick Install

```bash
# Clone the repository
git clone https://github.com/jesgarram/arete-plugin.git ~/.copilot/arete

# Symlink skills
ln -s ~/.copilot/arete/skills ~/.copilot/skills

# Generate agents (optional - enables architect, researcher, teacher)
~/.copilot/arete/scripts/generate-agents.sh \
  --platform copilot \
  --output ~/.copilot/agents
```

## Per-Project Install

For project-specific installation:

```bash
# In your project root
mkdir -p .github/skills
cp -r /path/to/arete-plugin/skills/* .github/skills/

# Generate agents for the project
/path/to/arete-plugin/scripts/generate-agents.sh \
  --platform copilot \
  --output .github/agents
```

## Usage

### Skills

```
/brainstorm "your problem here"
/ground
/explore
/decide
/stress
/ship
```

### Agents

Agents are available during brainstorm sessions:
- `architect` - Generate mermaid diagrams from descriptions
- `researcher` - Research codebase or web for context
- `teacher` - Generate concept explanations to context/teachings/

## Limitations

Compared to Claude Code:
- **No automatic phase orchestration** - invoke each phase skill manually
- **No automatic subagent spawning** - agents must be invoked explicitly
- **Model routing ignored** - uses your configured default model

## About Agent Generation

Agents are generated at install time using:

```bash
./scripts/generate-agents.sh --platform copilot --output <dir>
```

This converts Claude Code agent format to Copilot format (using `name` and `description` frontmatter, `.agent.md` extension). If you update the plugin, re-run the generation script to get the latest agents.

# Arete for OpenCode

Install Arete skills and agents for OpenCode.

## Quick Install

```bash
# Clone the repository
git clone https://github.com/jesgarram/arete-plugin.git ~/.config/opencode/arete

# Symlink skills (Agent Skills spec)
ln -s ~/.config/opencode/arete/skills ~/.config/opencode/skills

# Generate agents (optional - enables architect, researcher, teacher)
~/.config/opencode/arete/scripts/generate-agents.sh \
  --platform opencode \
  --output ~/.config/opencode/agents
```

## Manual Install

If you prefer to copy instead of symlink:

```bash
# Skills
mkdir -p ~/.config/opencode/skills
cp -r /path/to/arete-plugin/skills/* ~/.config/opencode/skills/

# Agents (generate to your preferred location)
/path/to/arete-plugin/scripts/generate-agents.sh \
  --platform opencode \
  --output ~/.config/opencode/agents
```

## Per-Project Install

For project-specific installation:

```bash
# In your project root
mkdir -p .opencode/skills
cp -r /path/to/arete-plugin/skills/* .opencode/skills/

# Generate agents for the project
/path/to/arete-plugin/scripts/generate-agents.sh \
  --platform opencode \
  --output .opencode/agents
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

Agents are available as subagents during brainstorm sessions:
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
./scripts/generate-agents.sh --platform opencode --output <dir>
```

This converts Claude Code agent format to OpenCode format (adding `mode: subagent`). If you update the plugin, re-run the generation script to get the latest agents.

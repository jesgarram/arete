# Arete for Codex

Install Arete skills for OpenAI Codex.

## Quick Install

```bash
# Clone the repository
git clone https://github.com/jesgarram/arete-plugin.git ~/.codex/arete

# Symlink skills
ln -s ~/.codex/arete/skills ~/.codex/skills
```

## Per-Project Install

For project-specific installation:

```bash
# In your project root
mkdir -p .codex/skills
cp -r /path/to/arete-plugin/skills/* .codex/skills/
```

## Usage

```
/brainstorm "your problem here"
/ground
/explore
/decide
/stress
/ship
```

## Note on Agents

Codex uses [AGENTS.md](https://developers.openai.com/codex/guides/agents-md) for project guidance rather than separate agent files. The Arete subagents (architect, researcher, teacher) are not available in Codex. Only skills are supported.

## Limitations

Compared to Claude Code:
- **No automatic phase orchestration** - invoke each phase skill manually
- **No subagent support** - architect, researcher, teacher agents unavailable
- **Model routing ignored** - uses your configured default model

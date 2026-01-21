#!/bin/bash
#
# Generate platform-specific agent files from canonical agents/
#
# Usage:
#   ./scripts/generate-agents.sh --platform <opencode|copilot> --output <dir>
#
# Examples:
#   ./scripts/generate-agents.sh --platform opencode --output ~/.config/opencode/agents
#   ./scripts/generate-agents.sh --platform copilot --output ~/.copilot/agents
#
# Reads from: agents/*.md (Claude Code format)
# Generates platform-specific agents based on --platform flag

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
AGENTS_DIR="$ROOT_DIR/agents"

usage() {
    cat << EOF
Usage: $(basename "$0") --platform <opencode|copilot> --output <dir>

Generate platform-specific agent files from canonical agents/

Options:
  --platform <platform>   Target platform: opencode or copilot
  --output <dir>          Output directory for generated agents

Examples:
  $(basename "$0") --platform opencode --output ~/.config/opencode/agents
  $(basename "$0") --platform copilot --output ~/.copilot/agents

Note: Codex uses AGENTS.md for project guidance and does not support
separate agent files. Only skills are compatible with Codex.
EOF
    exit 1
}

# Parse arguments
PLATFORM=""
OUTPUT_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --platform)
            PLATFORM="$2"
            shift 2
            ;;
        --output)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
done

# Validate arguments
if [[ -z "$PLATFORM" ]] || [[ -z "$OUTPUT_DIR" ]]; then
    echo "Error: --platform and --output are required"
    echo ""
    usage
fi

if [[ "$PLATFORM" != "opencode" ]] && [[ "$PLATFORM" != "copilot" ]]; then
    echo "Error: platform must be 'opencode' or 'copilot'"
    echo ""
    usage
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Generating agents for $PLATFORM..."
echo "Output: $OUTPUT_DIR"
echo ""

# Process each agent file (skip references/ subdirectory)
for agent_file in "$AGENTS_DIR"/*.md; do
    [ -f "$agent_file" ] || continue

    filename=$(basename "$agent_file")
    name="${filename%.md}"

    echo "Processing: $name"

    # Extract frontmatter and body
    in_frontmatter=false
    frontmatter_done=false
    description=""
    body=""

    while IFS= read -r line || [[ -n "$line" ]]; do
        if [[ "$line" == "---" ]] && [[ "$frontmatter_done" == false ]]; then
            if [[ "$in_frontmatter" == false ]]; then
                in_frontmatter=true
                continue
            else
                in_frontmatter=false
                frontmatter_done=true
                continue
            fi
        fi

        if [[ "$in_frontmatter" == true ]]; then
            # Extract description from frontmatter
            if [[ "$line" =~ ^description:\ *(.*) ]]; then
                description="${BASH_REMATCH[1]}"
            fi
        elif [[ "$frontmatter_done" == true ]]; then
            body+="$line"$'\n'
        fi
    done < "$agent_file"

    # Remove leading newline from body
    body="${body#$'\n'}"

    # Generate platform-specific version
    if [[ "$PLATFORM" == "opencode" ]]; then
        cat > "$OUTPUT_DIR/$filename" << EOF
---
description: $description
mode: subagent
---
$body
EOF
        echo "  -> $OUTPUT_DIR/$filename"

    elif [[ "$PLATFORM" == "copilot" ]]; then
        cat > "$OUTPUT_DIR/${name}.agent.md" << EOF
---
name: $name
description: $description
---
$body
EOF
        echo "  -> $OUTPUT_DIR/${name}.agent.md"
    fi

done

echo ""
echo "Done! Generated $PLATFORM agents in $OUTPUT_DIR"

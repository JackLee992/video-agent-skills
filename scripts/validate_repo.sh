#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

bash -n "$ROOT_DIR/install.sh"

if [[ -d "$ROOT_DIR/skills/storyboard-lite" ]]; then
  echo "Legacy skills/storyboard-lite directory should not exist" >&2
  exit 1
fi

found=0
for skill_source in "$ROOT_DIR"/skills/*; do
  [[ -d "$skill_source" ]] || continue
  found=1

  skill_name="$(basename "$skill_source")"
  skill_file="$skill_source/SKILL.md"
  agent_file="$skill_source/agents/openai.yaml"

  [[ -f "$skill_file" ]] || { echo "Missing $skill_file" >&2; exit 1; }
  [[ -f "$agent_file" ]] || { echo "Missing $agent_file" >&2; exit 1; }

  declared_name="$(sed -n 's/^name: //p' "$skill_file" | head -1)"
  if [[ "$declared_name" != "$skill_name" ]]; then
    echo "Skill name mismatch: folder=$skill_name declared=$declared_name" >&2
    exit 1
  fi

  if ! grep -q "allow_implicit_invocation: false" "$agent_file"; then
    echo "Expected allow_implicit_invocation: false in $agent_file" >&2
    exit 1
  fi
done

if [[ "$found" -ne 1 ]]; then
  echo "No skills found" >&2
  exit 1
fi

echo "Repository validation passed"

#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d "$ROOT_DIR/skills" ]]; then
  echo "Missing skills directory: $ROOT_DIR/skills" >&2
  exit 1
fi

install_link() {
  local target_dir="$1"
  local skill_name="$2"
  local skill_source="$3"
  local link_path="$target_dir/$skill_name"

  mkdir -p "$target_dir"

  if [[ -L "$link_path" ]]; then
    rm "$link_path"
  elif [[ -e "$link_path" ]]; then
    echo "Skip existing non-symlink: $link_path" >&2
    return
  fi

  ln -s "$skill_source" "$link_path"
  echo "Installed $link_path -> $skill_source"
}

for skill_source in "$ROOT_DIR"/skills/*; do
  [[ -d "$skill_source" ]] || continue

  skill_name="$(basename "$skill_source")"

  if [[ ! -f "$skill_source/SKILL.md" ]]; then
    echo "Skip missing SKILL.md: $skill_source" >&2
    continue
  fi

  install_link "$HOME/.codex/skills" "$skill_name" "$skill_source"
  install_link "$HOME/.claude/skills" "$skill_name" "$skill_source"
  install_link "$HOME/.openclaw/skills" "$skill_name" "$skill_source"
  install_link "$HOME/.agents/skills" "$skill_name" "$skill_source"
done

echo "Done."

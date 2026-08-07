#!/usr/bin/env bash
set -euo pipefail

upstream_repository="${UPSTREAM_REPOSITORY:-https://github.com/hardikpandya/stop-slop.git}"
upstream_ref="${UPSTREAM_REF:-main}"
plugin_root="${PLUGIN_ROOT:-plugins/stop-slop}"
work_dir="$(mktemp -d)"

cleanup() {
  rm -rf "$work_dir"
}
trap cleanup EXIT

git clone --quiet --depth 1 --branch "$upstream_ref" "$upstream_repository" "$work_dir/upstream"
upstream_sha="$(git -C "$work_dir/upstream" rev-parse HEAD)"

install -D -m 0644 "$work_dir/upstream/SKILL.md" "$plugin_root/skills/stop-slop/SKILL.md"
mkdir -p "$plugin_root/skills/stop-slop/references"
rsync -a --delete "$work_dir/upstream/references/" "$plugin_root/skills/stop-slop/references/"
install -D -m 0644 "$work_dir/upstream/LICENSE" "$plugin_root/LICENSE"

if [[ -z "$(git status --porcelain -- "$plugin_root/skills/stop-slop" "$plugin_root/LICENSE")" ]]; then
  echo "No upstream skill changes found at $upstream_sha."
  exit 0
fi

printf '%s\n' "$upstream_sha" > "$plugin_root/UPSTREAM_COMMIT"

node - "$plugin_root/.codex-plugin/plugin.json" <<'NODE'
const fs = require("node:fs");

const manifestPath = process.argv[2];
const manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8"));
const match = /^(\d+)\.(\d+)\.(\d+)$/.exec(manifest.version);

if (!match) {
  throw new Error(`Expected a semantic version, got ${manifest.version}`);
}

manifest.version = `${match[1]}.${match[2]}.${Number(match[3]) + 1}`;
fs.writeFileSync(manifestPath, `${JSON.stringify(manifest, null, 2)}\n`);
NODE

echo "Synced Stop Slop at $upstream_sha."

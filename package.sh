#!/usr/bin/env bash
# Build the ZIP to upload at platform.openai.com -> Plugins (With MCP) from plugins/kudos.
# Refuses while any TODO is left in the plugin files.
set -euo pipefail
cd "$(dirname "$0")"
src=plugins/kudos
if grep -rn 'TODO' "$src" --include='*.json' --include='*.md'; then
    echo "package.sh: fill in the TODOs above first" >&2
    exit 1
fi
for f in "$src"/plugin.json "$src"/mcp.json; do python3 -m json.tool "$f" >/dev/null; done
version=$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' "$src/plugin.json")
out="$PWD/dist/kudos-plugin-$version.zip"
mkdir -p dist && rm -f "$out"
(cd "$src" && zip -qr -X "$out" . -x '.*' -x '*/.*')
unzip -l "$out"
echo "wrote $out"

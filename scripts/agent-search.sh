#!/bin/bash
# Agent Intel — AI Agent 情报搜索工具
# Usage: bash agent-search.sh "<query>" [max_results] [language] [tag]
#
# Examples:
#   bash agent-search.sh "AI Agent latest news"
#   bash agent-search.sh "AI Agent" 15
#   bash agent-search.sh "AI Agent" 10 zh-CN
#   bash agent-search.sh "AI Agent" 10 en code.doc

set -euo pipefail

# Config
ANYSEARCH_API_KEY="${ANYSEARCH_API_KEY:-}"
API_BASE="https://api.anysearch.com/v1/search"

# Args
QUERY="${1:?"Usage: $0 <query> [max_results] [language] [tag]"}"
MAX_RESULTS="${2:-10}"
LANGUAGE="${3:-en}"
TAG="${4:-general.general}"

# Validate max_results
if [[ ! "$MAX_RESULTS" =~ ^[0-9]+$ ]] || [ "$MAX_RESULTS" -lt 1 ] || [ "$MAX_RESULTS" -gt 20 ]; then
  echo "Error: max_results must be an integer between 1 and 20" >&2
  exit 1
fi

# Build JSON payload
if command -v jq &>/dev/null; then
  JSON_PAYLOAD=$(jq -n \
    --arg q "$QUERY" \
    --arg tag "$TAG" \
    --arg lang "$LANGUAGE" \
    --argjson max "$MAX_RESULTS" \
    '{query: $q, tag: $tag, max_results: $max, language: $lang}')
else
  JSON_PAYLOAD=$(python3 -c "
import json, sys
payload = {
    'query': sys.argv[1],
    'tag': sys.argv[2],
    'max_results': int(sys.argv[3]),
    'language': sys.argv[4]
}
print(json.dumps(payload))
" "$QUERY" "$TAG" "$MAX_RESULTS" "$LANGUAGE")
fi

# Headers
AUTH_ARGS=()
if [ -n "$ANYSEARCH_API_KEY" ]; then
  AUTH_ARGS=(-H "Authorization: Bearer $ANYSEARCH_API_KEY")
fi

# Execute
echo "🔍 Agent Intel — Searching: $QUERY" >&2
echo "   Tag: $TAG | Max: $MAX_RESULTS | Lang: $LANGUAGE" >&2
echo "---" >&2

curl -s -X POST "$API_BASE" \
  -H "Content-Type: application/json" \
  "${AUTH_ARGS[@]}" \
  -d "$JSON_PAYLOAD" | python3 -c "
import sys, json

try:
    data = json.load(sys.stdin)
except json.JSONDecodeError as e:
    print(f'Error: Invalid JSON response: {e}', file=sys.stderr)
    sys.exit(1)

code = data.get('code', -1)
if code != 0:
    msg = data.get('message', 'Unknown error')
    print(f'Error [{code}]: {msg}', file=sys.stderr)
    sys.exit(1)

results = data.get('data', {}).get('results', [])
metadata = data.get('data', {}).get('metadata', {})
total = metadata.get('total_results', 0)
time_ms = metadata.get('search_time_ms', 0)

print(f'📊 Results: {total} (took {time_ms}ms)')
print()

for i, r in enumerate(results, 1):
    title = r.get('title', 'N/A')
    url = r.get('url', '')
    snippet = r.get('snippet', '')
    print(f'{i}. {title}')
    print(f'   {url}')
    if snippet:
        print(f'   {snippet}')
    print()

# Output JSON for programmatic use
print('---JSON_OUTPUT---')
print(json.dumps(data, ensure_ascii=False, indent=2))
"

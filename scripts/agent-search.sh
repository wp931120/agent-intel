#!/bin/bash
# Agent Intel — AI 知识搜索工具
# Usage: bash agent-search.sh "<query>" [max_results] [language] [tag] [mode]
#
# Modes:
#   normal   — 格式化展示（默认）
#   json     — 仅输出原始 JSON（供 Agent 程序化处理）
#
# Examples:
#   bash agent-search.sh "RAG 知识库构建" 10 zh-CN
#   bash agent-search.sh "multi-agent system" 15 en general.general json

set -euo pipefail

# Config
ANYSEARCH_API_KEY="${ANYSEARCH_API_KEY:-}"
API_BASE="https://api.anysearch.com/v1/search"

# Args
QUERY="${1:?"Usage: $0 <query> [max_results] [language] [tag] [mode]"}"
MAX_RESULTS="${2:-10}"
LANGUAGE="${3:-en}"
TAG="${4:-general.general}"
MODE="${5:-normal}"

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
if [ "$MODE" = "json" ]; then
  # JSON mode: output raw response to stdout, progress to stderr
  echo "🔍 Agent Intel — Searching: $QUERY" >&2
  echo "   Tag: $TAG | Max: $MAX_RESULTS | Lang: $LANGUAGE | Mode: json" >&2

  curl -s -X POST "$API_BASE" \
    -H "Content-Type: application/json" \
    "${AUTH_ARGS[@]}" \
    -d "$JSON_PAYLOAD"
else
  # Normal mode: formatted output
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

# Output JSON appended with separator
print('---JSON_OUTPUT---')
print(json.dumps(data, ensure_ascii=False, indent=2))
"
fi

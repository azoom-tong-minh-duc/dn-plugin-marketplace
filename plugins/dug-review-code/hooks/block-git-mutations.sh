#!/usr/bin/env bash
python3 -c '
import json, re, sys

data = json.load(sys.stdin)
if data.get("tool_name") != "Bash":
    sys.exit(0)

command = data.get("tool_input", {}).get("command", "")
blocked = re.compile(r"\bgit\s+(commit|push|merge|rebase|reset\s+--hard|tag)\b|\bgh\s+pr\s+(merge|create)\b", re.I)

if blocked.search(command):
    print(f"dug-review-code: this plugin only reviews and comments, it must not perform actions like commit/push/merge. Blocked command: {command}", file=sys.stderr)
    sys.exit(2)

sys.exit(0)
'

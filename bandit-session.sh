#!/bin/bash

REPO="$HOME/otw"
DATE=$(date +%F)

mkdir -p "$REPO/bandit"

LOGFILE="$REPO/bandit/$DATE.log"
HISTFILE="$REPO/bandit/$DATE.history"

echo "Bandit session started."
echo "Logging terminal to:"
echo "$LOGFILE"

# Start a fresh log for this session
rm -f "$LOGFILE"

# Record an interactive shell
script -qf -c "bash -i" "$LOGFILE"

# Extract only commands typed at bandit prompts
grep -a 'bandit[0-9].*\$ ' "$LOGFILE" |
sed 's/.*\$ //' > "$HISTFILE"

rm -f "$LOGFILE"

echo "Extracted commands to:"
echo "$HISTFILE"

cd "$REPO" || exit 1

git add bandit

if ! git diff --cached --quiet; then
    git commit -m "Bandit session $DATE"
    git push
fi

echo "Session saved and pushed."
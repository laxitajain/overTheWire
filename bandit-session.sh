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
perl -pe 's/\e\[[0-9;?]*[ -\/]*[@-~]//g' "$LOGFILE" |
col -b |
tr -d '\r' |
grep -aE 'bandit[0-9]+@.*\$ ' |
sed 's/.*\$ //' |
grep -v '^$' > "$HISTFILE"

# Remove temporary log
rm -f "$LOGFILE"

echo "Extracted commands to:"
echo "$HISTFILE"

cd "$REPO" || exit 1

git add bandit

if ! git diff --cached --quiet; then
    git commit -m "Bandit session $DATE"
fi

echo "Session saved, you can push."
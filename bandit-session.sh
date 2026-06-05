#!/bin/bash

REPO=~/overTheWire
LOG="$REPO/bandit/$(date +%F-%H%M).log"

mkdir -p "$REPO/bandit"

script "$LOG"

cd "$REPO" || exit

git add bandit
git commit -m "Bandit session $(date '+%F %H:%M')" || true
git push

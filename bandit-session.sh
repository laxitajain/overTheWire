#!/bin/bash

REPO=~/overTheWire
DATE=$(date +%F)

mkdir -p "$REPO/bandit"

export HISTFILE="$REPO/bandit/$DATE.history"
export HISTSIZE=100000
export HISTFILESIZE=100000

history -c
history -w

echo "Bandit session started."
echo "Commands will be saved to:"
echo "$HISTFILE"

bash
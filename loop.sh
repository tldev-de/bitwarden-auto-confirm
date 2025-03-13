#!/bin/sh

# exit script if a command fails
set -e

while true; do
    ./auto-confirm.sh
    sleep "$SYNC_INTERVAL"
done
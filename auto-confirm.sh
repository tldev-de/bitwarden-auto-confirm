#!/bin/bash

# idea and part of the script from https://github.com/dani-garcia/vaultwarden/discussions/3954
# thx to @etfz

# exit script if a command fails
set -e

# check if all necessary environment variables are set
if [ -z "$BW_CLIENTID" ] || [ -z "$BW_CLIENTSECRET" ] || [ -z "$BW_SERVER" ] || [ -z "$BW_PASSWORD" ]; then
    echo "Please set the environment variables BW_CLIENTID, BW_CLIENTSECRET, BW_PASSWORD, and BW_SERVER."
    exit 1
fi

if ! bw login --check; then
  bw config server "$BW_SERVER"
  bw login --raw --apikey
fi

SESSION_KEY="$(bw unlock --raw --passwordenv BW_PASSWORD)"

ORGANIZATION_IDS=$(bw --session "$SESSION_KEY" list organizations | jq -r '.[].id')

for ORGANIZATION_ID in $ORGANIZATION_IDS; do
    MEMBERS=$(bw --session "$SESSION_KEY" list org-members --organizationid "$ORGANIZATION_ID" | jq -r '.[] | select(.status == 1) | .id')
    for MEMBER_ID in $MEMBERS; do
        echo "Confirming member $MEMBER_ID..."
        bw confirm --session "$SESSION_KEY" --organizationid "$ORGANIZATION_ID" org-member "$MEMBER_ID"
    done
done
echo " All members confirmed. Will run again in $SYNC_INTERVAL seconds."
#!/bin/bash

## Input your configuration here
DIGITALOCEAN_TOKEN=
VOLUME_ID=
SNAPSHOT_NAME=

DATE=`date '+%Y%m%d-%H%M%S'`

curl -X POST \
  "https://api.digitalocean.com/v2/volumes/$VOLUME_ID/snapshots" \
  -H "authorization: Bearer $DIGITALOCEAN_TOKEN" \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d "{
  \"name\": \"$SNAPSHOT_NAME-$DATE\"
}"

## Currently, it will keep 2 newest snapshots. If you want to config this, change [2:] to other value. E.g. [1:] for keep only the newest snapshot.
OLD_SNAPSHOTS=$(curl https://api.digitalocean.com/v2/snapshots?resource_type=volume -H "authorization: Bearer $DIGITALOCEAN_TOKEN" -H 'cache-control: no-cache' -H 'content-type: application/json' | jq ".snapshots[2:][] | .id" | sed "s/\"//g")

for SNAPSHOT_ID in $OLD_SNAPSHOTS
do
    curl -X DELETE -H 'Content-Type: application/json' -H 'Authorization: Bearer $DIGITALOCEAN_TOKEN' "https://api.digitalocean.com/v2/snapshots/$SNAPSHOT_ID"
done
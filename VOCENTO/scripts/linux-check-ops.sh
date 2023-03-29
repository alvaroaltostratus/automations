#!/bin/bash

if [ $# -ne 3 ] && [ $# -ne 2 ]; then
    echo "$0 <project> <zone>[<zone>,...] [<instance>,...]"
    exit 1
fi

if [ $# -eq 2 ]; then
    instances=`gcloud compute instances list --project="$1" --zones="$2" --format="value(name)" | tr '\n' ','`
else
    instances=$3
fi

IFS=','

for value in $instances; do
    service=`gcloud compute ssh --quiet --project="$1" --zone="$2" $value -- "sudo systemctl is-active google-cloud-ops-agent.service" 2> /dev/null`

    echo -n "$value="
    if [ -z $service ]; then echo "inactive"; else echo "active"; fi
done

unset IFS
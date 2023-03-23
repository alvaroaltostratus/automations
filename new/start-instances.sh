#! /bin/bash

if [ $# -lt 2 ]; then
    echo "$0 <project> <zone> [<instances> ... ]"
    exit 1
fi

project=$1
zone=$2

if [ $# -ge 3 ]; then
    shift 2
    instances=$@
else
    instances=`gcloud compute instances list --project="$project" --zones="$zone" --format="value(name)" | tr '\n' ' '`
fi

gcloud compute instances start --project="$project" --zone="$zone" $instances
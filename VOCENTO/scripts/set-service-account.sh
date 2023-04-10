#! /bin/bash

if [ $# -lt 2 ]; then
    echo "$0 <project> <zone> <serviceaccount> [<instances> ... ]"
    exit 1
fi

project=$1
zone=$2
sa=$3

if [ $# -ge 4 ]; then
    shift 3
    instances=$@
else
    instances=`gcloud compute instances list --project="$project" --zones="$zone" --format="value(name)" | tr '\n' ' '`
fi

IFS=" "

for value in $instances;do
gcloud compute instances set-service-account $value --project="$project" --zone="$zone" --scopes=default --service-account=$sa
done

unset IFS
#! /bin/bash

if [ $# -lt 4 ]; then
    echo "$0 <project> <zone> <script path> <linux/windows> [<instances> ... ]"
    exit 1
fi

project=$1
zone=$2
script=$3

if [ $4 == "linux" ]; then
    type="startup-script"
else
    type="windows-startup-script-ps1"
fi

if [ $# -ge 5 ]; then
    shift 4
    instances=$@
else
    instances=`gcloud compute instances list --project="$project" --zones="$zone" --format="value(name)" | tr '\n' ' '`
fi

for instance in $instances; do
    gcloud compute instances add-metadata --project="$project" --zone="$zone" $instance --metadata-from-file $type="$script"
done
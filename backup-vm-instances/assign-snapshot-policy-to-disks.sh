#! /bin/bash

if [ $# -ne 3 ]; then
    echo "Usage: $0 <project> <zone> <policy>"
    exit 1
fi

disks=`gcloud compute disks list --project="$1" --zones="$2" --format="value(name)" | tr '\n' ','`

IFS=','

for disk in $disks; do
    gcloud compute disks add-resource-policies "$disk" --resource-policies="$3" --project="$1" --zone="$2"
done

unset IFS

#! /bin/bash

# ./reset-password.sh <project> <zone> <user>

if [ $# -lt 2 ]; then
    echo "$0 <project> <zone> <user>"
    exit 1
fi

instances=`gcloud compute instances list --project="$1" --zones="$2" --format="value(name)" | tr '\n' ',' | sed 's/.$//'`

IFS=','
for instance in $instances; do
    gcloud compute reset-windows-password $instance --project="$1" --zone="$2" --user="$3" --quiet > password
    echo "-----"
    echo "maquina:" $instance
    cat password | grep "password" | awk '{split($0, tmp, " "); print tmp[2]}' | tr -d '\n' | cat
    rm password
    echo "\n-----"
done
unset IFS
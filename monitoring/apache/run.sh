if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
        echo "Usage: ./run.sh <project> <zone> <instance>"
        exit 1
fi

LOCAL_SCRIPT="./agent-configuration.sh"
REMOTE_SCRIPT="/tmp/script.sh"

chmod +x "${LOCAL_SCRIPT}"

gcloud compute scp --project=$1 --zone=$2 "${LOCAL_SCRIPT}" "$3:${REMOTE_SCRIPT}"

gcloud compute ssh --project=$1 --zone=$2 $3 -- "${REMOTE_SCRIPT}"
#! /bin/bash

# Instalar OPS-AGENT
curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Instalar OS-CONFIGAGENT
sudo apt update
sudo apt -y install google-osconfig-agent

# Instalar antivirus
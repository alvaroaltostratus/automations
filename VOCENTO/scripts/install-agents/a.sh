Copy-Item -Path 'C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml' -Destination 'C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml.bak'

  Add-Content 'C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml' "
  metrics:
    receivers:
      iis_v2:
        type: iis
        receiver_version: 2
    service:
      pipelines:
        iispipeline:
          receivers:
            - iis_v2
  logging:
    receivers:
      iis_access:
        type: iis_access
    service:
      pipelines:
        iis:
          receivers:
          - iis_access
  "


# Instalar antivirus


# Configurar Apache2
set -e

# Create a back up of the existing file so existing configurations are not lost.
sudo cp /etc/google-cloud-ops-agent/config.yaml /etc/google-cloud-ops-agent/config.yaml.bak

# Configure the Ops Agent.
sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    apache:
      type: apache
  service:
    pipelines:
      apache:
        receivers:
          - apache
logging:
  receivers:
    apache_access:
      type: apache_access
    apache_error:
      type: apache_error
  service:
    pipelines:
      apache:
        receivers:
          - apache_access
          - apache_error
EOF

sudo service google-cloud-ops-agent restart
sleep 60
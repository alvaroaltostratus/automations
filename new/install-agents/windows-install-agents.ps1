# Instalar OPS-AGENT
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.ps1", "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1")
Invoke-Expression "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1 -AlsoInstall"

# Instalar OS-CONFIG-AGENT
googet -noconfirm install google-osconfig-agent

Start-Sleep -s 5

# Instalar Antivirus


# Configurar IIS
Copy-Item -Path 'C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml' -Destination 'C:\Program Files\Google\Cloud Operations\Ops Agent\config\config.yaml.bak'

# Configure the Ops Agent.
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

Start-Sleep -s 5

Stop-Service google-cloud-ops-agent -Force
Start-Service google-cloud-ops-agent* 
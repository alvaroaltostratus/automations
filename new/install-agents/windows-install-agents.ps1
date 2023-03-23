# Instalar OPS-AGENT
(New-Object Net.WebClient).DownloadFile("https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.ps1", "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1")
Invoke-Expression "${env:UserProfile}\add-google-cloud-ops-agent-repo.ps1 -AlsoInstall"

# Instalar OS-CONFIG-AGENT
googet -noconfirm install google-osconfig-agent
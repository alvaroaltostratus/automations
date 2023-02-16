from google.cloud import compute_v1

SCRIPT = '\n(New-Object Net.WebClient).DownloadFile(\"https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.ps1\", \"${env:UserProfile}\\add-google-cloud-ops-agent-repo.ps1\")\n\
Invoke-Expression \"${env:UserProfile}\\add-google-cloud-ops-agent-repo.ps1 -AlsoInstall\"'

if __name__ == '__main__':
    instance_client = compute_v1.InstancesClient()
    instance_list = instance_client.list(project="ecoprensa-servicios", zone="europe-west1-b")

    for instance in instance_list:
        current_metadata = instance.metadata

        for metadata in current_metadata.items:
            if metadata.key == "sysprep-specialize-script-ps1":
                metadata.value = metadata.value + SCRIPT

        instance_client.set_metadata(project="ecoprensa-servicios", zone="europe-west1-b", instance=instance.name, metadata_resource=current_metadata)
        print(f"+ Metadata cambiada en {instance.name}")

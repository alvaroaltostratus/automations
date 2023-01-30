import tfvars
import json

from google.cloud import compute_v1

if __name__ == "__main__":
    # Importo las variables de la configuración de terraform
    tfv = tfvars.LoadSecrets('../terraform/terraform.tfvars')

    # Crea la instancia para usar la API de los discos, modificar luego para usar un .json con las credenciales
    disks_client = compute_v1.DisksClient()
    request = disks_client.aggregated_list(project=tfv["project_id"])
    disks = {"disks": []}

    # Agrego todos los discos de todas las zonas que se están usando
    for zone, response in request:
        if response.disks:
            for disk in response.disks:
                disks["disks"].append({
                    "name": disk.name,
                    "zone": zone.split("/")[-1],
                })
    
    # Guardo todos los discos en un archivo .json
    json.dump(disks, open("disks.json", "w"))
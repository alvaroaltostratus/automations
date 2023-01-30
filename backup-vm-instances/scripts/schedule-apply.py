import logging
import tfvars

from google.cloud import compute_v1

if __name__ == "__main__":
    # Importo las variables de la configuración de terraform
    tfv = tfvars.LoadSecrets('../terraform/terraform.tfvars')

    # Crea la instancia para usar la API de los discos, modificar luego para usar un .json con las credenciales
    disks_client = compute_v1.DisksClient()
    request = disks_client.aggregated_list(project=tfv["project_id"])
    disks = []

    # Agrego todos los discos de todas las zonas que se están usando
    for zone, response in request:
        if response.disks:
            for disk in response.disks:
                disks.append({
                    "name": disk.name,
                    "zone": zone.split("/")[-1],
                })

    # Itero sobre los discos disponibles
    for disk in disks:
        disk = disks_client.get(disk=disk["name"], zone=disk["zone"], project=tfv["project_id"])
        hasPolicy: bool = len(disk.resource_policies) >= 1

        # Si no tiene politica-estandar la agrego
        if not hasPolicy:
            try:
                disks_client.add_resource_policies(
                    disk = disk.name,
                    zone = disk.zone.split("/")[-1],
                    project = tfv["project_id"],
                    disks_add_resource_policies_request_resource = {
                        "resource_policies": [ f"projects/{tfv['project_id']}/regions/{tfv['region']}/resourcePolicies/politica-estandar" ]
                    }
                )
                print(f"Agregada politica-estandar al disco {disk.name}")
            except Exception as e:
                logging.error(e)
        else:
            print(f"El disco {disk.name} ya tiene un schedule policy")
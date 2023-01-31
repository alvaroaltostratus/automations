# Automations

## Antivirus (en proceso)

### Requerimientos
1. Terraform (https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
2. Terraformer (https://github.com/GoogleCloudPlatform/terraformer)
3. Python (https://www.python.org/downloads/)
---
### Ejecución
1. Ve a la carpeta "antivirus/terraform-new"
2. Cambia el archivo `terraform.tfvars` y cambia el proyecto y la región
3. Ejecuta `terraform init` y `terraform apply --auto-approve`
4. Ve a la carpeta "antivirus/terraform-import"
5. Ejecuta `terraformer import google -r instances -z <región> --projects <proyecto> -p "{service}"-C -O json`
6. Ve a la carpeta "scripts"
7. Ejecuta `python antivirus.py`
---

## Backup de instancias de Compute Engine

### Requerimientos
1. Terraform (https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli)
2. Python (https://www.python.org/downloads/)
---
### Ejecución
1. Ve a la carpeta "backup-vm-instances/terraform"
2. Cambia el archivo `terraform.tfvars` y cambia el proyecto y la región
3. Ve a la carpeta "backup-vm-instances"
4. Ejecuta `./execute.sh`
---
